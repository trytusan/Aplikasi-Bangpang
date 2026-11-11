import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BanpangBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BanpangBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: const Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tab Penyerahan (0)
              _buildNavItem(
                index: 0,
                icon: Icons.inventory_2_rounded,
                activeIcon: Icons.inventory_2_rounded,
                label: 'Penyerahan',
                isActive: currentIndex == 0,
              ),

              // Tab Pengaturan (1)
              _buildNavItem(
                index: 1,
                icon: Icons.tune_rounded,
                activeIcon: Icons.tune_rounded,
                label: 'Pengaturan',
                isActive: currentIndex == 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call(index);
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFEF3C7) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                color: isActive ? const Color(0xFF92400E) : const Color(0xFF64748B),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
