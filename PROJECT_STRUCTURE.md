# EMONEYID - PROJECT STRUCTURE & FILE DOCUMENTATION

**Project:** Dompet Kampus Global (Flutter E-Money App)  
**Architecture:** Clean Architecture (Domain/Data/Presentation) + BLoC + GetIt DI  
**Last Updated:** 2026-06-13

---

## 📁 COMPLETE PROJECT STRUCTURE

```
emoneyid/
├── 📄 pubspec.yaml                          # Project dependencies & metadata
├── 📄 pubspec.lock                          # Locked dependency versions
├── 📄 analysis_options.yaml                 # Dart/Flutter analyzer rules
├── 📄 firebase.json                         # Firebase configuration
├── 📄 README.md                             # Project readme
├── 📄 ERROR_REPORT.md                       # 13 issues found & solutions
├── 📄 COMMIT_STRATEGY.md                    # 25+ commit roadmap
│
├── 📁 android/                              # Android native code & gradle config
│   ├── app/
│   │   ├── google-services.json             # Firebase Android config
│   │   └── build.gradle
│   └── build.gradle
│
├── 📁 ios/                                  # iOS native code & pods
│   ├── Podfile
│   ├── Runner.xcodeproj
│   └── GoogleService-Info.plist             # Firebase iOS config
│
├── 📁 web/                                  # Web platform files
│   ├── index.html
│   ├── manifest.json
│   └── favicon.png
│
├── 📁 linux/                                # Linux platform files
├── 📁 macos/                                # macOS platform files
├── 📁 windows/                              # Windows platform files
│
├── 📁 assets/                               # App resources
│   ├── images/                              # UI images & illustrations
│   └── icons/                               # App icons
│
├── 📁 lib/                                  # Main application code 
│   │
│   ├── 📄 main.dart                         # App entry point #done
│   ├── 📄 firebase_options.dart             # Firebase configuration for all platforms #done
│   │
│   ├── 📁 core/                             # Core/shared functionality
│   │   ├── 📁 constants/
│   │   │   ├── 📄 app_constants.dart        # Global constants (URLs, timeouts, keys) #done
│   │   │   └── 📄 api_endpoints.dart        # API endpoint paths #done
│   │   │
│   │   ├── 📁 error/
│   │   │   ├── 📄 exceptions.dart           # Custom exception classes #done
│   │   │   └── 📄 failures.dart             # Failure classes for error handling #done
│   │   │
│   │   ├── 📁 network/
│   │   │   └── 📄 api_client.dart           # HTTP client (Dio wrapper) #done
│   │   │
│   │   ├── 📁 router/
│   │   │   └── 📄 app_router.dart           # GoRouter navigation configuration #done
│   │   │
│   │   ├── 📁 theme/
│   │   │   ├── 📄 app_theme.dart            # Theme configuration (colors, fonts) #done
│   │   │   ├── 📄 app_colors.dart           # Color palette #done
│   │   │   └── 📄 app_text_styles.dart      # Text styles & typography #done
│   │   │
│   │   └── 📁 utils/
│   │       ├── 📄 app_bloc_observer.dart    # BLoC state/event logger #done
│   │       ├── 📄 currency_formatter.dart   # Format currency display #done
│   │       └── 📄 date_formatter.dart       # Format dates #done
│   │
│   ├── 📁 domain/                           # Business logic (entities, repositories, usecases)
│   │   ├── 📁 entities/
│   │   │   ├── 📄 user_entity.dart          # User data model (domain layer) #done
│   │   │   ├── 📄 account_entity.dart       # Account data model #done
│   │   │   ├── 📄 transaction_entity.dart   # Transaction data model #done
│   │   │   ├── 📄 otp_entity.dart           # OTP setup/sent data #done
│   │   │   └── 📄 payment_result_entity.dart # Payment result model #done
│   │   │
│   │   ├── 📁 repositories/
│   │   │   ├── 📄 auth_repository.dart      # Auth operations interface  #done
│   │   │   ├── 📄 otp_repository.dart       # OTP operations interface  #done
│   │   │   ├── 📄 account_repository.dart   # Account operations interface  #done
│   │   │   └── 📄 payment_repository.dart   # Payment operations interface  #done
│   │   │
│   │   └── 📁 usecases/
│   │       ├── 📁 auth/
│   │       │   ├── 📄 verify_firebase_token_usecase.dart  # Verify Firebase token #done
│   │       │   ├── 📄 register_with_otp_usecase.dart      # Register new user #done
│   │       │   ├── 📄 verify_email_otp_usecase.dart       # Verify email OTP #done
│   │       │   ├── 📄 get_me_usecase.dart                 # Get current user #done
│   │       │   ├── 📄 logout_usecase.dart                 # Logout user #done
│   │       │   └── 📄 send_otp_usecase.dart               # Send OTP #done
│   │       ├── 📁 account/
│   │       │   ├── 📄 get_account_usecase.dart            # Get account details #done
│   │       │   └── 📄 get_transactions_usecase.dart        # Get transaction history #??
│   │       └── 📁 payment/
│   │           └── 📄 payment_usecases.dart               # Topup & Transfer usecases #done
│   │
│   ├── 📁 data/                             # Data layer (models, repositories, datasources)
│   │   ├── 📁 models/
│   │   │   ├── 📄 user_model.dart           # User model with JSON serialization #done
│   │   │   ├── 📄 account_model.dart        # Account model with JSON serialization #done
│   │   │   ├── 📄 transaction_model.dart    # Transaction model with JSON serialization #done
│   │   │   └── 📄 otp_model.dart            # OTP model (if exists) #??
│   │   │
│   │   ├── 📁 datasources/
│   │   │   ├── 📁 remote/
│   │   │   │   ├── 📄 auth_remote_datasource.dart         # Firebase & backend auth API #done
│   │   │   │   ├── 📄 otp_remote_datasource.dart          # OTP API calls #done
│   │   │   │   ├── 📄 account_remote_datasource.dart      # Account API calls #done
│   │   │   │   └── 📄 payment_remote_datasource.dart      # Payment API calls #done
│   │   │   └── 📁 local/
│   │   │       └── 📄 secure_storage_datasource.dart      # Secure local storage #done
│   │   │
│   │   └── 📁 repositories/
│   │       ├── 📄 auth_repository_impl.dart               # Auth business logic #done
│   │       ├── 📄 otp_repository_impl.dart                # OTP business logic #done
│   │       ├── 📄 account_repository_impl.dart            # Account business logic #done
│   │       └── 📄 payment_repository_impl.dart            # Payment business logic #done
│   │
│   ├── 📁 presentation/                    # UI layer (BLoCs, Pages, Widgets)
│   │   ├── 📁 blocs/
│   │   │   ├── 📁 auth/
│   │   │   │   ├── 📄 auth_bloc.dart                      # Authentication state management #done
│   │   │   │   └── 📄 otp_bloc.dart                       # OTP state management #done
│   │   │   ├── 📁 account/
│   │   │   │   └── 📄 account_bloc.dart                   # Account/Transaction state #done
│   │   │   └── 📁 payment/
│   │   │       └── 📄 payment_bloc.dart                   # Payment state management #done
│   │   │
│   │   ├── 📁 pages/
│   │   │   ├── 📁 splash/
│   │   │   │   └── 📄 splash_page.dart                    # App splash/loading screen #done
│   │   │   ├── 📁 auth/
│   │   │   │   ├── 📄 login_page.dart                     # Google login page #done
│   │   │   │   ├── 📄 register_page.dart                  # User registration #done
│   │   │   │   ├── 📄 verify_email_page.dart              # Email verification #done
│   │   │   │   ├── 📄 setup_2fa_page.dart                 # 2FA setup selection #done
│   │   │   │   ├── 📄 twofa_smtp_page.dart                # Email 2FA input #done
│   │   │   │   ├── 📄 twofa_totp_page.dart                # TOTP/Authenticator 2FA #done
│   │   │   │   └── 📄 twofa_notif_page.dart               # Push notification 2FA
│   │   │   ├── 📁 home/
│   │   │   │   └── 📄 home_page.dart                      # Dashboard with balance
│   │   │   ├── 📁 history/
│   │   │   │   └── 📄 history_page.dart                   # Transaction history
│   │   │   ├── 📁 promo/
│   │   │   │   └── 📄 promo_page.dart                     # Promotions page
│   │   │   ├── 📁 account/
│   │   │   │   └── 📄 account_page.dart                   # User account settings
│   │   │   ├── 📁 topup/
│   │   │   │   └── 📄 topup_page.dart                     # Topup selection page
│   │   │   ├── 📁 transfer/
│   │   │   │   ├── 📄 transfer_page.dart                  # Transfer main page
│   │   │   │   ├── 📄 transfer_amount_page.dart           # Enter transfer amount
│   │   │   │   └── 📄 transfer_confirm_page.dart          # Confirm transfer
│   │   │   ├── 📁 payment/
│   │   │   │   ├── 📄 payment_qr_page.dart                # QR scanner page
│   │   │   │   └── 📄 pin_page.dart                       # Transaction PIN input
│   │   │   ├── 📁 merchant/
│   │   │   │   └── 📄 merchant_checkout_page.dart         # Merchant payment checkout
│   │   │   └── 📁 success/
│   │   │       └── 📄 success_page.dart                   # Transaction success page
│   │   │
│   │   └── 📁 widgets/
│   │       ├── 📄 app_avatar.dart                         # User avatar widget
│   │       ├── 📄 app_badge.dart                          # Status badge widget
│   │       ├── 📄 app_button.dart                         # Custom button widget
│   │       ├── 📄 app_field.dart                          # Custom text field
│   │       ├── 📄 app_logo.dart                           # App logo widget
│   │       ├── 📄 app_tab_bar.dart                        # Bottom tab bar widget
│   │       ├── 📄 app_top_bar.dart                        # Top app bar widget
│   │       ├── 📄 code_input.dart                         # OTP code input widget
│   │       ├── 📄 feature_icon.dart                       # Feature icon widget
│   │       ├── 📄 num_pad.dart                            # Number pad widget
│   │       ├── 📄 pin_pad.dart                            # PIN input pad widget
│   │       ├── 📄 success_check.dart                      # Success checkmark animation
│   │       └── 📄 transaction_row.dart                    # Transaction list item
│   │
│   └── 📁 injection/
│       └── 📄 injection_container.dart      # Dependency injection setup (GetIt)
│
├── 📁 test/                                 # Unit & widget tests
│   └── 📄 widget_test.dart                  # Example widget test
│
├── 📁 .dart_tool/                           # Generated Dart files
├── 📁 .idea/                                # IDE configuration (IntelliJ/Android Studio)
├── 📁 .vscode/                              # VS Code configuration
└── 📁 build/                                # Build artifacts


```

