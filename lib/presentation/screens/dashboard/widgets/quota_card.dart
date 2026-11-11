import 'package:flutter/material.dart';

class QuotaCard extends StatelessWidget {
  final int totalQuota;
  final int distributed;
  final int remaining;

  const QuotaCard({
    super.key,
    this.totalQuota = 48,
    this.distributed = 43,
    this.remaining = 5,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalQuota > 0 ? (distributed / totalQuota) : 0.0;
    final int percentInt = (percentage * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Bagian & Status Alokasi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  'Penyerahan',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Text(
                    'Tahap III',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB45309),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_month_rounded, size: 12, color: Color(0xFF64748B)),
                  SizedBox(width: 4),
                  Text(
                    'Alokasi 2024',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Kartu Utama Metrik
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3 Kolom Metrik Angka
              Row(
                children: [
                  // Total Kuota
                  Expanded(
                    child: _buildMetricTile(
                      label: 'Total Kuota',
                      value: '$totalQuota',
                      unit: 'KPM',
                      bgColor: const Color(0xFFF8FAFC),
                      textColor: const Color(0xFF0F172A),
                      labelColor: const Color(0xFF64748B),
                      icon: Icons.inventory_2_rounded,
                      iconColor: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Diserahkan
                  Expanded(
                    child: _buildMetricTile(
                      label: 'Diserahkan',
                      value: '$distributed',
                      unit: 'KPM',
                      bgColor: const Color(0xFFECFDF5),
                      textColor: const Color(0xFF059669),
                      labelColor: const Color(0xFF047857),
                      icon: Icons.check_circle_rounded,
                      iconColor: const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Sisa
                  Expanded(
                    child: _buildMetricTile(
                      label: 'Sisa',
                      value: '$remaining',
                      unit: 'KPM',
                      bgColor: const Color(0xFFFFF1F2),
                      textColor: const Color(0xFFE11D48),
                      labelColor: const Color(0xFFBE123C),
                      icon: Icons.pending_actions_rounded,
                      iconColor: const Color(0xFFF43F5E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Progress Bar Visual Penyaluran
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.trending_up_rounded, size: 14, color: Color(0xFF059669)),
                          const SizedBox(width: 4),
                          Text(
                            '$percentInt% Selesai Disalurkan',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$distributed dari $totalQuota KPM',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        Container(
                          height: 7,
                          width: double.infinity,
                          color: const Color(0xFFF1F5F9),
                        ),
                        FractionallySizedBox(
                          widthFactor: percentage.clamp(0.0, 1.0),
                          child: Container(
                            height: 7,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF34D399), Color(0xFF059669)],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required String unit,
    required Color bgColor,
    required Color textColor,
    required Color labelColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: labelColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            unit,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
