import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrTabSwitcher extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChanged;

  const QrTabSwitcher({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Tab 0: Scan QR Barcode
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onTabChanged(0);
              },
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: activeTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: activeTab == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 17,
                      color: activeTab == 0 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'Scan QR Barcode',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: activeTab == 0 ? FontWeight.w900 : FontWeight.w600,
                        color: activeTab == 0 ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab 1: Input Manual
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onTabChanged(1);
              },
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: activeTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: activeTab == 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_alt_rounded,
                      size: 17,
                      color: activeTab == 1 ? const Color(0xFFE88B00) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'Input Manual',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: activeTab == 1 ? FontWeight.w900 : FontWeight.w600,
                        color: activeTab == 1 ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