---

## 📖 FILE-BY-FILE DOCUMENTATION

### 🎯 **ENTRY POINT**

#### **lib/main.dart**
```dart
Purpose: Application entry point
Key Functions:
  - Initialize Flutter binding
  - Setup Bloc observer for debugging
  - Initialize Firebase
  - Setup dependency injection
  - Configure system UI (orientation, status bar)
  - Launch app with MaterialApp.router (GoRouter)
```

---

### ⚙️ **CORE LAYER** (Shared Utilities & Infrastructure)

#### **lib/core/constants/app_constants.dart**
```dart
Purpose: Global application constants
Contents:
  - appName: "Dompet Kampus Global"
  - appVersion: "1.0.0"
  - baseUrl: "http://192.168.0.105:8080"  ⚠️ (HARDCODED - Issue #10)
  - connectTimeout: 30 seconds
  - receiveTimeout: 30 seconds
  - Storage keys for JWT token, user data, 2FA method, FCM token
  - OTP/PIN configuration (length, resend timing)
  - Transaction types (transfer, topup, payment, pulsa, received)

Usage: Import & use like AppConstants.baseUrl, AppConstants.kJwtToken
```

#### **lib/core/constants/api_endpoints.dart**
```dart
Purpose: API endpoint paths
Contents:
  - Base path: /v1
  - Auth endpoints: /auth/verify-token, /auth/register, /auth/me, /auth/fcm-token
  - OTP endpoints: /otp/send-firebase, /otp/send-email, /otp/confirm, /otp/totp/*
  - Account endpoints: /account, /account/transactions
  - Payment endpoints: /payment/topup, /payment/transfer

Example: ApiEndpoints.verifyToken = "/v1/auth/verify-token"
```

