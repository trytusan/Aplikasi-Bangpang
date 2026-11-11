import 'package:flutter/material.dart';

class StepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stageTitle;

  const StepProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
    required this.stageTitle,
  });

  @override
  Widget build(BuildContext context) {
    const steps = [
      {'title': '1. Jenis', 'icon': Icons.tune_rounded},
      {'title': '2. Scan QR', 'icon': Icons.qr_code_scanner_rounded},
      {'title': '3. Verifikasi', 'icon': Icons.verified_user_rounded},
      {'title': '4. Geotag', 'icon': Icons.camera_alt_rounded},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Langkah & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD97706),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'LANGKAH $currentStep DARI $totalSteps',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFB45309),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                stageTitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Bar Progress Segmen
          Row(
            children: List.generate(totalSteps, (index) {
              final bool isActive = index + 1 <= currentStep;
              final bool isCurrent = index + 1 == currentStep;

              return Expanded(
                child: Container(
                  height: 6,
                  margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 6),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [Color(0xFFE88B00), Color(0xFFF59E0B)],
                          )
                        : null,
                    color: isActive ? null : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: const Color(0xFFE88B00).withValues(alpha: 0.35),
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),

          // Label Langkah
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              final bool isActive = index + 1 <= currentStep;
              final item = steps[index];

              return Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 11,
                    color: isActive ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                      color: isActive ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
