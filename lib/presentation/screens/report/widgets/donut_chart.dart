import 'package:flutter/material.dart';
import '../../../../data/repositories/bast_repository.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: BastRepository.instance,
      builder: (context, _) {
        final total = BastRepository.instance.totalQuota;
        final distributed = BastRepository.instance.distributedCount;
        final remaining = BastRepository.instance.remainingCount;
        final percent = BastRepository.instance.percentage;
        final totalKg = BastRepository.instance.totalKg;
        final totalTargetKg = BastRepository.instance.totalTargetKg;
        final normalCount = BastRepository.instance.normalCount;
        final replacementCount = BastRepository.instance.replacementCount;

        final normalPct = total > 0 ? (normalCount / total) * 100 : 0.0;
        final replPct = total > 0 ? (replacementCount / total) * 100 : 0.0;
        final remainPct = total > 0 ? (remaining / total) * 100 : 0.0;

        return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Judul & Status Real-time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Realisasi Penyaluran Beras CPP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Cadangan Pangan Pemerintah Alokasi 10 Kg',
                    style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Real-time',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Horizontal Bar Breakdown Chart
          _buildCategoryBarItem(
            title: 'Diserahkan Langsung',
            subtitle: 'PBP Normal',
            count: normalCount,
            unit: 'KPM',
            percentage: normalPct,
            barColor: const Color(0xFF059669),
          ),
          _buildCategoryBarItem(
            title: 'Penerima Pengganti',
            subtitle: 'SPTJM Sah',
            count: replacementCount,
            unit: 'KPM',
            percentage: replPct,
            barColor: const Color(0xFF4F46E5),
          ),
          _buildCategoryBarItem(
            title: 'Belum Hadir / Antre',
            subtitle: 'Meja Penyaluran',
            count: remaining,
            unit: 'KPM',
            percentage: remainPct,
            barColor: const Color(0xFF0284C7),
          ),
          const SizedBox(height: 6),

          // Total Kg Disalurkan Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inventory_2_rounded, size: 14, color: Color(0xFF1E3A8A)),
                const SizedBox(width: 6),
                Text(
                  'Total Disalurkan: $totalKg Kg / $totalTargetKg Kg Beras CBP (${percent.toStringAsFixed(1)}%)',
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2 Kartu Metrik di Bawah Chart
          Row(
            children: [
              // Diserahkan
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('DISERAHKAN', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                          Icon(Icons.check_circle_rounded, size: 13, color: Color(0xFF059669)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          text: '$distributed ',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                          children: const [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: total > 0 ? distributed / total : 0.0,
                          minHeight: 4,
                          backgroundColor: const Color(0xFFBBF7D0),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF059669)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Realisasi', style: TextStyle(fontSize: 8.5, color: Color(0xFF065F46), fontWeight: FontWeight.w600)),
                          Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF047857))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Sisa Belum
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFECDD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SISA BELUM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF9F1239))),
                          Icon(Icons.pending_actions_rounded, size: 13, color: Color(0xFFE11D48)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          text: '$remaining ',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFBE123C)),
                          children: const [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF9F1239))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: total > 0 ? remaining / total : 0.0,
                          minHeight: 4,
                          backgroundColor: const Color(0xFFFFCDD2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE11D48)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sisa Stok', style: TextStyle(fontSize: 8.5, color: Color(0xFF9F1239), fontWeight: FontWeight.w600)),
                          Text('${remainPct.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFFBE123C))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
      },
    );
  }

  Widget _buildCategoryBarItem({
    required String title,
    required String subtitle,
    required int count,
    required String unit,
    required double percentage,
    required Color barColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        '($subtitle)',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$count $unit',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(width: 14),
                  SizedBox(
                    width: 32,
                    child: Text(
                      '${percentage.toStringAsFixed(0)}%',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Progress Bar Track & Fill
          Container(
            height: 6.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: percentage > 0
                ? FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (percentage / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
