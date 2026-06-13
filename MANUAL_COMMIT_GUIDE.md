# 📋 COMPLETE FILE CHANGES SUMMARY - 2026-06-13
**Purpose:** Manual commit guide di VS Code terminal  
**Total Commits:** 14 commits  
**Total Files Changed:** 8 files

---

## 🔍 FILES YANG DI-UPDATE/DI-TAMBAH

### 1️⃣ `lib/core/theme/app_colors.dart` ✏️ MODIFIED
**Status:** Modified (warna theme)  
**Changes:**
- Ganti primary dari `#0B63E5` (blue) → `#2C3E50` (charcoal)
- Ganti accent dari green → `#FFD700` (bright gold)
- Rename success, warning, error, info ke warna lebih cerah
- Hapus surface colors (primarySurface, greenSurface, dll)
- Tambah alias untuk backward compatibility
- Ubah gradient ke solid color

**Commit Message:**
```
theme: Apply brutalism with premium colors & Update colors for brightness
```

---

### 2️⃣ `lib/core/theme/app_theme.dart` ✏️ MODIFIED
**Status:** Modified (theme configuration)  
**Changes:**
- Update colorScheme dengan warna baru
- AppBar: background charcoal, icon/text gold
- Buttons: gold background, charcoal text, thick 2.5px border
- Inputs: 2px thick borders, square corners (borderRadius: 0)
- Text styles: bold weight 800, increased sizes
- Remove shadows, remove gradients

**Commit Message:**
```
theme: Improve brutalism colors - brighter & clearer
```

---

### 3️⃣ `lib/presentation/pages/splash/splash_page.dart` ✏️ MODIFIED
**Status:** Modified (tambah token restoration)  
**Changes:**
- Import `AuthRepository` untuk get saved token
- Add method `_restoreTokenAndCheckAuth()`
- Get token dari storage di initState
- Set token ke ApiClient sebelum auth check
- Fix 401 authorization error

**Commit Message:**
```
fix: Restore JWT token on app startup to fix 401 authorization errors
```

---

### 4️⃣ `lib/presentation/widgets/feature_icon.dart` ✏️ MODIFIED
**Status:** Modified (update ke brutalism 3D)  
**Changes:**
- Add parameter `brutalism3d` (default true)
- Implement 3D beveled edges (white top-left, charcoal bottom-right)
- Add shadow depth effect
- Square corners (borderRadius: 0)
- Update size default dari 52 → 80
- Tambah 80+ icon definitions (topup, qris, pulsa, food, transfer, dll)
- Rename icons ke camelCase (phone_lightning → phoneLightning)

**Commit Message:**
```
feat: Update feature_icon to brutalism 3D style
```

---

### 5️⃣ `lib/presentation/widgets/brutalism_3d_icon.dart` 🆕 NEW FILE
**Status:** Created (new widget)  
**Content:**
- `Brutalism3DIcon` - 3D icon dengan beveled edges & shadow
- `Brutalism3DIconCard` - Icon card dengan label
- `PaymentActionIcon` - Payment action buttons
- `TransactionTypeIcon` - Transaction icons color-coded

**Commit Message:**
```
feat: Add brutalism 3D icon widgets for enhanced visuals
```

---

### 6️⃣ `lib/core/error/failures.dart` ✏️ MODIFIED
**Status:** Modified (add statusCode)  
**Changes:**
- Add `statusCode` field ke ServerFailure
- Update props untuk include statusCode
- Support untuk 401 error handling

**Commit Message:**
```
fix: Add statusCode to ServerFailure for better error handling
```

---

### 7️⃣ `lib/presentation/blocs/auth/auth_bloc.dart` ✏️ MODIFIED
**Status:** Modified (remove unused)  
**Changes:**
- Remove unused import: `send_otp_usecase.dart`
- Remove unused field: `_getMe`
- Update constructor untuk remove GetMeUsecase parameter

**Commit Message:**
```
fix: Remove unused imports and fields in auth_bloc
```

---

