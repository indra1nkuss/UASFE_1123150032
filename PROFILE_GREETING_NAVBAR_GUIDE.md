# 🎨 PROFILE GREETING & BRUTALISM NAVBAR IMPLEMENTATION GUIDE
**Date:** 2026-06-13  
**Status:** Ready to implement in home_page.dart

---

## 📁 2 FILE BARU YANG SUDAH DIBUAT

### 1️⃣ `lib/presentation/widgets/profile_greeting_widget.dart` 🆕
**Features:**
- Profile circle dengan foto dari `assets/images/profile.png`
- Gradient border glow animation (pulsate 2 detik)
- Dynamic greeting: "Selamat Pagi/Siang/Sore/Malam" berdasar jam WIB
- Icon yang berubah sesuai waktu (sun/cloud/moon)
- Fade-in animation saat pertama kali load
- Fallback ke initial "I" jika foto tidak ada

**Time Logic:**
- 05:00 - 11:59 → "Selamat Pagi" (sun icon)
- 12:00 - 14:59 → "Selamat Siang" (sun icon)
- 15:00 - 17:59 → "Selamat Sore" (cloud icon)
- 18:00 - 04:59 → "Selamat Malam" (moon icon)

**Animasi:**
- Gradient border: Glow pulsate (0.5 → 1.0 opacity, 2 detik repeat)
- Greeting text: Fade in (800ms, easeIn)
- Shadow: Pulsate dengan glow

---

### 2️⃣ `lib/presentation/widgets/brutalism_nav_bar.dart` 🆕
**Features:**
- Bottom navbar dengan 4 item: Home, History, Scan, Profile
- Brutalism design (square borders, thick lines)
- Active state: Gold color + scale animation + bottom border
- Inactive state: Slate color, no border
- Smooth animations (300ms per state change)
- Scale animation (1.0 → 1.08x) when active
- Bottom border animates in/out (0 → 2.5px)

**Design:**
- Stark 2px top border (charcoal)
- Icons: 28px, weight changes on active
- Labels: 11px, bold when active
- Colors: Gold (active) / Slate (inactive)

---

## 🔧 CARA IMPLEMENT DI HOME PAGE

### Step 1: Import Widget di `home_page.dart`
```dart
import '../../widgets/profile_greeting_widget.dart';
import '../../widgets/brutalism_nav_bar.dart';
```

### Step 2: Update HomePage State (jika Stateful)
```dart
class _HomePageState extends State<HomePage> {
  int _currentNavIndex = 0;  // Tambah variable ini
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      // ... existing code
      bottomNavigationBar: BrutalismNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          // Handle navigation ke page lain
        },
      ),
    );
  }
}
```

### Step 3: Tambah ProfileGreetingWidget di Top
```dart
// Di dalam body, paling atas:
Padding(
  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
  child: const ProfileGreetingWidget(),
),
```

---

## 📦 ASSET YANG DIPERLUKAN

### Buat folder dan file:
```
assets/
  images/
    profile.png  ← Foto profil Indra (ukuran: 200x200px recommended)
```

### Update `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/profile.png
```

---

## 🎨 VISUAL APPEARANCE

### Profile Greeting Widget:
```
┌─────────────────────────────────────┐
│ [PROFILE CIRCLE]  Selamat Siang ☀️  │
│ (glow animation)  Indra             │
│                                     │
│ Gradient border dengan              │
│ pulsating glow effect               │
└─────────────────────────────────────┘
```

### Bottom Navbar (Brutalism):
```
════════════════════════════════════════  ← 2px border (charcoal)
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ 🏠   │ │ 📜   │ │ 📱   │ │ 👤   │
│ Home │ │Hist. │ │ Scan │ │Prof. │
└──────┘ └──────┘ └──────┘ └──────┘
═════════════════════════════════════════
│ Active (Home) = Gold color + border  │
│ Inactive = Slate color, no border    │
│ Smooth scale animation on click      │
└───────────────────────────────────────┘
```

---

## ⚙️ CONFIGURATION OPTIONS

### Customize Profile Size:
Di `profile_greeting_widget.dart`, ubah:
```dart
width: 88,      // Ganti ke size lain
height: 88,
```

### Customize Greeting Times:
```dart
if (hour >= 5 && hour < 12) {      // Ubah 5 → jam berapa mulai pagi
  _greeting = 'Selamat Pagi';
}
```

### Customize Glow Speed:
```dart
duration: const Duration(seconds: 2),  // Ubah 2 → lebih cepat/lambat
```

### Customize Navbar Items:
```dart
_NavBarItem(
  icon: Icons.home_outlined,        // Ganti icon
  label: 'Home',                     // Ganti label
  isActive: widget.currentIndex == 0,
  onTap: () => widget.onTap(0),
),
```

---

## 🎯 ANIMATIONS EXPLAINED

### Profile Glow Animation:
- Type: Pulsating shadow + border opacity
- Duration: 2 seconds (repeat forever)
- Effect: Elegant breathing effect
- Colors: Gold accent with alpha variation

### Greeting Animation:
- Type: Fade in
- Duration: 800ms
- Effect: Smooth appearance on load
- Curve: Eases In

### Navbar Active Animation:
- Type: Scale + border animation
- Duration: 300ms
- Scale: 1.0 → 1.08 (8% bigger when active)
- Border: Animates from 0 → 2.5px
- Curve: EaseInOut (smooth in and out)

---

## 📝 INTEGRATION CHECKLIST

- [ ] Copy `profile_greeting_widget.dart` to lib/presentation/widgets/
- [ ] Copy `brutalism_nav_bar.dart` to lib/presentation/widgets/
- [ ] Create `assets/images/` folder
- [ ] Add `profile.png` (your photo) to assets/images/
- [ ] Update `pubspec.yaml` with assets section
- [ ] Import widgets in `home_page.dart`
- [ ] Add ProfileGreetingWidget at top of body
- [ ] Add BrutalismNavBar to bottomNavigationBar
- [ ] Test greeting updates (check at different times)
- [ ] Test navbar animations (click each item)
- [ ] Verify glow effect is visible
- [ ] Run `flutter pub get` after pubspec changes

---

## ✨ EXPECTED RESULT

**On App Load:**
1. Profile circle appears with gradient glow
2. Greeting fades in with correct time-based message
3. Icon matches current time period
4. Name "Indra" displays below greeting

**On Time Change:**
- Greeting automatically updates (no refresh needed)
- Icon changes to match new time
- Color remains elegant gold accent

**On Navbar Click:**
- Selected item scales up slightly (1.08x)
- Bottom border animates in (gold color)
- Icon color changes to gold
- Label becomes bold
- Smooth 300ms transition

---

## 🚀 NO API/LOGIC CHANGES

- ✅ Pure UI/UX enhancement
- ✅ No backend changes
- ✅ No state management changes
- ✅ No business logic modifications
- ✅ Works with existing auth system

---

## 📸 PHOTO REQUIREMENTS

**For profile.png:**
- Format: PNG, JPG, or any supported image
- Size: 200x200px recommended (will be clipped to circle)
- Quality: Good clarity (will be shown at ~80px diameter)
- Type: Portrait photo (face visible)

---

**READY TO COMMIT & IMPLEMENT!** 🎨