#### **lib/core/error/exceptions.dart**
```dart
Purpose: Custom exception classes (data layer)
Classes:
  - ServerException: API server errors
  - NetworkException: Network connectivity errors
  - UnauthorizedException: 401 Unauthorized (invalid token)
  - InvalidOtpException: Invalid/expired OTP code
  - InsufficientBalanceException: Not enough balance (includes balance & amount)
  - CacheException: Local storage errors

Usage: Thrown in datasources, caught & converted to Failures in repositories
```

#### **lib/core/error/failures.dart**
```dart
Purpose: Failure classes (domain layer) for error handling
Classes:
  - Failure (abstract): Base class with message
  - ServerFailure: Server errors (includes errorCode & statusCode)
  - NetworkFailure: Network errors
  - AuthFailure: Authentication errors
  - InvalidOtpFailure: Invalid OTP errors
  - InsufficientBalanceFailure: Insufficient balance (includes balance & amount)
  - CacheFailure: Cache errors
  - UnexpectedFailure: Generic errors

Usage: Thrown in repositories, caught in BLoCs to emit error states
Flow: Exception (datasource) → Failure (repository) → State (BLoC)
```

#### **lib/core/network/api_client.dart**
```dart
Purpose: HTTP client wrapper (Dio library)
Key Features:
  - Manages baseUrl, headers, timeouts
  - Interceptors: PrettyDioLogger (logging), error handling
  - Methods: get(), post(), put() returning Map<String, dynamic>
  - Error handling: Converts DioException to custom exceptions
  - Token management: setAuthToken(), clearAuthToken()

Example:
  final client = ApiClient();
  client.setAuthToken(token);
  final response = await client.post('/auth/verify-token', data: {...});
```

#### **lib/core/router/app_router.dart**
```dart
Purpose: Navigation routing configuration (GoRouter)
Routes Defined:
  - / : Splash page
  - /login : Google login
  - /register : Email registration
  - /verify-email : Email verification
  - /setup-2fa : 2FA method selection
  - /2fa/smtp, /2fa/totp, /2fa/notif : 2FA verification pages
  - /home, /history, /promo, /akun : Main app tabs (ShellRoute)
  - /topup : Topup page
  - /transfer, /transfer/amount, /transfer/confirm : Transfer flow
  - /payment : QR scanner
  - /pin : PIN input
  - /success : Success page
  - /merchant : Merchant checkout

BLoC Providers: Wraps routes with necessary BLoCs (AuthBloc, OtpBloc, etc)
```