### 8️⃣ `lib/presentation/blocs/account/account_bloc.dart` ✏️ MODIFIED
**Status:** Modified (add 401 handling)  
**Changes:**
- Add specific handling untuk AuthFailure (401 session expired)
- Add statusCode check di ServerFailure
- Improve error messages

**Commit Message:**
```
fix: Improve error handling in account_bloc for 401 scenarios
```

---

## 📊 COMMIT SEQUENCE (Untuk commit di terminal)

Urutan commit yang recommended:

### Commit 1: Authorization Fix (401 Error)
```bash
git add lib/presentation/pages/splash/splash_page.dart
git commit -m "fix: Restore JWT token on app startup to fix 401 authorization errors"
```

### Commit 2: Colors Theme - Phase 1
```bash
git add lib/core/theme/app_colors.dart
git commit -m "theme: Apply brutalism with premium colors"
```

### Commit 3: Theme Configuration
```bash
git add lib/core/theme/app_theme.dart
git commit -m "theme: Improve brutalism colors - brighter & clearer"
```

### Commit 4: 3D Icon Widgets (New)
```bash
git add lib/presentation/widgets/brutalism_3d_icon.dart
git commit -m "feat: Add brutalism 3D icon widgets for enhanced visuals"
```

### Commit 5: Feature Icon Update
```bash
git add lib/presentation/widgets/feature_icon.dart
git commit -m "feat: Update feature_icon to brutalism 3D style"
```

### Commit 6: Error Handling Improvements
```bash
git add lib/core/error/failures.dart
git add lib/presentation/blocs/account/account_bloc.dart
git add lib/presentation/blocs/auth/auth_bloc.dart
git commit -m "fix: Improve error handling and remove unused code"
```

---

## 🎯 SUMMARY PERUBAHAN PER FILE

| File | Type | Perubahan Utama |
|------|------|-----------------|
| app_colors.dart | Modified | Warna baru (charcoal + gold), remove shadows |
| app_theme.dart | Modified | Theme config, square borders, bold text |
| splash_page.dart | Modified | Token restoration untuk fix 401 |
| feature_icon.dart | Modified | 3D beveled icons, 80+ definitions |
| brutalism_3d_icon.dart | NEW | Brutalism 3D widget components |
| failures.dart | Modified | Add statusCode field |
| auth_bloc.dart | Modified | Remove unused imports/fields |
| account_bloc.dart | Modified | Better 401 error handling |

---

## ✅ WHAT TO EXPECT AFTER COMMITS

### Visual Changes:
- ✅ AppBar: Charcoal background dengan gold text
- ✅ Buttons: Bright gold dengan charcoal text, thick borders
- ✅ Icons: 3D beveled dengan shadow depth
- ✅ All text: Clearly visible, high contrast
- ✅ Corners: Square (no radius)
- ✅ Borders: Thick & stark

### Functionality Changes:
- ✅ 401 errors resolved (token restoration)
- ✅ Better error handling (statusCode tracking)
- ✅ Clean code (unused imports removed)

### NO Changes:
- ❌ API endpoints - SAMA
- ❌ Business logic - SAMA
- ❌ Database - SAMA
- ❌ Navigation flow - SAMA

---

## 🔧 MANUAL COMMIT STEPS DI VS CODE TERMINAL

1. **Open terminal** di VS Code (Ctrl + `)
2. **Check status:**
   ```bash
   git status
   ```

3. **Stage file pertama:**
   ```bash
   git add lib/presentation/pages/splash/splash_page.dart
   ```

4. **Commit:**
   ```bash
   git commit -m "fix: Restore JWT token on app startup to fix 401 authorization errors"
   ```

5. **Repeat untuk file lain** sesuai urutan di atas

6. **Push ke GitHub:**
   ```bash
   git push origin main
   ```

---

## 📝 NOTES

- Setiap commit adalah independent & standalone
- Bisa commit satu2 atau sekaligus group related files
- Recommended: Follow urutan di atas untuk logical flow
- Semua commits sudah tested & clean (0 errors)

