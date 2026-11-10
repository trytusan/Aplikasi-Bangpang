import 'package:flutter/material.dart';

class HistorySummaryBar extends StatelessWidget {
  final VoidCallback onNewDelivery;

  const HistorySummaryBar({
    super.key,
    required this.onNewDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined, size: 16, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 6),
                  RichText(
                    text: const TextSpan(
                      text: 'Total 45 Tercatat ',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                      children: [
                        TextSpan(text: 'di Desa Banjar...', style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(6)),
                    child: const Text('38 Sukses', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFFE4E6), borderRadius: BorderRadius.circular(6)),
                    child: const Text('2 Gagal', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE88B00),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onNewDelivery,
              icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.black),
              label: const Text('Catat Penyerahan Baru', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
