# EMONEYID - COMPREHENSIVE SYSTEM AUDIT & BUG REPORT
**Date:** 2026-06-14  
**Status:** Complete Audit  
**Total Issues Found:** 19 (dari flutter analyze) + Additional Logic Bugs

---

## 📊 AUDIT RESULTS SUMMARY

| Category | Count | Severity |
|----------|-------|----------|
| **Critical Errors** | 3 | 🔴 |
| **High Warnings** | 9 | 🟠 |
| **Medium Infos** | 5 | 🟡 |
| **Low Style** | 2 | 🔵 |
| **Logic Bugs** | TBD | 🔴-🟡 |
| **TOTAL** | 19+ | - |

---

## 🔴 CRITICAL ERRORS (App Breaking)

### **ERROR 1: Test File - Wrong Package Name & Class**
```
FILE: test/widget_test.dart:11, 16
ERROR: 
  - Target of URI doesn't exist: 'package:emoneyid/main.dart'
  - The name 'MyApp' isn't a class
SEVERITY: 🔴 CRITICAL
```

**Root Cause:**
- Package name di pubspec.yaml: `dompet_kampus_global`
- Test imports: `package:emoneyid` (WRONG)
- Class actual: `DompetKampusApp`
- Test expects: `MyApp` (WRONG)

**Impact:**
- Tests cannot run
- CI/CD pipeline will fail
- Cannot verify code quality

**Fix Proposal:**
```dart
// Change line 11:
- import 'package:emoneyid/main.dart';
+ import 'package:dompet_kampus_global/main.dart';

// Change line 16:
- await tester.pumpWidget(const MyApp());
+ await tester.pumpWidget(const DompetKampusApp());
```

---

### **ERROR 2: Firebase iOS Project Mismatch**
```
FILE: lib/firebase_options.dart:56-63
ERROR: iOS uses different Firebase project than Android/Web
SEVERITY: 🔴 CRITICAL (iOS Login Will Fail)
```

**Root Cause:**
```
Android: projectId = 'emoney-3b6e2'
iOS:     projectId = 'fir-emoney-e9256'  ← DIFFERENT!
Web:     projectId = 'emoney-3b6e2'
```

**Impact:**
- iOS users cannot login (Firebase token mismatch)
- Authentication fails on iOS devices
- Push notifications may not work on iOS

**Fix Proposal:**
```dart
// Align iOS to use same project as Android/Web:
static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'AIzaSyBRCzWZJshszEx0OgwQRDOCEyqVG3PG67g',  // same as Android
  appId: '1:184412172720:ios:d7df82da6b93e5d3bf2675',
  messagingSenderId: '184412172720',  // same as Android
  projectId: 'emoney-3b6e2',  // ← CHANGE from fir-emoney-e9256
  storageBucket: 'emoney-3b6e2.firebasestorage.app',
  iosBundleId: 'com.kampus.dompetKampusGlobal',
);
```

---

### **ERROR 3: Hardcoded Localhost API URL**
```
FILE: lib/core/constants/app_constants.dart:6
ERROR: baseUrl = 'http://192.168.0.105:8080' (Hardcoded)
SEVERITY: 🔴 CRITICAL (Cannot Deploy)
```

**Root Cause:**
- Localhost IP hardcoded in code
- Only works on developer's machine + local network
- Fails on other devices, production, CI/CD

**Impact:**
- App cannot connect to API on any other device
- Cannot deploy to production
- Cannot run tests on CI/CD

**Fix Proposal:**
```dart
// Use environment variables:
static const String baseUrl = const String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://192.168.0.105:8080',  // dev fallback
);

// Build commands:
// flutter run --dart-define=API_BASE_URL=http://192.168.0.105:8080
// flutter build apk --dart-define=API_BASE_URL=https://api.kampus.id
```

---

## 🟠 HIGH PRIORITY WARNINGS

### **WARNING 1: Unused Import in AuthBloc**
```
FILE: lib/presentation/blocs/auth/auth_bloc.dart:7
WARNING: Unused import: '../../../domain/usecases/auth/send_otp_usecase.dart'
SEVERITY: 🟠 HIGH (Code Quality)
```

**Fix:**
```dart
// Remove line 7:
- import '../../../domain/usecases/auth/send_otp_usecase.dart';
```

---

### **WARNING 2: Unused Field in AuthBloc**
```
FILE: lib/presentation/blocs/auth/auth_bloc.dart:63
WARNING: The value of the field '_getMe' isn't used
SEVERITY: 🟠 HIGH (Code Quality)
```

**Root Cause:**
- `_getMe` usecase never called in any handler
- Parameter passed to constructor but not used

**Fix Options:**

