import '../../../domain/entities/otp_entity.dart';

abstract class OtpRemoteDatasource {
  Future<OtpSentEntity> sendOtpFirebase();
  Future<OtpSentEntity> sendOtpEmail();
  Future<void> confirmOtp({required String code, required String otpType});
  Future<TotpSetupEntity> registerTotp();
  Future<bool> verifyTotp(String code);
}

class MockOtpRemoteDatasourceImpl implements OtpRemoteDatasource {
  @override
  Future<OtpSentEntity> sendOtpFirebase() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return OtpSentEntity(
      otpType: 'firebase',
      expiresIn: 600,
    );
  }

  @override
  Future<OtpSentEntity> sendOtpEmail() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return OtpSentEntity(
      otpType: 'email',
      expiresIn: 600,
    );
  }

  @override
  Future<void> confirmOtp({required String code, required String otpType}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Auto-approve any OTP code for mock
  }

  @override
  Future<TotpSetupEntity> registerTotp() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return TotpSetupEntity(
      secret: 'JBSWY3DPEHPK3PXP',
      qrCode: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
      issuer: 'DKG',
      account: 'user@dompet.id',
    );
  }

  @override
  Future<bool> verifyTotp(String code) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Auto-approve any TOTP code for mock
    return true;
  }
}
