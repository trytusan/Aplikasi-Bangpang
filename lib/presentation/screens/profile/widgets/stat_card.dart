import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final int totalBast;
  final int remainingQuota;

  const StatCard({
    super.key,
    this.totalBast = 184,
    this.remainingQuota = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF059669), size: 16),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total BAST Hari Ini', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Text('$totalBast', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                        const SizedBox(width: 4),
                        const Text('KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.shield_outlined, color: Color(0xFFD97706), size: 16),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sisa Kuota Titik', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Text('$remainingQuota', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFFB45309))),
                        const SizedBox(width: 4),
                        const Text('KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
