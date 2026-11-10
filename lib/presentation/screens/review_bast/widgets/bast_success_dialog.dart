import 'package:flutter/material.dart';
import '../../dashboard/dashboard_screen.dart';

class BastSuccessDialog extends StatelessWidget {
  final String bastNumber;
  final String recipientName;
  final String nik;
  final String deliveryType;
  final String address;

  const BastSuccessDialog({
    super.key,
    this.bastNumber = 'BAST-20250723108062005',
    this.recipientName = 'LUH SUMANTRI ARYANI',
    this.nik = '5108065209840002',
    this.deliveryType = 'Alur Pengganti (SPTJM Sah)',
    this.address = 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Success Animated Glow
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFA7F3D0), width: 3),
              ),
              child: const Center(
                child: Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 44),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Penyerahan Berhasil!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              'Data BAST telah diverifikasi, ditandatangani, dan berhasil disinkronkan ke server pusat BULOG.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3),
            ),
            const SizedBox(height: 14),

            // Kartu Ringkasan BAST
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nomor BAST', style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      Text(
                        bastNumber,
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A), fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Penerima Manfaat', style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      Text(recipientName, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('NIK Terdaftar', style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      Text(nik, style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF0F172A))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Bantuan Diserahkan', style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      const Text('10 Kg Beras CPP (1 Karung)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status Alur', style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      Text(deliveryType, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFD97706))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Unduh Bukti PDF
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE88B00)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  foregroundColor: const Color(0xFFB45309),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Bukti BAST "$bastNumber.pdf" berhasil diunduh ke perangkat!')),
                        ],
                      ),
                      backgroundColor: const Color(0xFF059669),
                    ),
                  );
                },
                icon: const Icon(Icons.download_for_offline_outlined, size: 18),
                label: const Text('Unduh Berita Acara (PDF)', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 8),

            // Tombol Selesai & Kembali ke Dashboard
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE88B00),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home_outlined, size: 18, color: Colors.black),
                label: const Text('Selesai & Ke Beranda', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
