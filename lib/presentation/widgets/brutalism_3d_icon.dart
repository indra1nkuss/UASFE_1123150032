import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Brutalism3DIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;
  final bool elevated;

  const Brutalism3DIcon({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 80,
    this.iconSize = 36,
    this.elevated = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    final mainColor = colors[1];

    if (!elevated) {
      // Flat brutalism design
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(
            color: AppColors.ink,
            width: 2.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.white,
            size: iconSize,
          ),
        ),
      );
    }

    // 3D Elevated brutalism design
    return SizedBox(
      width: size + 8,
      height: size + 8,
      child: Stack(
        children: [
          // Shadow base (3D effect)
          Positioned(
            bottom: 0,
            left: 4,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.charcoal.withValues(alpha: 0.3),
                border: Border.all(
                  color: AppColors.ink,
                  width: 2,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          // Main 3D block
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
                  right: BorderSide(color: AppColors.ink, width: 2.5),
                  bottom: BorderSide(color: AppColors.ink, width: 2.5),
                ),
                borderRadius: BorderRadius.zero,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Specialized icons for different categories
class Brutalism3DIconCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String tone;
  final VoidCallback? onTap;
  final double size;

  const Brutalism3DIconCard({
    super.key,
    required this.label,
    required this.icon,
    this.tone = 'blue',
    this.onTap,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Brutalism3DIcon(
            icon: icon,
            tone: tone,
            size: size,
            iconSize: size * 0.45,
            elevated: true,
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.charcoal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Payment action icons with brutalism 3D style
class PaymentActionIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accentColor;
  final VoidCallback? onTap;

  const PaymentActionIcon({
    super.key,
    required this.label,
    required this.icon,
    this.accentColor = AppColors.accent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 3D Icon with accent color
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              children: [
                // 3D base shadow
                Positioned(
                  bottom: 0,
                  left: 4,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      border: Border.all(
                        color: AppColors.charcoal,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // Main icon block
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: accentColor,
                      border: Border(
                        top: const BorderSide(
                          color: AppColors.white,
                          width: 2.5,
                        ),
                        left: const BorderSide(
                          color: AppColors.white,
                          width: 2.5,
                        ),
                        right: BorderSide(
                          color: accentColor == AppColors.accent
                              ? AppColors.charcoal
                              : AppColors.charcoal,
                          width: 2.5,
                        ),
                        bottom: BorderSide(
                          color: accentColor == AppColors.accent
                              ? AppColors.charcoal
                              : AppColors.charcoal,
                          width: 2.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: AppColors.charcoal,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.charcoal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Transaction type icons (phone, food, transfer, etc)
class TransactionTypeIcon extends StatelessWidget {
  final IconData icon;
  final String type; // 'topup', 'transfer', 'payment', etc
  final double size;

  const TransactionTypeIcon({
    super.key,
    required this.icon,
    required this.type,
    this.size = 48,
  });

  Color _getColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'topup':
        return AppColors.success;
      case 'transfer':
        return AppColors.info;
      case 'payment':
        return AppColors.warning;
      case 'food':
        return AppColors.warning;
      case 'phone':
        return AppColors.accent;
      case 'bills':
        return AppColors.error;
      case 'shopping':
        return AppColors.accent;
      default:
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getColorByType(type);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accentColor,
        border: Border.all(
          color: AppColors.charcoal,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.charcoal,
          size: size * 0.55,
        ),
      ),
    );
  }
}
