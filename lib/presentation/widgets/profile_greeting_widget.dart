import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileGreetingWidget extends StatefulWidget {
  const ProfileGreetingWidget({super.key});

  @override
  State<ProfileGreetingWidget> createState() => _ProfileGreetingWidgetState();
}

class _ProfileGreetingWidgetState extends State<ProfileGreetingWidget>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _greetingController;
  late Animation<double> _glowAnimation;
  late Animation<double> _greetingOpacity;

  String _greeting = '';
  IconData _greetingIcon = Icons.wb_sunny_rounded;

  @override
  void initState() {
    super.initState();
    _updateGreeting();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Glow animation - pulse effect
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Greeting fade animation
    _greetingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _greetingOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _greetingController, curve: Curves.easeIn),
    );

    _greetingController.forward();
  }

  void _updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Selamat Pagi';
      _greetingIcon = Icons.wb_sunny_rounded;
    } else if (hour >= 12 && hour < 15) {
      _greeting = 'Selamat Siang';
      _greetingIcon = Icons.wb_sunny_rounded;
    } else if (hour >= 15 && hour < 18) {
      _greeting = 'Selamat Sore';
      _greetingIcon = Icons.cloud_rounded;
    } else {
      _greeting = 'Selamat Malam';
      _greetingIcon = Icons.nights_stay_rounded;
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile avatar with gradient glow animation (SMALLER)
        AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(
                      alpha: 0.3 * _glowAnimation.value,
                    ),
                    blurRadius: 16 * _glowAnimation.value,
                    spreadRadius: 1 * _glowAnimation.value,
                  ),
                ],
                border: Border.all(
                  color: AppColors.accent,
                  width: 1.5,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.accent.withValues(
                      alpha: _glowAnimation.value,
                    ),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/indra.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback jika foto tidak ada
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.accent,
                              AppColors.accentLight,
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'I',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        // Greeting text with animation (SMALLER)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _greetingOpacity,
                child: Row(
                  children: [
                    Icon(
                      _greetingIcon,
                      color: AppColors.accent,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _greeting,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              FadeTransition(
                opacity: _greetingOpacity,
                child: const Text(
                  'Indra',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Notification widget (GRAY BACKGROUND + GLOWING BELL)
        _buildNotificationWidget(),
      ],
    );
  }

  Widget _buildNotificationWidget() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.line2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.silver,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(
                  alpha: 0.2 * _glowAnimation.value,
                ),
                blurRadius: 12 * _glowAnimation.value,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Notification bell icon with glow
              Icon(
                Icons.notifications_rounded,
                size: 24,
                color: AppColors.accent.withValues(
                  alpha: 0.6 + (0.4 * _glowAnimation.value),
                ),
              ),
              // Blinking dot
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(
                      alpha: _glowAnimation.value,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(
                          alpha: 0.6 * _glowAnimation.value,
                        ),
                        blurRadius: 6 * _glowAnimation.value,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
