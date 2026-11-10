import 'package:flutter/material.dart';

class OfficerNotice extends StatelessWidget {
  const OfficerNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_rounded, color: Color(0xFFD97706), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perhatian Khusus Petugas Lapangan',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFFB45309)),
                ),
                SizedBox(height: 2),
                Text(
                  'Pastikan fisik beras telah diserahterimakan dan Berita Acara telah ditandatangani/cap jempol sebelum menekan tombol Kirim BAST. Data tersinkronisasi langsung ke sistem pusat PANGAN BULOG.',
                  style: TextStyle(fontSize: 9.5, color: Color(0xFF92400E), height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
