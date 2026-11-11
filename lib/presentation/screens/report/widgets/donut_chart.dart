import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({super.key});

  @override
  Widget build(BuildContext context) {
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

          // Diagram Donat
          const Center(
            child: SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CircularProgressIndicator(
                      value: 0.896,
                      strokeWidth: 14,
                      backgroundColor: Color(0xFFF43F5E),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF059669)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '48',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'KPM',
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFF64748B)),
                      ),
                      Text(
                        'Total Kuota Desa',
                        style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Total Kg Disalurkan Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_rounded, size: 14, color: Color(0xFF1E3A8A)),
                SizedBox(width: 6),
                Text(
                  'Total Disalurkan: 430 Kg / 480 Kg Beras CBP (89.6%)',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
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
                        text: const TextSpan(
                          text: '43 ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                          children: [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: const LinearProgressIndicator(
                          value: 0.896,
                          minHeight: 4,
                          backgroundColor: Color(0xFFBBF7D0),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF059669)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Realisasi', style: TextStyle(fontSize: 8.5, color: Color(0xFF065F46), fontWeight: FontWeight.w600)),
                          Text('89.6%', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF047857))),
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
                        text: const TextSpan(
                          text: '5 ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFBE123C)),
                          children: [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF9F1239))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: const LinearProgressIndicator(
                          value: 0.104,
                          minHeight: 4,
                          backgroundColor: Color(0xFFFFCDD2),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE11D48)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sisa Stok', style: TextStyle(fontSize: 8.5, color: Color(0xFF9F1239), fontWeight: FontWeight.w600)),
                          Text('10.4%', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFFBE123C))),
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
  }
}
