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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Realisasi Penyaluran Beras\nCPP',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                  ),
                  SizedBox(height: 2),
                  Text('Cadangan Pangan Pemerintah Alokasi 10 Kg', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: Color(0xFF059669)),
                    SizedBox(width: 4),
                    Text('Real-time', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

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
                      backgroundColor: Color(0xFFE11D48),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF047857)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('48', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1)),
                      Text('KPM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                      Text('Total Kuota Desa', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
            child: const Text(
              'Total Disalurkan: 430 Kg / 480 Kg Beras CBP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('DISERAHKAN', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                          Icon(Icons.check_circle, size: 12, color: Color(0xFF059669)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: const TextSpan(
                          text: '43 ',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                          children: [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF065F46))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: const LinearProgressIndicator(
                          value: 0.896,
                          minHeight: 4,
                          backgroundColor: Colors.white54,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF047857)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Realisasi', style: TextStyle(fontSize: 8, color: Color(0xFF065F46))),
                          Text('89.6%', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF047857))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SISA BELUM', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF9F1239))),
                          Icon(Icons.inventory_2_outlined, size: 12, color: Color(0xFFE11D48)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: const TextSpan(
                          text: '5 ',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFFE11D48)),
                          children: [
                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF9F1239))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: const LinearProgressIndicator(
                          value: 0.104,
                          minHeight: 4,
                          backgroundColor: Colors.white54,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE11D48)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sisa Stok', style: TextStyle(fontSize: 8, color: Color(0xFF9F1239))),
                          Text('10.4%', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
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
