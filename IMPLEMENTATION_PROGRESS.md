# IMPLEMENTATION PROGRESS - 401 FIX + UI BRUTALISM
**Date:** 2026-06-13  
**Status:** In Progress

---

## ✅ COMPLETED

### Phase 1: Authorization Token Fix
- [x] Updated `SplashPage` to restore token from storage on app startup
  - Calls `_restoreTokenAndCheckAuth()` in initState
  - Gets saved token from AuthRepository
  - Sets token to ApiClient via `setApiToken()`
  - Then checks auth state with AuthBloc

**How it works:**
```
App Start
  ↓
SplashPage.initState()
  ↓
_restoreTokenAndCheckAuth()
  ├─ Get saved token from storage
  ├─ If token exists → setApiToken(token)
  └─ Check auth state with AuthBloc
  ↓
Token is now in ApiClient headers
  ↓
All API calls (account, topup, transfer) will have Authorization header
```

**Result:** 401 errors should be resolved ✅

---

## 📋 TODO - UI BRUTALISM REDESIGN

### Phase 2: Colors & Core Components
- [ ] Update `app_colors.dart`
  - Remove gradients
  - Remove surface colors (primarySurface, greenSurface, etc.)
  - Keep only: primary, green, amber, red, ink, bg, white
  
- [ ] Update `app_button.dart` widget
  - Remove rounded corners (borderRadius: 0)
  - Add thick border (2px)
  - Remove shadow
  - Increase padding
  - Bold text (16px, weight 700)

- [ ] Update `app_field.dart` widget
  - Square corners (borderRadius: 0)
  - Thick border (2px)
  - Remove shadow
  - Bold label text

- [ ] Update `app_theme.dart`
  - Remove gradients from theme
  - Use solid colors
  - Remove shadows
  - Bold typography

### Phase 3: Pages - Typography Focus
- [ ] `splash_page.dart`
  - Remove gradient background
  - Use solid primary color
  - Increase title font size (40px+)
  - Remove decorative circles
  - Bold heading + tagline
  - Full-width loading bar

- [ ] `login_page.dart`
  - Remove gradient
  - Thick borders on buttons (2px)
  - Bold text (18px+)
  - Square corners
  - High contrast

- [ ] `home_page.dart`
  - Remove gradient header
  - Use solid primary color block
  - Replace cards with bordered blocks
  - Full-width dividers
  - Bold section headers

### Phase 4: Pages - Interaction Focus
- [ ] `topup_page.dart`
  - Grid of amount blocks with borders
  - Square buttons
  - Bold amounts (18px)
  - Stark fee display

- [ ] `transfer_page.dart` (all 3 pages)
  - Block-based layout
  - Stark sections with dividers
  - Square buttons
  - Bold text

- [ ] `pin_page.dart`
  - Dark background
  - Large number pad
  - Thick borders
  - White/light text on dark

- [ ] `success_page.dart`
  - Bold checkmark (64px)
  - Block layout
  - Clear dividers
  - Stacked CTAs

### Phase 5: Testing & Refinement
- [ ] Build and test on device
- [ ] Verify all pages render correctly
- [ ] Check high contrast on small screens
- [ ] Verify touch targets (48px+)
- [ ] Test on different orientations

---

## 📊 FILES TO MODIFY

**Core:**
- `lib/core/theme/app_colors.dart` - Remove gradients, surfaces
- `lib/core/theme/app_theme.dart` - Remove shadows, gradients
- `lib/presentation/widgets/app_button.dart` - Square, thick borders
- `lib/presentation/widgets/app_field.dart` - Square, stark border

**Pages:**
- `lib/presentation/pages/splash/splash_page.dart` ✅ Started (token fix)
- `lib/presentation/pages/auth/login_page.dart`
- `lib/presentation/pages/home/home_page.dart`
- `lib/presentation/pages/topup/topup_page.dart`
- `lib/presentation/pages/transfer/transfer_page.dart`
- `lib/presentation/pages/transfer/transfer_amount_page.dart`
- `lib/presentation/pages/transfer/transfer_confirm_page.dart`
- `lib/presentation/pages/payment/pin_page.dart`
- `lib/presentation/pages/success/success_page.dart`

---

## 🎯 NEXT IMMEDIATE ACTIONS

1. **Test 401 Fix First**
   - Build and run app
   - Try login → topup flow
   - Verify API calls have Authorization header
   - Check if 401 errors gone

2. **If 401 Fixed:**
   - Proceed with UI brutalism redesign
   - Start with colors + core components
   - Then update pages one by one
   - Test each page before moving to next

3. **If 401 Still Occurs:**
   - Check ApiClient debug logs
   - Verify token was actually saved
   - Trace through flow again

---

## 💡 IMPLEMENTATION NOTES

**Key Points:**
- Token restoration happens BEFORE auth check
- Only need to update UI once auth flow is working
- UI changes are mostly styling (safe to iterate)
- No logic changes needed for brutalism
- Test on real device to see actual borders/spacing

**Design System Impact:**
- Remove gradient pattern across entire app
- All buttons become square + bordered
- All inputs become stark + bordered
- Headers become solid color blocks
- Content areas use simple dividers

---

## 📝 READY FOR NEXT STEP?

**Current Status:**
✅ 401 token fix in SplashPage  
⏳ Waiting to test on device  
⏳ UI brutalism redesign pending

**What happens next:**
1. User tests the 401 fix
2. If working → proceed with UI brutalism
3. If not → debug token flow

**Approval needed for:**
- Test 401 fix on your device?
- Proceed with UI redesign?
- Any changes to the plan?

