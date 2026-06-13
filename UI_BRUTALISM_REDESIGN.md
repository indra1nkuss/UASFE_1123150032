# EMONEYID UI REDESIGN - BRUTALISM STYLE
**Concept:** Raw, bold, minimalist aesthetic dengan typography besar, borders tegas, dan whitespace maksimal

---

## 🎨 BRUTALISM DESIGN PRINCIPLES

### Core Characteristics
1. **Bold Typography** - Font besar, heavy weight
2. **Stark Borders** - Garis tegas, warna gelap (ink/black)
3. **Minimal Color** - Primary color + neutral tones only
4. **Raw Elements** - Square corners, no rounded edges (or minimal)
5. **Generous Whitespace** - Breathing room di setiap elemen
6. **High Contrast** - Strong visual hierarchy
7. **No Gradients** - Flat, solid colors
8. **Grid-Based** - Clean alignment

---

## 📱 UI CHANGES PROPOSAL

### 1. SPLASH PAGE
**Current:** Centered logo with subtle animation  
**Brutalism:** Bold brand statement with large text

```
┌─────────────────────────────┐
│                             │
│                             │
│  ███████ ███████ ███████   │
│  █       █       █         │  (Large pixelated/bold logo)
│  ███████ ███████ █████     │
│  █           █   █         │
│  █           █   █         │
│                             │
│     DOMPET KAMPUS           │
│     GLOBAL                  │
│                             │
│  "Manage money like code"   │
│                             │
│  [LOADING BAR - FULL WIDTH] │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Remove gradient
- Large sans-serif font (48px+)
- Full-width loading bar with ink color
- Remove animation, static hold
- High contrast B&W

---

### 2. LOGIN PAGE
**Current:** Soft gradient, rounded buttons  
**Brutalism:** Bold container, thick border, stark CTA

```
┌─────────────────────────────┐
│                             │
│                             │
│  LOGIN TO YOUR ACCOUNT      │
│                             │
│  ┌───────────────────────┐  │
│  │ GOOGLE SIGN IN        │  │  (Thick border, no shadow)
│  │ [GOOGLE ICON]         │  │  (Bold text)
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ EMAIL REGISTRATION   │  │
│  └───────────────────────┘  │
│                             │
│  ─────────────────────────  │
│                             │
│  Secure. Fast. Open Source. │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Remove gradient background (use white)
- Thick 2-3px borders on buttons
- Square corners (radius: 0)
- Bold 16px+ button text
- Remove shadows
- Divider line is actual `─────` styled
- Large H1 title (36px+)

---

### 3. HOME/ACCOUNT PAGE
**Current:** Gradient header, card-based layout  
**Brutalism:** Block-based, stark divisions

```
┌─────────────────────────────┐
│ BALANCE                     │
│                             │
│ Rp 5.234.567               │  (Large, bold number)
│ ┌─────────────────────────┐ │
│ │ HIDE / SHOW             │ │  (Toggle button)
│ └─────────────────────────┘ │
│                             │
├─────────────────────────────┤  (Full-width border)
│                             │
│ ACTIONS                     │
│                             │
│ ┌─────┬─────┬─────┬──────┐ │
│ │TOPUP│TRANS│SCAN │PROMO │ │
│ └─────┴─────┴─────┴──────┘ │
│                             │
├─────────────────────────────┤
│                             │
│ RECENT TRANSACTIONS         │
│                             │
│ Transfer • Rp 500.000       │
│ Jun 13, 14:30               │
│ ─────────────────────────── │
│                             │
│ Topup • Rp 100.000          │
│ Jun 12, 10:15               │
│                             │
└─────────────────────────────┘
```

**Changes:**
- No gradient (solid primary color for header)
- Remove shadow effects
- Full-width divider lines (border-top)
- Square button grid (4 columns)
- Bold titles (24px)
- Transaction items: simple list, no cards
- High contrast dividers

---

### 4. TRANSFER PAGE
**Current:** Multi-step with soft transitions  
**Brutalism:** Clear block sections, stark CTAs

```
┌─────────────────────────────┐
│ ◄ TRANSFER                  │
├─────────────────────────────┤
│                             │
│ SELECT RECIPIENT            │
│                             │
│ ┌─────────────────────────┐ │
│ │ Search or select...     │ │
│ └─────────────────────────┘ │
│                             │
│ BUDI SANTOSO                │
│ 0812-3456-7890              │
│ ─────────────────────────── │
│                             │
│ CITRA DEWI                  │
│ 0856-1122-3344              │
│                             │
├─────────────────────────────┤
│                             │
│ ┌─────────────────────────┐ │
│ │ NEXT: ENTER AMOUNT      │ │
│ └─────────────────────────┘ │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Replace gradients with solid blocks
- Remove card shadows
- Full-width input fields
- Bold section headers (20px)
- Contact list: no avatars, simple text
- Large CTA button (48px height)
- Clear section dividers

---

### 5. TOPUP PAGE
**Current:** Rounded amount selector  
**Brutalism:** Grid of blocks with bold borders

```
┌─────────────────────────────┐
│ ◄ TOP UP BALANCE            │
├─────────────────────────────┤
│                             │
│ CHOOSE AMOUNT               │
│                             │
│ ┌─────────┬─────────────────┤
│ │100K     │500K              │
│ ├─────────┼─────────────────┤
│ │1M       │2M                │
│ ├─────────┼─────────────────┤
│ │5M       │10M               │
│ └─────────┴─────────────────┘
│                             │
│ OR ENTER CUSTOM AMOUNT      │
│                             │
│ ┌─────────────────────────┐ │
│ │ Rp ________________     │ │
│ └─────────────────────────┘ │
│                             │
├─────────────────────────────┤
│                             │
│ FEE: Rp 2.500               │
│ TOTAL: Rp 102.500           │
│                             │
│ ┌─────────────────────────┐ │
│ │ CONTINUE TO PAYMENT     │ │
│ └─────────────────────────┘ │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Amount buttons in grid with thick borders (2px)
- Square corners, no gradients
- Bold amount text (18px)
- Stark fee display (no decorative icons)
- Full-width CTA button
- Minimal spacing, bold hierarchy

