import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;
  final bool brutalism3d;

  const FeatureIcon({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 80,
    this.iconSize = 36,
    this.brutalism3d = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    final mainColor = colors[1];

    if (!brutalism3d) {
      // Legacy flat design
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors[0],
          borderRadius: BorderRadius.circular(size * 0.29),
        ),
        child: Center(
          child: Icon(icon, color: mainColor, size: iconSize),
        ),
      );
    }

    // Brutalism 3D design with beveled edges
    return SizedBox(
      width: size + 8,
      height: size + 8,
      child: Stack(
        children: [
          // 3D Shadow base for depth
          Positioned(
            bottom: 0,
            left: 4,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.charcoal.withValues(alpha: 0.25),
                border: Border.all(
                  color: AppColors.charcoal,
                  width: 2,
                ),
              ),
            ),
          ),
          // Main 3D block with beveled edges (white top-left, dark bottom-right)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: mainColor,
                border: Border(
                  top: BorderSide(color: AppColors.white, width: 2.5),
                  left: BorderSide(color: AppColors.white, width: 2.5),
                  right: BorderSide(color: AppColors.charcoal, width: 2.5),
                  bottom: BorderSide(color: AppColors.charcoal, width: 2.5),
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: iconSize,
                  weight: 600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Map design icon names to Material icons
class DkgIcons {
  // Navigation
  static const IconData home = Icons.home_outlined;
  static const IconData history = Icons.history_rounded;
  static const IconData scan = Icons.qr_code_scanner_rounded;
  static const IconData gift = Icons.card_giftcard_rounded;
  static const IconData user = Icons.person_outline_rounded;

  // Transfer & Payment
  static const IconData send = Icons.send_rounded;
  static const IconData wallet = Icons.account_balance_wallet_outlined;
  static const IconData money = Icons.attach_money_rounded;
  static const IconData card = Icons.credit_card_outlined;
  static const IconData payment = Icons.payment_outlined;
  static const IconData topup = Icons.account_balance_wallet_outlined;
  static const IconData qris = Icons.qr_code_2_rounded;
  static const IconData pulsa = Icons.phone_outlined;

  // Food & Restaurants
  static const IconData food = Icons.fastfood_rounded;
  static const IconData restaurant = Icons.restaurant_outlined;
  static const IconData cafe = Icons.local_cafe_outlined;

  // Phone & Communication
  static const IconData phone = Icons.phone_outlined;
  static const IconData phone2 = Icons.phone_outlined;
  static const IconData smartphone = Icons.smartphone_outlined;
  static const IconData phoneCall = Icons.phone_in_talk_outlined;
  static const IconData mail = Icons.mail_outline_rounded;
  static const IconData email = Icons.email_outlined;
  static const IconData message = Icons.message_outlined;
  static const IconData phoneLightning = Icons.flash_on_rounded;

  // Actions
  static const IconData plus = Icons.add_rounded;
  static const IconData subtract = Icons.remove_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData copy = Icons.copy_rounded;
  static const IconData share = Icons.share_rounded;
  static const IconData download = Icons.download_rounded;
  static const IconData upload = Icons.upload_rounded;

  // Status & Info
  static const IconData bell = Icons.notifications_outlined;
  static const IconData info = Icons.info_outlined;
  static const IconData warning = Icons.warning_outlined;
  static const IconData error = Icons.error_outline_rounded;
  static const IconData success = Icons.check_circle_outline_rounded;
  static const IconData check = Icons.check_rounded;

  // Security
  static const IconData shield = Icons.shield_outlined;
  static const IconData shieldCheck = Icons.verified_user_outlined;
  static const IconData lock = Icons.lock_outline_rounded;
  static const IconData unlock = Icons.lock_open_outlined;
  static const IconData security = Icons.security_rounded;
  static const IconData verified = Icons.verified_outlined;

  // Visibility
  static const IconData eye = Icons.visibility_outlined;
  static const IconData eyeOff = Icons.visibility_off_outlined;

  // Navigation
  static const IconData arrowLeft = Icons.arrow_back_ios_new_rounded;
  static const IconData arrowRight = Icons.arrow_forward_ios_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData menu = Icons.menu_rounded;

  // Search & Filter
  static const IconData search = Icons.search_rounded;
  static const IconData filter = Icons.filter_list_rounded;
  static const IconData sort = Icons.sort_rounded;

  // Settings & User
  static const IconData settings = Icons.settings_outlined;
  static const IconData logout = Icons.logout_rounded;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline_rounded;

  // Date & Time
  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData clock = Icons.schedule_rounded;
  static const IconData time = Icons.access_time_outlined;

  // Location
  static const IconData location = Icons.location_on_outlined;
  static const IconData directions = Icons.directions_rounded;

  // Shopping
  static const IconData shopping = Icons.shopping_bag_outlined;
  static const IconData shoppingCart = Icons.shopping_cart_outlined;
  static const IconData store = Icons.store_outlined;
  static const IconData storefront = Icons.storefront_outlined;

  // Favorites
  static const IconData favorite = Icons.favorite_outline_rounded;
  static const IconData unfavorite = Icons.favorite_border_rounded;
  static const IconData star = Icons.star_outline_rounded;
  static const IconData starFilled = Icons.star_rounded;

  // Media
  static const IconData camera = Icons.camera_alt_outlined;
  static const IconData gallery = Icons.collections_outlined;
  static const IconData image = Icons.image_outlined;
  static const IconData video = Icons.videocam_outlined;
  static const IconData play = Icons.play_circle_outlined;
  static const IconData pause = Icons.pause_circle_outlined;
  static const IconData stop = Icons.stop_circle_outlined;

  // Links
  static const IconData link = Icons.link_rounded;
  static const IconData linkOff = Icons.link_off_rounded;

  // Tech
  static const IconData code = Icons.code_rounded;
  static const IconData api = Icons.api_rounded;
  static const IconData database = Icons.storage_rounded;
  static const IconData server = Icons.dns_rounded;
  static const IconData cloud = Icons.cloud_outlined;
  static const IconData cloudUpload = Icons.cloud_upload_outlined;
  static const IconData cloudDownload = Icons.cloud_download_outlined;

  // Travel
  static const IconData flight = Icons.flight_outlined;
  static const IconData hotel = Icons.hotel_outlined;
  static const IconData transport = Icons.directions_car_outlined;

  // Finance
  static const IconData coins = Icons.monetization_on_outlined;
  static const IconData percent = Icons.percent_rounded;
  static const IconData trending = Icons.trending_up_rounded;
  static const IconData trendingDown = Icons.trending_down_rounded;
  static const IconData chart = Icons.bar_chart_outlined;
  static const IconData pie = Icons.pie_chart_rounded;
  static const IconData analytics = Icons.analytics_outlined;
}