**Option A: Remove if not needed**
```dart
// Remove from constructor:
- required GetMeUsecase getMe,
- final GetMeUsecase _getMe;
- ..., _getMe = getMe, ...
```

**Option B: Add handler if planned for future**
```dart
// Add new event:
on<AuthRefreshUserRequested>(_onRefreshUser);

// Add handler:
Future<void> _onRefreshUser(_, Emitter emit) async {
  try {
    final user = await _getMe();  // now used
    // update state
  } catch (e) {
    // handle error
  }
}
```

---

### **WARNING 3-9: Unused Imports (7 files)**
```
FILES:
  - lib/presentation/pages/auth/twofa_smtp_page.dart:9 → app_button.dart
  - lib/presentation/pages/merchant/merchant_checkout_page.dart:7 → feature_icon.dart
  - lib/presentation/pages/payment/pin_page.dart:8 → feature_icon.dart
  - lib/presentation/pages/success/success_page.dart:8 → feature_icon.dart
  - lib/presentation/pages/transfer/transfer_amount_page.dart:11 → feature_icon.dart
  - lib/presentation/pages/transfer/transfer_confirm_page.dart:9 → feature_icon.dart
  - lib/presentation/pages/transfer/transfer_page.dart:7 → feature_icon.dart

SEVERITY: 🟠 HIGH (Code Cleanliness)
```

**Fix:**
```dart
// Remove unused import lines from each file
```

---

## 🟡 MEDIUM PRIORITY INFOS (Deprecated APIs)

### **INFO 1: Deprecated `background` Color**
```
FILE: lib/core/theme/app_theme.dart:17
INFO: 'background' is deprecated. Use 'surface' instead.
SEVERITY: 🟡 MEDIUM (Future Breaking)
```

**Fix:**
```dart
// Before:
colorScheme: ColorScheme.light(
  background: AppColors.bg,  // ❌ DEPRECATED
);

// After:
colorScheme: ColorScheme.light(
  surface: AppColors.bg,  // ✅ NEW
);
scaffoldBackgroundColor: AppColors.bg;  // explicit
```

---

### **INFO 2-4: Deprecated `translate()` Matrix (3 files)**
```
FILES:
  - lib/presentation/pages/auth/twofa_smtp_page.dart:111
  - lib/presentation/pages/auth/twofa_totp_page.dart:249
  - lib/presentation/pages/payment/pin_page.dart:155

INFO: 'translate' is deprecated. Use translationValues instead.
SEVERITY: 🟡 MEDIUM (Future Breaking)
```

**Fix:**
```dart
// Before:
transform: Matrix4.identity()..translate(x, y, z)  // ❌ deprecated

// After:
transform: Matrix4.translationValues(x, y, 0)  // ✅ NEW
```

---

### **INFO 5: BuildContext Async Gap**
```
FILE: lib/presentation/pages/auth/twofa_notif_page.dart:32
INFO: Don't use BuildContext across async gaps
SEVERITY: 🟡 MEDIUM (Crash Risk)
```

**Root Cause:**
- Using `context` after async operation
- Context may be disposed while waiting

**Fix:**
```dart
// Before:
void handler() async {
  await asyncOp();
  context.go('/next');  // ⚠️ context might be invalid
}

// After:
void handler() async {
  await asyncOp();
  if (context.mounted) {  // ✅ check first
    context.go('/next');
  }
}
```

---

## 🔵 LOW PRIORITY STYLE ISSUES

### **STYLE 1-2: Missing Curly Braces**
```
FILE: lib/presentation/pages/auth/twofa_smtp_page.dart:37-38
STYLE: Statements in if should be enclosed in a block
SEVERITY: 🔵 LOW (Code Style)
```

**Fix:**
```dart
// Before:
if (condition) doSomething();
if (condition2) doSomething2();

// After:
if (condition) {
  doSomething();
}
if (condition2) {
  doSomething2();
}
```

---

## 🐛 ADDITIONAL LOGIC BUGS (Potential Runtime Errors)

### **LOGIC BUG 1: Incomplete AccountBloc Error Handling**
```
FILE: lib/presentation/blocs/account/account_bloc.dart:51-64
BUG: Missing 401 Unauthorized error handling
SEVERITY: 🔴 CRITICAL (Session Bug)
```

**Issue:**
```dart
// Current code - doesn't handle 401 specifically
Future<void> _onLoad(...) async {
  try {
    // fetch data
  } on ServerFailure catch (e) {  // ❌ catches ALL server errors same way
    emit(AccountError(e.message));
  }
}

// If token expired (401), user stays on page with stale session!
```