---

### 6. PIN PAGE
**Current:** Soft gradient, animated pad  
**Brutalism:** Dark container, stark number pad

```
┌─────────────────────────────┐
│                             │
│ ENTER 6-DIGIT PIN           │
│                             │
│ ●●●●●●                      │  (Large dots)
│                             │
├─────────────────────────────┤
│                             │
│ ┌───┬───┬───┐               │
│ │ 1 │ 2 │ 3 │               │
│ ├───┼───┼───┤               │
│ │ 4 │ 5 │ 6 │               │
│ ├───┼───┼───┤               │
│ │ 7 │ 8 │ 9 │               │
│ ├───┼───┼───┤               │
│ │   │ 0 │ ← │               │
│ └───┴───┴───┘               │
│                             │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Dark background (ink/charcoal)
- Large number pad buttons (60x60+)
- Thick borders (1-2px white/light)
- Bold white text (24px)
- High contrast on dark bg
- No animations
- Simple layout grid

---

### 7. SUCCESS PAGE
**Current:** Centered checkmark with gradient  
**Brutalism:** Bold confirmation block

```
┌─────────────────────────────┐
│                             │
│          ✓ OK               │  (Large checkmark)
│                             │
│  TRANSFER SUCCESSFUL        │
│                             │
│  To: Budi Santoso           │
│  Amount: Rp 500.000         │
│                             │
│  ─────────────────────────  │
│  Balance: Rp 4.734.567      │
│  Ref: DKG12345678           │
│                             │
├─────────────────────────────┤
│                             │
│ ┌─────────────────────────┐ │
│ │ ✓ DONE                  │ │
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ SHARE RECEIPT           │ │
│ └─────────────────────────┘ │
│                             │
└─────────────────────────────┘
```

**Changes:**
- Replace gradient with solid color block
- Large checkmark icon (64px)
- Bold transaction details
- Simple divider line
- Two CTA buttons stacked
- High contrast colors

---

## 🎨 COLOR PALETTE - BRUTALISM

**Primary:** Keep current primary blue (0xFF0B63E5)  
**Secondary:** Remove - use primary only  
**Neutral:**
- Ink (text/borders): `0xFF0E1726` (keep)
- Background: `0xFFFFFFFF` (white, not light gray)
- Divider: `0xFF0E1726` (solid ink, not light line)

**Remove:**
- All gradients
- Surface colors (primarySurface, greenSurface, etc.)
- Soft shadows
- Light lines

---

## 📐 TYPOGRAPHY - BRUTALISM

**Font:** Keep Plus Jakarta Sans (good for brutalism)

**Sizes:**
- H1: 40px, Weight 800
- H2: 28px, Weight 700
- H3: 20px, Weight 700
- Body: 14px, Weight 500
- Button: 16px, Weight 700
- Label: 12px, Weight 600

**Line Height:** 1.2 (tight)  
**Letter Spacing:** -0.3px (condensed)

---

## 🔲 COMPONENT UPDATES

### Buttons
```dart
// BEFORE: Rounded with gradient shadow
AppButton(
  onPressed: () {},
  child: Text('Button'),  // soft shadow
)

// AFTER: Square with thick border
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: AppColors.ink,
      width: 2,  // THICK
    ),
    borderRadius: BorderRadius.zero,  // NO RADIUS
  ),
  child: Material(
    color: AppColors.primary,
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Text(
          'BUTTON TEXT',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
)
```

### Input Fields
```dart
// BEFORE: Rounded with subtle shadow
AppField(
  hintText: 'Enter amount',
)

// AFTER: Square with stark border
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,  // SQUARE
      borderSide: BorderSide(
        color: AppColors.ink,
        width: 2,  // THICK
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),
  ),
)
```

### Cards/Containers
```dart
// BEFORE: Soft shadow, rounded
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
)

// AFTER: Stark border, no shadow
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: AppColors.ink,
      width: 2,  // THICK BORDER
    ),
    borderRadius: BorderRadius.zero,
  ),
)
```

---

## ✅ IMPLEMENTATION CHECKLIST

- [ ] Update AppColors (remove gradients/surfaces)
- [ ] Update AppButton widget (square, thick border)
- [ ] Update AppField widget (square, stark border)
- [ ] Update Splash page (bold typography)
- [ ] Update Login page (thick borders)
- [ ] Update Home page (block layout, dividers)
- [ ] Update Transfer pages (stark sections)
- [ ] Update Topup page (grid of blocks)
- [ ] Update PIN page (dark bg, stark pad)
- [ ] Update Success page (bold confirmation)
- [ ] Remove all shadows (Box shadows)
- [ ] Remove all gradients
- [ ] Update theme (no rounded corners)
- [ ] Test on device

---

## 🎯 RESULT

**Visual Impact:**
- More striking, memorable app
- Better readability with high contrast
- Modern minimalist aesthetic
- Unique brand identity (not Material Design clone)
- Better on small screens (clear sections)