#### **lib/core/theme/app_theme.dart**
```dart
Purpose: App theme configuration
Contains:
  - Light theme (Material 3)
  - Primary color & gradients
  - Typography (Plus Jakarta Sans font)
  - Component shapes & styles
  - Color scheme

⚠️ Issue #5: Uses deprecated background color (should be surface)
```

#### **lib/core/theme/app_colors.dart**
```dart
Purpose: Color palette definition
Colors:
  - primary, primaryLight, primaryDark
  - accent colors
  - semantic colors (success, error, warning)
  - backgrounds, surfaces
  - text colors (primary, secondary, tertiary)
  - Gradients: primaryGradient, etc

Usage: AppColors.primary, AppColors.primaryGradient
```

#### **lib/core/theme/app_text_styles.dart**
```dart
Purpose: Typography & text style definitions
Styles Defined:
  - Heading sizes (h1, h2, h3, h4, h5, h6)
  - Body text (small, regular, large)
  - Button text styles
  - Caption/helper text

Font: Plus Jakarta Sans (custom)
```

#### **lib/core/utils/app_bloc_observer.dart**
```dart
Purpose: BLoC lifecycle observer for debugging
Logs:
  - Event emissions
  - State transitions
  - Errors in BLoCs

Usage: Set in main() via Bloc.observer = AppBlocObserver()
```

#### **lib/core/utils/currency_formatter.dart**
```dart
Purpose: Format numbers as currency
Functions:
  - formatCurrency(double): "Rp 1.234.567,89"
  - parseCurrency(String): Parse formatted back to double

Usage: Display balance, amounts in UI
```

#### **lib/core/utils/date_formatter.dart**
```dart
Purpose: Format DateTime objects
Functions:
  - formatDate(DateTime): "13 Juni 2026"
  - formatTime(DateTime): "10:30"
  - formatDateTime(DateTime): Full date & time

Usage: Display transaction dates in history
```

---

### 🏛️ **DOMAIN LAYER** (Business Logic - No Framework Dependencies)

#### **lib/domain/entities/user_entity.dart**
```dart
Purpose: User data model (domain layer - pure Dart)
Fields:
  - id, firebaseUid, email, name, role
  - emailVerified, totpEnabled, twoFaMethod
  - Computed: firstName (from name)

No dependencies on framework or data layer
Pure business logic representation
```

#### **lib/domain/entities/account_entity.dart**
```dart
Purpose: Account/wallet data model
Fields:
  - id, userId, balance, createdAt
```

#### **lib/domain/entities/transaction_entity.dart**
```dart
Purpose: Transaction history model
Fields:
  - id, accountId, type (transfer/topup/payment)
  - amount, description, balanceBefore, balanceAfter
  - createdAt, recipient/sender info
```

#### **lib/domain/entities/otp_entity.dart**
```dart
Purpose: OTP-related models
Classes:
  - OtpSentEntity: otpType, expiresIn
  - TotpSetupEntity: secret, qrCode, issuer, account
```

#### **lib/domain/entities/payment_result_entity.dart**
```dart
Purpose: Payment operation results
Classes:
  - PaymentResultEntity: title, subtitle, amount, lines, kind
  - TransferResultEntity: transactionId, amount, description, balances, timestamp
```

#### **lib/domain/repositories/auth_repository.dart**
```dart
Purpose: Authentication repository interface (contract)
Methods:
  - verifyFirebaseToken(firebaseToken)
  - registerWithOtp(firebaseToken)
  - verifyEmailOtp(code)
  - getMe()
  - updateFcmToken(token)
  - logout(), setAuthVerified(), isAuthVerified()
  - getSavedToken(), getSavedUser()

Implementation: AuthRepositoryImpl (lib/data/repositories/)
```

#### **lib/domain/repositories/otp_repository.dart**
```dart
Purpose: OTP operations interface
Methods:
  - sendOtpFirebase(), sendOtpEmail()
  - confirmOtp(code, type)
  - registerTotp(), verifyTotp(code)
```

#### **lib/domain/repositories/account_repository.dart**
```dart
Purpose: Account/wallet interface
Methods:
  - getAccount()
  - getTransactions()
```

#### **lib/domain/repositories/payment_repository.dart**
```dart
Purpose: Payment operations interface
Methods:
  - topup(amount)
  - transfer(amount, description, otpCode, otpType)
```

#### **lib/domain/usecases/auth/*.dart**
```dart
Purpose: Individual use cases for auth operations
Classes:
  - VerifyFirebaseTokenUsecase: Firebase token verification
  - RegisterWithOtpUsecase: New user registration
  - VerifyEmailOtpUsecase: Email OTP verification
  - GetMeUsecase: Fetch current user
  - LogoutUsecase: Logout operation
  - SendOtpFirebaseUsecase, SendOtpEmailUsecase: Send OTP
  - ConfirmOtpUsecase, RegisterTotpUsecase, VerifyTotpUsecase: TOTP 2FA

Each usecase wraps repository call with business logic
Single Responsibility: One use case = One action
```