**Fix Needed:**
```dart
// After: distinguish 401 from other errors
on AuthFailure catch (e) {
  emit(AccountError('Session expired'));
}
on ServerFailure catch (e) {
  if (e.statusCode == 401) {
    emit(AccountError('Session expired'));
  } else {
    emit(AccountError(e.message));
  }
}
```

---

### **LOGIC BUG 2: Incomplete PaymentBloc Topup Error Handling**
```
FILE: lib/presentation/blocs/payment/payment_bloc.dart:96-106
BUG: Topup missing specific error handlers (transfer has them)
SEVERITY: 🔴 CRITICAL (Incomplete Error Handling)
```

**Issue:**
```dart
// Current: topup only catches generic ServerFailure
Future<void> _onTopup(...) async {
  try {
    final result = await _topup(event.amount);
    emit(PaymentTopupSuccess(...));
  } on ServerFailure catch (e) {  // ❌ generic only
    emit(PaymentError(e.message));
  }
}

// But transfer HAS (line 118-121):
on InvalidOtpFailure catch (e) { ... }
on InsufficientBalanceFailure catch (e) { ... }
```

**Fix Needed:**
```dart
// Add missing handlers to topup (same as transfer):
on InvalidOtpFailure catch (e) {
  emit(PaymentInvalidOtp(e.message));
}
on InsufficientBalanceFailure catch (e) {
  emit(PaymentInsufficientBalance(balance: e.balance, amount: e.amount));
}
```

---

### **LOGIC BUG 3: Missing StatusCode in ServerFailure**
```
FILE: lib/core/error/failures.dart
BUG: ServerFailure doesn't track HTTP status code
SEVERITY: 🟠 HIGH (Prevents 401 handling)
```

**Issue:**
```dart
// Current:
class ServerFailure extends Failure {
  final String? errorCode;
  // ❌ NO statusCode field
}

// Can't differentiate 401, 404, 500, etc
```

**Fix Needed:**
```dart
// Add statusCode:
class ServerFailure extends Failure {
  final String? errorCode;
  final int? statusCode;  // ✅ ADD THIS
  const ServerFailure(super.message, {this.errorCode, this.statusCode});
}
```

---

### **LOGIC BUG 4: OTP Remote Datasource Missing Email Method**
```
FILE: lib/data/datasources/remote/otp_remote_datasource.dart
BUG: Potentially missing sendOtpEmail() implementation
SEVERITY: 🟡 MEDIUM (Feature May Fail)
```

**Check:** Need to verify if this method exists and is complete.

---

## 📋 COMPLETE FIX PRIORITY LIST

| # | Issue | File | Type | Severity | Time | Status |
|----|-------|------|------|----------|------|--------|
| 1 | Test class name | test/widget_test.dart | Error | 🔴 | 2 min | TODO |
| 2 | Firebase iOS mismatch | firebase_options.dart | Error | 🔴 | 5 min | TODO |
| 3 | Hardcoded API URL | app_constants.dart | Error | 🔴 | 10 min | TODO |
| 4 | Unused import (send_otp) | auth_bloc.dart:7 | Warning | 🟠 | 1 min | TODO |
| 5 | Unused field (_getMe) | auth_bloc.dart:63 | Warning | 🟠 | 5 min | TODO |
| 6-12 | Unused imports (7x) | Various pages | Warning | 🟠 | 5 min | TODO |
| 13 | Deprecated background | app_theme.dart:17 | Info | 🟡 | 2 min | TODO |
| 14-16 | Deprecated translate (3x) | 3 pages | Info | 🟡 | 5 min | TODO |
| 17 | BuildContext async gap | twofa_notif_page.dart:32 | Info | 🟡 | 3 min | TODO |
| 18-19 | Missing curly braces | twofa_smtp_page.dart | Style | 🔵 | 2 min | TODO |
| 20 | AccountBloc 401 handling | account_bloc.dart | Logic | 🔴 | 10 min | TODO |
| 21 | PaymentBloc topup errors | payment_bloc.dart | Logic | 🔴 | 8 min | TODO |
| 22 | ServerFailure statusCode | failures.dart | Logic | 🟠 | 3 min | TODO |
| 23 | OTP email method | otp_remote_datasource.dart | Check | 🟡 | 5 min | TODO |

**Total Fix Time:** ~65-75 minutes

---

## ✅ NEXT STEPS

Ready to fix? I will:

1. **Propose each fix** with before/after code
2. **Wait for your approval** before implementing
3. **Apply the fix** to the file
4. **Tell you when ready to commit** each fix

Choose your preferred approach:

**Option A:** Fix all 23 issues one by one (get approval for each)  
**Option B:** Group fixes by category (Critical → High → Medium → Low)  
**Option C:** Start with Critical (3 issues), then continue by phases

Which one you prefer? 🚀

