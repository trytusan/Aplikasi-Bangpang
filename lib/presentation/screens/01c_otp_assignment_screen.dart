import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '02_dashboard_screen.dart';

class OtpAssignmentScreen extends StatefulWidget {
  const OtpAssignmentScreen({super.key});

  @override
  State<OtpAssignmentScreen> createState() => _OtpAssignmentScreenState();
}

class _OtpAssignmentScreenState extends State<OtpAssignmentScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<String> _sampleOtp = ['4', '8', '2', '0', '1', '9'];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].text = _sampleOtp[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Petugas & Lokasi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
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
                      // Card 1: OTP Input
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('KODE OTP KEAMANAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryAmberDark)),
                                  Icon(Icons.shield_outlined, size: 18, color: AppColors.primaryAmberDark),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Masukkan 6-digit kode verifikasi yang dikirim ke nomor WhatsApp dinas (+62 812-****-4432):',
                                style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                              const SizedBox(height: 14),

                              // 6-Digit OTP Boxes
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 44,
                                    height: 48,
                                    child: TextField(
                                      controller: _otpControllers[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textMain),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        filled: true,
                                        fillColor: AppColors.background,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderLight)),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryAmber, width: 2)),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Kirim ulang dalam 01:42', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                    child: const Text('Kirim Ulang', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.navyPrimary)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Card 2: Konfirmasi Titik Bagi Resmi
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('TITIK PENUGASAN RESMI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: AppColors.successGreenLight, borderRadius: BorderRadius.circular(12)),
                                    child: const Text('VALID', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.successGreen)),
                                  ),
                                ],
                              ),
                              const Divider(height: 20),
                              const Text('WILAYAH PENYALURAN', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSubtle)),
                              const SizedBox(height: 2),
                              const Text('Desa Banjar Bali, Kec. Buleleng', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                              const Text('Kabupaten Buleleng, Bali (81113)', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.borderLight)),
                                      child: const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Lokasi Fisik', style: TextStyle(fontSize: 9, color: AppColors.textSubtle)),
                                          SizedBox(height: 2),
                                          Text('Kantor Desa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.borderLight)),
                                      child: const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Alokasi Kuota', style: TextStyle(fontSize: 9, color: AppColors.textSubtle)),
                                          SizedBox(height: 2),
                                          Text('48 KPM (480 Kg)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primaryAmberDark)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFBFDBFE))),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gudang Asal: GBB Buleleng (Kancab Singaraja)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.navyPrimary)),
                                    SizedBox(height: 2),
                                    Text('Surat Tugas: ST-042/BPN-BLG/VII/2026', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
                      );
                    },
                    child: const Text('VERIFIKASI & MASUK DASHBOARD'),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Bukan Titik Penugasan Saya? Laporkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.dangerRed)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