#### **lib/domain/usecases/account/*.dart**
```dart
Purpose: Account operation use cases
Classes:
  - GetAccountUsecase: Fetch account details
  - GetTransactionsUsecase: Fetch transaction history
```

#### **lib/domain/usecases/payment/payment_usecases.dart**
```dart
Purpose: Payment use cases
Classes:
  - TopupUsecase: Perform topup
  - TransferUsecase: Perform transfer

Returns typed results: ({balance, amount}) or TransferResultEntity
```

---

### 📦 **DATA LAYER** (API Calls, Models, Repository Implementation)

#### **lib/data/models/user_model.dart**
```dart
Purpose: User model with JSON serialization
Extends: UserEntity
Methods:
  - fromJson(Map): Parse from API response
  - toJson(): Convert to Map for storage
  - toJsonString(), fromJsonString(): JSON string serialization
  
Used for: API responses, local storage serialization
```

#### **lib/data/models/account_model.dart**
```dart
Purpose: Account model with JSON conversion
Extends: AccountEntity
Converts: API JSON → AccountModel → AccountEntity
```

#### **lib/data/models/transaction_model.dart**
```dart
Purpose: Transaction model with JSON conversion
Extends: TransactionEntity
Used in: History page, transaction lists
```

#### **lib/data/datasources/remote/auth_remote_datasource.dart**
```dart
Purpose: API calls for authentication
Interface: AuthRemoteDatasource
Implementation: AuthRemoteDatasourceImpl
Methods:
  - verifyFirebaseToken(token): POST /auth/verify-token
  - registerWithOtp(token): POST /auth/register
  - verifyEmailOtp(code): POST /auth/verify-email-otp
  - getMe(): GET /auth/me
  - updateFcmToken(token): PUT /auth/fcm-token
  - clearAuthToken(): Remove auth header

Returns: Tuples (user, token) or UserModel
Throws: ServerException, NetworkException, UnauthorizedException
```

#### **lib/data/datasources/remote/otp_remote_datasource.dart**
```dart
Purpose: OTP-related API calls
Methods:
  - sendOtpFirebase(): POST /otp/send-firebase
  - sendOtpEmail(): POST /otp/send-email
  - confirmOtp(code, type): POST /otp/confirm
  - registerTotp(): POST /otp/totp/register
  - verifyTotp(code): POST /otp/totp/verify

Returns: OtpSentEntity, TotpSetupEntity
```

#### **lib/data/datasources/remote/account_remote_datasource.dart**
```dart
Purpose: Account API calls
Methods:
  - getAccount(): GET /account
  - getTransactions(): GET /account/transactions

Returns: AccountModel, List<TransactionModel>
```

#### **lib/data/datasources/remote/payment_remote_datasource.dart**
```dart
Purpose: Payment API calls
Methods:
  - topup(amount): POST /payment/topup → ({balance, amount})
  - transfer(amount, desc, otp, otpType): POST /payment/transfer → TransferResultEntity

Handles: Balance updates, transaction records
```

#### **lib/data/datasources/local/secure_storage_datasource.dart**
```dart
Purpose: Secure local storage for sensitive data
Interface: SecureStorageDatasource
Implementation: SecureStorageDatasourceImpl
Methods:
  - saveToken(token), getToken()
  - saveUserJson(json), getUserJson()
  - save2faMethod(method), get2faMethod()
  - saveFcmToken(token), getFcmToken()
  - saveAuthVerified(bool), getAuthVerified()
  - clearAll()

Storage: Flutter Secure Storage (encrypted)
Usage: Persist JWT, user data, 2FA preference
```

#### **lib/data/repositories/auth_repository_impl.dart**
```dart
Purpose: Implement AuthRepository interface
Combines: Remote datasource (API) + Local datasource (storage)
Methods:
  - verifyFirebaseToken(): Call remote → save to local
  - getSavedToken(): Get from local storage
  - getSavedUser(): Get from local storage
  - logout(): Clear local storage

Error Handling: Convert exceptions to failures
Exception → Failure mapping:
  - UnauthorizedException → AuthFailure
  - ServerException → ServerFailure
  - NetworkException → NetworkFailure
```

#### **lib/data/repositories/otp_repository_impl.dart**
```dart
Purpose: Implement OtpRepository
Wraps: OtpRemoteDatasource
Converts: Exceptions to failures
```

#### **lib/data/repositories/account_repository_impl.dart**
```dart
Purpose: Implement AccountRepository
Wraps: AccountRemoteDatasource
```

#### **lib/data/repositories/payment_repository_impl.dart**
```dart
Purpose: Implement PaymentRepository
Wraps: PaymentRemoteDatasource
Key Conversion: Specific exception handling
  - InvalidOtpException → InvalidOtpFailure
  - InsufficientBalanceException → InsufficientBalanceFailure
```

---

### 🎨 **PRESENTATION LAYER** (UI - BLoCs, Pages, Widgets)

