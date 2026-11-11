import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistorySummaryBar extends StatelessWidget {
  final VoidCallback onNewDelivery;

  const HistorySummaryBar({
    super.key,
    required this.onNewDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
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
      child: Column(
        children: [
          // Baris Metrik Ringkasan Transaksi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_rounded, size: 16, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 6),
                  RichText(
                    text: const TextSpan(
                      text: 'Total 45 Tercatat ',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                      children: [
                        TextSpan(
                          text: '• Desa Banjar Bali',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
                    ),
                    child: const Text(
                      '38 Sukses',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFECDD3)),
                    ),
                    child: const Text(
                      '2 Gagal',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFBE123C)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Tombol Utama Catat Penyerahan Baru
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE88B00),
                foregroundColor: const Color(0xFF0F172A),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                onNewDelivery();
              },
              icon: const Icon(Icons.add_circle_rounded, size: 19, color: Color(0xFF0F172A)),
              label: const Text(
                'Catat Penyerahan Baru',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
