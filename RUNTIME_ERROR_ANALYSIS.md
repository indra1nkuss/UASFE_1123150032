# RUNTIME ERROR ANALYSIS - EMONEYID
**Date:** 2026-06-13  
**Issue:** 401 Unauthorized - "Authorization header diperlukan"

---

## 🔴 ROOT CAUSE ANALYSIS

### Error Log Breakdown
```
Status: 401 Unauthorized
Endpoint: http://192.168.0.105:8080/v1/account
Message: "Authorization header diperlukan"
```

### The Problem Chain

1. **User Login Flow:**
   - User logs in → AuthBloc emits `AuthAuthenticated`
   - JWT token received dari backend
   - Token seharusnya disimpan & di-set ke ApiClient

2. **Where It Breaks:**
   - ✅ AuthBloc state = `AuthAuthenticated` (login berhasil)
   - ❌ JWT token TIDAK ter-set di ApiClient headers
   - ❌ API calls (account, topup, transfer) kirim request TANPA Authorization header
   - ❌ Backend reject dengan 401

3. **Why Token Not Set:**

Looking at the flow:
```dart
// auth_bloc.dart - _onLoginWithFirebase
final result = await _verifyToken(event.firebaseToken);
emit(AuthNeedsVerification(result.user, result.token));
// ✅ Token diterima, tapi belum di-set ke ApiClient
```

```dart
// auth_repository_impl.dart - verifyFirebaseToken
final result = await _remote.verifyFirebaseToken(firebaseToken);
await _local.saveToken(result.token);
// ✅ Token disimpan di storage
```

```dart
// auth_remote_datasource.dart - verifyFirebaseToken
_client.setAuthToken(token);  // ✅ Set ke ApiClient
return (user: user, token: token);
```

**Masalahnya:** Token SET di datasource, tapi setelah 2FA verification, token TIDAK di-set lagi ke ApiClient saat transisi ke `AuthAuthenticated` state.

---

## 🎯 ROOT CAUSE

**Missing Step:** Setelah 2FA verified → AuthBloc emit `AuthAuthenticated` → Token PERLU di-set ke ApiClient lagi!

Flow yang benar:
```
1. User login → verify Firebase token
2. Set token ke ApiClient (✅ terjadi)
3. Go to 2FA page
4. 2FA verified → AuthBloc emit AuthAuthenticated
5. ❌ MISSING: Set token ke ApiClient lagi!
6. Access account/topup endpoints (dengan token)
```

---

## 🔧 SOLUTIONS

### Solution 1: Set Token When AuthAuthenticated (Quick Fix)
**File:** `lib/presentation/pages/splash/splash_page.dart` or main listener

```dart
// Listen to AuthBloc
if (state is AuthAuthenticated) {
  final token = await authRepo.getSavedToken();
  if (token != null) {
    setApiToken(token);  // Set token to ApiClient
  }
}
```

### Solution 2: Set Token in OTP 2FA Verification (Recommended)
**File:** `lib/presentation/pages/auth/twofa_totp_page.dart` (after 2FA success)

```dart
Future<void> _onVerifySuccess() async {
  final token = await _authRepo.getSavedToken();
  if (token != null) {
    setApiToken(token);  // Di-set dari injection_container
  }
  context.go('/home');
}
```

### Solution 3: Auto-Set Token on App Resume (Best Practice)
**File:** `lib/main.dart` atau `lib/presentation/pages/splash/splash_page.dart`

```dart
void initState() {
  super.initState();
  _checkAndRestoreToken();
}

Future<void> _checkAndRestoreToken() async {
  final token = await authRepo.getSavedToken();
  if (token != null) {
    setApiToken(token);  // Restore token from storage
  }
  // Then check auth state...
}
```

---

## 📊 ACTUAL FLOW VS EXPECTED

### Current (Broken):
```
Login → Firebase Token OK → Set Token to ApiClient ✅
                         ↓
                    2FA Page (token still in ApiClient)
                         ↓
                 2FA Verified → AuthAuthenticated ✅
                         ↓
              Go to /home → Account Page ❌
                    ↓
        Try GET /account (NO Authorization header!)
                    ↓
              401 Unauthorized
```

### Fixed:
```
Login → Firebase Token OK → Set Token to ApiClient ✅
                         ↓
                    2FA Page
                         ↓
                 2FA Verified → AuthAuthenticated ✅
                         ↓
        Set Token to ApiClient from Storage ✅
                         ↓
              Go to /home → Account Page ✅
                    ↓
        Try GET /account (WITH Authorization header!)
                    ↓
              200 OK - Data loaded ✅
```

---

## 🛠️ RECOMMENDED FIX

**Priority:** HIGH

**Approach:** Set token on app startup (SplashPage) dari saved storage

1. SplashPage checks saved token
2. If exists → restore ke ApiClient
3. Check auth state
4. Navigate accordingly

**Why:** Jika user close app dan re-open, token masih di storage tapi tidak ter-restore ke ApiClient.

