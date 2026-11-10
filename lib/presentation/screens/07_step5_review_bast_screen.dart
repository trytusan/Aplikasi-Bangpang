import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '08_history_list_screen.dart';

class Step5ReviewBastScreen extends StatefulWidget {
  const Step5ReviewBastScreen({super.key});

  @override
  State<Step5ReviewBastScreen> createState() => _Step5ReviewBastScreenState();
}

class _Step5ReviewBastScreenState extends State<Step5ReviewBastScreen> {
  bool _hasSignature = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Langkah Terakhir', style: TextStyle(fontSize: 10, color: AppColors.primaryAmber, fontWeight: FontWeight.w700)),
            Text('Review & Finalisasi BAST', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Ringkasan Dokumen BAST
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('NO. BAST: BAST/2026/09/BLG-0043', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.navyPrimary)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(6)),
                                    child: const Text('TAHAP II', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
                                  ),
                                ],
                              ),
                              const Divider(height: 18),
                              _bastRow('Penerima KPM', 'I KETUT WIDNYANA', true),
                              const SizedBox(height: 6),
                              _bastRow('NIK KTP', '5108051205780004', false, isMono: true),
                              const SizedBox(height: 6),
                              _bastRow('Komoditas', 'Beras Medium CPP 1 Sak (10 Kg)', true, color: AppColors.primaryAmberDark),
                              const SizedBox(height: 6),
                              _bastRow('Metode Serah', 'Diambil Sendiri (KTP Asli)', false),
                              const SizedBox(height: 6),
                              _bastRow('Petugas Lapangan', 'Yogik Kurniawan (Satgas Bapanas)', false),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Canvas Tanda Tangan Digital
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('TANDA TANGAN DIGITAL KPM / SAKSI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                                  TextButton(
                                    onPressed: () => setState(() => _hasSignature = !_hasSignature),
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                    child: const Text('Reset', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.dangerRed)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.borderLight, style: BorderStyle.solid),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (_hasSignature)
                                      CustomPaint(
                                        size: const Size(200, 80),
                                        painter: _MockSignaturePainter(),
                                      )
                                    else
                                      const Text('Tanda tangani di sini dengan jari', style: TextStyle(fontSize: 11, color: AppColors.textSubtle)),
                                    const Positioned(
                                      bottom: 6,
                                      right: 8,
                                      child: Text('Hash: 8F2A-99B1-2026', style: TextStyle(fontSize: 8, fontFamily: 'monospace', color: AppColors.textSubtle)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Offline Cache Notice
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.successGreenLight, borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            Icon(Icons.lock_clock_outlined, size: 16, color: AppColors.successGreen),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Data tersimpan lokal dan otomatis sinkronisasi ke server pusat Bapanas.',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.successGreen),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('✓ Berita Acara (BAST) Berhasil Diterbitkan & Disimpan!')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryListScreen()),
                    (route) => route.isFirst,
                  );
                },
                child: const Text('FINALISASI & TERBITKAN BAST RESMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bastRow(String label, String value, bool isBold, {bool isMono = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            fontFamily: isMono ? 'monospace' : null,
            color: color ?? AppColors.textMain,
          ),
        ),
      ],
    );
  }
}

// Simulasi coretan tanda tangan digital KPM
class _MockSignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.navyDark
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(20, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.2, size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.9, size.width * 0.9, size.height * 0.4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
