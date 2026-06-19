# EmoneyID

## 📱 Deskripsi Aplikasi
*eMoneyID** adalah aplikasi dompet digital inovatif yang dirancang khusus untuk Payment. Aplikasi ini memungkinkan anda  untuk melakukan berbagai transaksi sehari-hari seperti pengisian saldo (top-up), transfer antar pengguna,  penyewaan fasilitas/pembelian sepeda (seperti RentBike). 

Aplikasi ini dilengkapi dengan fitur keamanan canggih berupa Autentikasi Dua Langkah (2FA) menggunakan *Google Authenticator* (TOTP), serta mendukung integrasi *Deep Link* untuk memproses pembayaran langsung dari aplikasi pihak ketiga secara mulus.

---

## 🏗️ Arsitektur Aplikasi
Proyek ini dibangun menggunakan pendekatan **Clean Architecture** untuk memastikan kode yang modular, mudah di-maintenance, dan *scalable*. Struktur aplikasi dibagi menjadi tiga lapisan (*layers*) utama:

1. **Domain Layer (`lib/domain/`)**
   Lapisan paling dalam yang berisi aturan bisnis inti. Tidak bergantung pada paket eksternal (murni Dart).
   - **Entities**: Objek data murni (misal: `UserEntity`, `AccountEntity`).
   - **Repositories (Abstract)**: Antarmuka (*interface*) untuk kontrak akses data.
   - **Usecases**: Logika bisnis spesifik (misal: `TopupUsecase`, `DeepLinkPaymentUsecase`).

2. **Data Layer (`lib/data/`)**
   Bertanggung jawab penuh atas manajemen sumber data (Remote/API maupun Local/Storage).
   - **Datasources**: Akses ke API (menggunakan *Dio*) dan penyimpanan lokal (menggunakan *FlutterSecureStorage* dan *SharedPreferences*).
   - **Repositories (Impl)**: Implementasi dari *repository* yang didefinisikan di lapisan Domain.

3. **Presentation Layer (`lib/presentation/`)**
   Mengatur antarmuka pengguna (UI) dan manajemen *state*.
   - **BLoC**: *State management* yang mengatur logika tampilan (misal: `AuthBloc`, `PaymentBloc`).
   - **Pages**: Halaman antarmuka yang dibangun dengan berbagai widget UI.
   - **Widgets**: Komponen UI yang dapat digunakan kembali (*reusable*).

**Lainnya:**
- **Core (`lib/core/`)**: Konstanta, konfigurasi *Router* (`go_router`), *Theme*, dan penanganan *Deep Link* (`app_links`).
- **Injection (`lib/injection/`)**: *Dependency Injection* menggunakan `get_it`.

### 🗂️ Struktur Folder & File
```text
emoneyid/
├── android/app/src/main/AndroidManifest.xml   ← Intent filter deep link
├── pubspec.yaml                                ← Dependencies utama
└── lib/
    ├── main.dart                               ← Entry point + deep link init
    ├── firebase_options.dart
    ├── core/
    │   ├── constants/                          ← Konstanta & endpoints API
    │   ├── error/                              ← Exceptions & Failures
    │   ├── network/                            ← Konfigurasi HTTP Client (Dio)
    │   ├── router/                             ← Konfigurasi rute (go_router)
    │   ├── services/                           ← Service eksternal (Deep Link listener)
    │   ├── theme/                              ← Warna, Teks, & Tema
    │   └── utils/                              ← Formatter (Uang, Tanggal)
    ├── domain/                                 ← Aturan Bisnis Inti
    │   ├── entities/                           ← Objek murni
    │   ├── repositories/                       ← Interface akses data
    │   └── usecases/                           ← Usecase spesifik per fitur
    ├── data/                                   ← Manajemen Data
    │   ├── datasources/                        ← Remote (API) & Local (Storage)
    │   └── repositories/                       ← Implementasi Interface Domain
    ├── injection/                              ← Setup Dependency Injection (get_it)
    └── presentation/                           ← Tampilan & State
        ├── blocs/                              ← Business Logic Component
        ├── pages/                              ← Halaman-halaman UI
        └── widgets/                            ← Komponen UI Reusable
```

---

## 🚀 Cara Menjalankan Proyek

### Persyaratan
- Flutter SDK (Versi terbaru disarankan)
- Dart SDK
- Android Studio / VS Code
- Emulator atau Perangkat Android (Disarankan Android 11+ untuk pengujian *Deep Link*)

### Langkah-langkah
1. **Clone repositori ini:**
   ```bash
   git clone <url-repo-anda>
   cd emoneyid
   ```

2. **Unduh dependensi:**
   ```bash
   flutter pub get
   ```

3. **(Opsional) Atur URL API Lokal:**
   Secara *default*, aplikasi mengarah ke `http://192.168.0.105:8080`. Jika Anda memiliki server backend sendiri, Anda bisa melakukan *override* menggunakan argumen `--dart-define` saat menjalankan aplikasi:
   ```bash
   flutter run --dart-define=API_BASE_URL=http://<IP_ANDA>:8080
   ```

4. **Jalankan Aplikasi:**
   ```bash
   flutter run
   ```

> **Catatan Pengujian Deep Link:**
> Untuk menguji fitur pembayaran via *Deep Link* dari aplikasi eksternal seperti RentBike, pastikan kedua aplikasi (eMoneyID dan RentBike) sudah di-*build* dan terpasang di perangkat/emulator yang sama.

---

## 📦 Daftar Dependensi Utama

Berikut adalah pustaka (*packages*) utama penyokong fitur aplikasi ini (dapat dilihat lebih detail di `pubspec.yaml`):

- **State Management & Routing:**
  - `flutter_bloc` (^9.0.0): Mengelola aliran *state* secara terpusat dan reaktif.
  - `go_router` (^14.8.1): Menangani navigasi, alur rute bersarang (*shell routes*), dan *passing data*.
- **Dependency Injection & Model:**
  - `get_it` (^8.0.2): *Service locator* untuk menghubungkan antar lapisan arsitektur.
  - `equatable` (^2.0.5): Memudahkan perbandingan *value equality* antar objek untuk optimalisasi *render* BLoC.
- **Networking & Deep Link:**
  - `dio` (^5.7.0): Klien HTTP andal untuk *request* API.
  - `app_links` (^6.4.0): Mendengarkan dan memproses URI *Deep Link* yang ditangkap oleh OS Android.
  - `url_launcher` (^6.3.1): Mengeksekusi *callback Intent* ke aplikasi pihak ketiga (seperti `rentbike://success`).
- **Keamanan & Penyimpanan Lokal:**
  - `flutter_secure_storage` (^9.2.2): Penyimpanan aman terenkripsi (Keystore) untuk menampung token JWT.
  - `shared_preferences` (^2.3.4): Menampung sinkronisasi riwayat saldo statis (*BalanceLocal*).
- **Integrasi Firebase:**
  - `firebase_auth`, `firebase_core`, `google_sign_in`: Mengurus *login*, pendaftaran, serta distribusi OTP lewat email.
