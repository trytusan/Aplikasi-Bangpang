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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LANGKAH $currentStep DARI $totalSteps',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD97706),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                stageTitle,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(totalSteps, (index) {
              final bool isActive = index + 1 <= currentStep;
              return Expanded(
                child: Container(
                  height: 6,
                  margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 6),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFE88B00) : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1. Jenis', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFFD97706))),
              Text('2. Scan QR', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
              Text('3. Verifikasi', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
              Text('4. Geotag', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }
}