#### **lib/presentation/blocs/auth/auth_bloc.dart**
```dart
Purpose: Authentication state management
Events:
  - AuthCheckRequested: Verify saved session on app start
  - AuthLoginWithFirebase: Login with Firebase token
  - AuthLogoutRequested: Logout user
  - AuthUpdateFcmToken: Update push notification token

States:
  - AuthInitial: Initial state
  - AuthLoading: Loading state
  - AuthAuthenticated: User logged in (has user)
  - AuthUnauthenticated: User not logged in
  - AuthNeedsVerification: Login OK but 2FA pending
  - AuthError: Login failed (has error message)

Responsibilities:
  - Check saved token & user on app launch
  - Handle Firebase token verification
  - Track authentication state
  - Trigger logout

⚠️ Issue #2-3: Unused import (send_otp_usecase) & unused field (_getMe)
```

#### **lib/presentation/blocs/auth/otp_bloc.dart**
```dart
Purpose: OTP verification state management
Events:
  - OtpSendFirebase: Request Firebase OTP
  - OtpSendEmail: Request email OTP
  - OtpConfirm: Verify OTP code
  - OtpRegisterTotp: Request TOTP setup
  - OtpVerifyTotp: Verify TOTP code
  - OtpReset: Reset to initial state

States:
  - OtpInitial
  - OtpLoading
  - OtpSent (with expiry time)
  - OtpVerified
  - OtpTotpSetup (with QR code)
  - OtpTotpEnabled
  - OtpInvalid (wrong code)
  - OtpError

Responsibilities:
  - Handle 2FA setup flows
  - Track OTP verification state
  - Support multiple 2FA methods (Firebase, Email, TOTP)
```

#### **lib/presentation/blocs/account/account_bloc.dart**
```dart
Purpose: Account & transaction history management
Events:
  - AccountLoadRequested: Fetch account & transactions
  - AccountRefreshRequested: Refresh data

States:
  - AccountInitial
  - AccountLoading
  - AccountLoaded (with account & transactions list)
  - AccountError (with message)

Responsibilities:
  - Fetch balance, account details
  - Fetch transaction history
  - Handle refresh on pull-to-refresh

⚠️ Issue #11: Missing 401 error handling (doesn't logout on expired token)
```

#### **lib/presentation/blocs/payment/payment_bloc.dart**
```dart
Purpose: Payment operations state management
Events:
  - PaymentTopupRequested (amount)
  - PaymentTransferRequested (amount, desc, otp, otpType)
  - PaymentReset

States:
  - PaymentInitial
  - PaymentLoading
  - PaymentTopupSuccess ({balance, amount})
  - PaymentTransferSuccess (TransferResultEntity)
  - PaymentInvalidOtp (wrong OTP)
  - PaymentInsufficientBalance ({balance, amount})
  - PaymentError (generic error)

Responsibilities:
  - Track topup & transfer flows
  - Handle transaction results
  - Show specific errors (invalid OTP, insufficient balance)

⚠️ Issue #12: Topup missing error handlers (only has generic ServerFailure)
```

#### **lib/presentation/pages/splash/splash_page.dart**
```dart
Purpose: App loading/splash screen on startup
Responsibilities:
  - Show app logo
  - Verify saved authentication state
  - Route to login or home based on auth status
  - First page shown to user
```

#### **lib/presentation/pages/auth/login_page.dart**
```dart
Purpose: Google sign-in page
Features:
  - Google Sign-In button
  - Listen to AuthBloc for auth state
  - Navigate to 2FA setup on success
  - Show error messages on failure
```

#### **lib/presentation/pages/auth/register_page.dart**
```dart
Purpose: New user registration
Features:
  - Email input
  - Password input
  - Firebase registration
```

#### **lib/presentation/pages/auth/verify_email_page.dart**
```dart
Purpose: Email verification during registration
Features:
  - Display email for verification
  - Input verification code
  - Resend code option
```

#### **lib/presentation/pages/auth/setup_2fa_page.dart**
```dart
Purpose: 2FA method selection after login
Options:
  - Email (SMTP)
  - Authenticator app (TOTP)
  - Push notifications
```

#### **lib/presentation/pages/auth/twofa_smtp_page.dart**
```dart
Purpose: Email (SMTP) 2FA verification
Features:
  - Display email masked
  - OTP code input (6 digits)
  - Countdown timer for code expiry
  - Resend code button

⚠️ Issues #6, #8: Deprecated translate() API, missing curly braces
```

#### **lib/presentation/pages/auth/twofa_totp_page.dart**
```dart
Purpose: TOTP (Authenticator app) 2FA verification
Features:
  - Display QR code for setup
  - Manual key entry
  - OTP code input
  - Verify button

⚠️ Issue #6: Deprecated translate() API
```

#### **lib/presentation/pages/auth/twofa_notif_page.dart**
```dart
Purpose: Push notification 2FA verification
Features:
  - Wait for push notification
  - Auto-complete on notification received
  - Manual code entry fallback

⚠️ Issue #7: BuildContext used across async gap (unsafe)
```

