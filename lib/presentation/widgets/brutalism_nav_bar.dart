import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BrutalismNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BrutalismNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BrutalismNavBar> createState() => _BrutalismNavBarState();
}

class _BrutalismNavBarState extends State<BrutalismNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.charcoal,
            width: 2,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: widget.currentIndex == 0,
              onTap: () => widget.onTap(0),
            ),
            _NavBarItem(
              icon: Icons.history_rounded,
              label: 'History',
              isActive: widget.currentIndex == 1,
              onTap: () => widget.onTap(1),
            ),
            _NavBarItem(
              icon: Icons.qr_code_2_rounded,
              label: 'Scan',
              isActive: widget.currentIndex == 2,
              onTap: () => widget.onTap(2),
            ),
            _NavBarItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isActive: widget.currentIndex == 3,
              onTap: () => widget.onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _borderAnimation = Tween<double>(begin: 0, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.isActive ? AppColors.accent : Colors.transparent,
                  width: _borderAnimation.value,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Icon(
                    widget.icon,
                    size: 28,
                    color: widget.isActive ? AppColors.accent : AppColors.slate,
                    weight: widget.isActive ? 600 : 400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 11,
                    fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
                    color: widget.isActive ? AppColors.charcoal : AppColors.slate,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
