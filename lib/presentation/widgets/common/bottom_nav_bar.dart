import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tab Penyerahan (0)
              GestureDetector(
                onTap: () => onTap?.call(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inbox_rounded,
                      color: currentIndex == 0 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Penyerahan',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: currentIndex == 0 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Pengaturan (1)
              GestureDetector(
                onTap: () => onTap?.call(1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      color: currentIndex == 1 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pengaturan',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: currentIndex == 1 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