#### **lib/presentation/pages/home/home_page.dart**
```dart
Purpose: Main dashboard/home screen
Features:
  - Display user greeting + balance (hidden toggle)
  - Transaction list (recent 5-10)
  - Feature shortcuts: Topup, Transfer, Scan, History
  - Pull-to-refresh to reload data
  - Tab navigation bar

Blocs Used:
  - AuthBloc: Get user info
  - AccountBloc: Get balance & transactions
```

#### **lib/presentation/pages/history/history_page.dart**
```dart
Purpose: Full transaction history
Features:
  - List all transactions
  - Filter by type
  - Search by description
  - Pagination or infinite scroll
  - Transaction details modal
```

#### **lib/presentation/pages/promo/promo_page.dart**
```dart
Purpose: Promotions/offers page
Features:
  - Display available promotions
  - Redeem codes
  - Campaign banners
```

#### **lib/presentation/pages/account/account_page.dart**
```dart
Purpose: User account settings/profile
Features:
  - Display user info (name, email)
  - Verification status badge
  - Settings (2FA, notification preferences)
  - Logout button

Blocs Used: AuthBloc
```

#### **lib/presentation/pages/topup/topup_page.dart**
```dart
Purpose: Topup amount selection
Features:
  - Amount input (manual or preset amounts)
  - Payment method selection
  - Proceed to PIN confirmation
```

#### **lib/presentation/pages/transfer/transfer_page.dart**
```dart
Purpose: Transfer recipient selection
Features:
  - Search/select recipient from contacts
  - Recent recipients list
  - Recipient list from backend
```

#### **lib/presentation/pages/transfer/transfer_amount_page.dart**
```dart
Purpose: Enter transfer amount
Features:
  - Amount input field
  - Description/note input
  - Calculate fee
  - Show recipient details
  - Proceed to confirm
```

#### **lib/presentation/pages/transfer/transfer_confirm_page.dart**
```dart
Purpose: Confirm transfer details
Features:
  - Show recipient, amount, fee, total
  - Edit button (back to amount page)
  - Confirm button → proceed to PIN
```

#### **lib/presentation/pages/payment/payment_qr_page.dart**
```dart
Purpose: QR code scanner for merchant payments
Features:
  - Camera access + QR scanning
  - Detect merchant QR code
  - Parse merchant ID & amount
  - Navigate to PIN for payment
```

#### **lib/presentation/pages/payment/pin_page.dart**
```dart
Purpose: Transaction PIN input (6 digits)
Features:
  - PIN pad UI
  - PIN confirmation
  - Submit transaction
  - Show loading/success/error

⚠️ Issue #6: Deprecated translate() API
```

#### **lib/presentation/pages/merchant/merchant_checkout_page.dart**
```dart
Purpose: Merchant payment checkout page
Features:
  - Show merchant details
  - Show amount to pay
  - Confirm payment button
  - Process payment
```

#### **lib/presentation/pages/success/success_page.dart**
```dart
Purpose: Transaction success result page
Features:
  - Display transaction result (topup/transfer/payment)
  - Show title, amount, details
  - Transaction receipt lines
  - Share/print receipt options
  - Done button
```

#### **lib/presentation/widgets/** (Reusable UI Components)
```dart
- app_avatar.dart: User avatar with initials
- app_badge.dart: Status badge (verified, pending, etc)
- app_button.dart: Custom button with loading state
- app_field.dart: Custom text input field
- app_logo.dart: App logo display
- app_tab_bar.dart: Bottom tab navigation bar
- app_top_bar.dart: Top app bar/header
- code_input.dart: 6-digit code input (OTP/PIN)
- feature_icon.dart: Feature icon widget
- num_pad.dart: Number pad for amount input
- pin_pad.dart: PIN pad for PIN input
- success_check.dart: Animated success checkmark
- transaction_row.dart: Transaction list item
```

---

### 🔌 **DEPENDENCY INJECTION**

#### **lib/injection/injection_container.dart**
```dart
Purpose: Setup all dependencies (GetIt service locator)
Contents:
  - External: FlutterSecureStorage
  - Core: ApiClient (Dio wrapper)
  - Datasources: Remote (API) & Local (Storage)
  - Repositories: All 4 repositories
  - UseCases: All auth, account, payment usecases
  - BLoCs: AuthBloc, OtpBloc, AccountBloc, PaymentBloc

Functions:
  - init(): Initialize all dependencies
  - setApiToken(token): Set JWT token after login
  - clearApiToken(): Clear token on logout

Usage:
  - main.dart: await di.init()
  - Pages: context.read<BlocType>() via GetIt lookup
```

---

### 🔧 **CONFIGURATION FILES**

