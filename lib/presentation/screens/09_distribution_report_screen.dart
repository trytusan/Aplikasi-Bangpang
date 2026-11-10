import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DistributionReportScreen extends StatelessWidget {
  const DistributionReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Realisasi Distribusi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Radial / Bar Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('TOTAL REALISASI DESA BANJAR BALI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSubtle)),
                                  Text('89.5% SELESAI', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.successGreen)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: const LinearProgressIndicator(
                                  value: 0.895,
                                  minHeight: 10,
                                  backgroundColor: AppColors.background,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.successGreen),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('43 Tersalurkan (430 Kg)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMain)),
                                  Text('5 Belum Ambil (50 Kg)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryAmberDark)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Breakdown per RW / Dusun
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('BREAKDOWN PER BANJAR / DUSUN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.navyPrimary)),
                              const SizedBox(height: 12),
                              _dusunProgress('Dusun Kelodan (RW 01)', 20, 20, 1.0, AppColors.successGreen),
                              const SizedBox(height: 12),
                              _dusunProgress('Dusun Kanginan (RW 02)', 15, 18, 0.83, AppColors.primaryAmberDark),
                              const SizedBox(height: 12),
                              _dusunProgress('Dusun Kaleran (RW 03)', 8, 10, 0.80, AppColors.primaryAmberDark),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // 5 KPM Belum Ambil
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('5 KPM BELUM MENGAMBIL BANTUAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.dangerRed)),
                              const SizedBox(height: 8),
                              _kpmPendingRow('KOMANG ARTAWAN', 'RT 01 / RW 02 • Dusun Kanginan'),
                              const Divider(height: 14),
                              _kpmPendingRow('WAYAN SUDARMA', 'RT 03 / RW 02 • Dusun Kanginan'),
                              const Divider(height: 14),
                              _kpmPendingRow('KETUT BUDIARTHA', 'RT 02 / RW 03 • Dusun Kaleran'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navyPrimary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mengunduh Rekap Berita Acara PDF...')),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.picture_as_pdf_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('UNDUH REKAPITULASI BAST (PDF)'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dusunProgress(String nama, int salur, int total, double ratio, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nama, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMain)),
            Text('$salur / $total KPM (${(ratio * 100).toInt()}%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 6,
            backgroundColor: AppColors.background,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _kpmPendingRow(String nama, String dusun) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textMain)),
            Text(dusun, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
          child: const Text('Hubungi RT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.navyPrimary)),
        ),
      ],
    );
  }
}
