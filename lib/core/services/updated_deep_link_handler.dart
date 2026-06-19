import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/deeplink_payment_entity.dart';

/// Handler untuk menerima dan mengirim Deep Link.
///
/// Alur:
/// 1. RentBike membuka emoneyid://pay?trxId=...&bikeName=...&amount=...
/// 2. eMoneyID menampilkan halaman konfirmasi pembayaran
/// 3. Setelah bayar berhasil, buka rentbike://success?trxId=...&status=success
class DeepLinkHandler {
  static final AppLinks _appLinks = AppLinks();
  static DeepLinkPaymentEntity? pendingPaymentData;

  /// Mulai mendengarkan deep link yang masuk saat aplikasi sudah berjalan (foreground).
  static Future<void> init(Function(Map<String, String>) onDeepLinkReceived) async {
    _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('[DeepLink] Received (stream): $uri');
        if (uri.scheme == 'emoneyid' && uri.host == 'pay') {
          final params = uri.queryParameters;
          onDeepLinkReceived(params);
        }
      },
      onError: (error) {
        debugPrint('[DeepLink] Stream error: $error');
      },
    );
  }

  /// Menangani deep link saat aplikasi pertama kali dibuka dari killed state.
  static Future<bool> handleInitialUri(
      Function(Map<String, String>) onDeepLinkReceived) async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint('[DeepLink] Initial URI: $initialUri');
        if (initialUri.scheme == 'emoneyid' && initialUri.host == 'pay') {
          final params = initialUri.queryParameters;
          onDeepLinkReceived(params);
          return true;
        }
      }
    } catch (e) {
      debugPrint('[DeepLink] getInitialLink error: $e');
    }
    return false;
  }

  /// Membuka kembali aplikasi RentBike dengan callback rentbike://success
  /// setelah pembayaran berhasil.
  static Future<void> returnToRentBike({
    required String trxId,
    required bool success,
  }) async {
    final callbackUri = Uri(
      scheme: 'rentbike',
      host: 'success',
      queryParameters: {
        'trxId': trxId,
        'status': success ? 'success' : 'failed',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    debugPrint('[DeepLink] Return to RentBike: $callbackUri');

    try {
      await launchUrl(callbackUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('[DeepLink] Error membuka RentBike: $e');
      // Coba tanpa mode spesifik
      try {
        await launchUrl(callbackUri);
      } catch (e2) {
        debugPrint('[DeepLink] Tetap gagal membuka RentBike: $e2');
      }
    }
  }
}