#### **pubspec.yaml**
```yaml
Purpose: Project metadata & dependencies
Key Dependencies:
  - flutter, flutter_test
  - flutter_bloc: State management
  - equatable: Equality comparison
  - get_it: Dependency injection
  - go_router: Navigation routing
  - dio: HTTP client
  - pretty_dio_logger: HTTP logging
  - firebase_core, firebase_auth, firebase_messaging: Firebase
  - google_sign_in: Google authentication
  - flutter_secure_storage: Encrypted storage
  - shared_preferences: Local preferences
  - mobile_scanner: QR scanning
  - cached_network_image: Image caching
  - shimmer: Loading shimmer effect
  - intl: Internationalization

Assets:
  - images, icons directories
```

#### **analysis_options.yaml**
```yaml
Purpose: Dart/Flutter code analysis rules
Enforces:
  - Linting rules (avoid deprecated APIs, unused imports)
  - Code style standards
  - Strong mode type checking
```

#### **firebase.json**
```json
Purpose: Firebase CLI configuration
Contains:
  - Project configuration
  - Database rules
  - Hosting configuration (if applicable)
```

#### **.gitignore**
```
Purpose: Exclude files from version control
Excludes:
  - build/, .dart_tool/ (generated)
  - .env (local config)
  - Credentials/keys
  - IDE settings
```

---

## 🎯 ARCHITECTURE FLOW

```
┌─────────────────────────────────────────────────────┐
│            USER / FLUTTER UI (Pages)                │
│         (HomePage, LoginPage, TransferPage)          │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│       PRESENTATION LAYER (BLoCs)                    │
│  (AuthBloc, OtpBloc, AccountBloc, PaymentBloc)      │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│         DOMAIN LAYER (Business Logic)               │
│  (Entities, UseCases, Repository Interfaces)        │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│          DATA LAYER (Implementation)                │
│  (Repositories, Models, DataSources)                │
├──────────────────┬──────────────────┬──────────────┤
│                  │                  │              │
└─ Remote API ─────┴──────── Local ────┴─ Firebase ──┘
        │                        │          │
   [HTTP/Dio]          [Secure Storage]   [FCM]
```

---

## 📋 LAYER RESPONSIBILITIES

### **CORE LAYER**
- Infrastructure: API client, storage, navigation
- Configuration: Constants, theme, errors
- Utilities: Formatting, logging

### **DOMAIN LAYER**
- Pure business logic (no framework)
- Interfaces (repository contracts)
- Use case orchestration
- Independent from data/presentation

### **DATA LAYER**
- API calls (remote datasources)
- Local storage (local datasources)
- Models with JSON serialization
- Repository implementation (logic + error handling)

### **PRESENTATION LAYER**
- UI pages & widgets
- State management (BLoCs)
- User interaction handling
- Result display

---

## 🔄 DATA FLOW EXAMPLE (Login)

```
User taps "Login with Google"
    ↓
LoginPage emits AuthLoginWithFirebase event
    ↓
AuthBloc._onLoginWithFirebase() called
    ↓
Calls _verifyToken(firebaseToken) usecase
    ↓
VerifyFirebaseTokenUsecase calls authRepository.verifyFirebaseToken()
    ↓
AuthRepositoryImpl._remote.verifyFirebaseToken(token)
    ↓
AuthRemoteDatasourceImpl.verifyFirebaseToken(token)
    ↓
ApiClient.post("/auth/verify-token", data: {firebase_token})
    ↓
Success: Returns {user, token}
    ↓
Repository saves to local storage
    ↓
BLoC emits AuthNeedsVerification state
    ↓
UI navigates to 2FA setup page
```

---

## ⚠️ KNOWN ISSUES SUMMARY

| # | File | Issue | Severity |
|---|------|-------|----------|
| 1 | test/widget_test.dart | Wrong class name (MyApp) | 🔴 CRITICAL |
| 2 | auth_bloc.dart:7 | Unused import | 🟡 LOW |
| 3 | auth_bloc.dart:63 | Unused field | 🟡 LOW |
| 4 | Multiple pages | Unused imports (7) | 🟡 LOW |
| 5 | app_theme.dart:17 | Deprecated background API | 🟡 LOW |
| 6 | 3 pages | Deprecated translate() | 🟡 LOW |
| 7 | twofa_notif_page.dart:32 | Unsafe BuildContext usage | 🟡 LOW |
| 8 | twofa_smtp_page.dart:37-38 | Missing curly braces | 🟡 LOW |
| 9 | firebase_options.dart | iOS project mismatch | 🔴 CRITICAL |
| 10 | app_constants.dart:6 | Hardcoded localhost IP | 🔴 CRITICAL |
| 11 | account_bloc.dart | Missing 401 handling | 🟠 HIGH |
| 12 | payment_bloc.dart | Incomplete topup errors | 🟠 HIGH |
| 13 | otp_remote_datasource | Missing email implementation | 🟡 MEDIUM |

---

## 📚 NEXT STEPS

1. Review this structure document
2. Understand Clean Architecture flow
3. Execute COMMIT_STRATEGY.md (25+ commits)
4. Start with PHASE 1 (Critical Fixes)
5. Proceed through all phases sequentially

---

**Document Version:** 1.0  
**Last Updated:** 2026-06-13  
**Status:** Complete project structure documented

