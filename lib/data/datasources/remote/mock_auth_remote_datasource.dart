import '../../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<({UserModel user, String token})> verifyFirebaseToken(String firebaseToken);
  Future<({UserModel user, String token})> registerWithOtp(String firebaseToken);
  Future<void> verifyEmailOtp(String code);
  Future<UserModel> getMe();
  Future<void> updateFcmToken(String fcmToken);
  void clearAuthToken();
}

class MockAuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  static const String _mockToken = 'mock_jwt_token_12345';

  @override
  Future<({UserModel user, String token})> verifyFirebaseToken(String firebaseToken) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final user = UserModel(
      id: 1,
      firebaseUid: 'firebase_uid_123',
      email: 'user@dompet.id',
      name: 'Inkus Cahya',
      role: 'user',
      emailVerified: true,
      totpEnabled: false,
      twoFaMethod: null,
    );

    return (user: user, token: _mockToken);
  }

  @override
  Future<({UserModel user, String token})> registerWithOtp(String firebaseToken) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final user = UserModel(
      id: 2,
      firebaseUid: firebaseToken,
      email: 'newuser@dompet.id',
      name: 'New User',
      role: 'user',
      emailVerified: false,
      totpEnabled: false,
      twoFaMethod: null,
    );

    return (user: user, token: _mockToken);
  }

  @override
  Future<void> verifyEmailOtp(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Auto-approve any OTP for mock
  }

  @override
  Future<UserModel> getMe() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel(
      id: 1,
      firebaseUid: 'firebase_uid_123',
      email: 'user@dompet.id',
      name: 'Inkus Cahya',
      role: 'user',
      emailVerified: true,
      totpEnabled: false,
      twoFaMethod: null,
    );
  }

  @override
  Future<void> updateFcmToken(String fcmToken) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  void clearAuthToken() {}
}
