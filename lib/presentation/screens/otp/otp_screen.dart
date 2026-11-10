import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../dashboard/dashboard_screen.dart';
import 'widgets/assignment_location.dart';
import 'widgets/otp_input.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<String> _sampleOtp = ['4', '8', '2', '0', '1', '9'];
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].text = _sampleOtp[i];
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyAndProceed() async {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi 6-digit kode OTP keamanan.'),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Otorisasi Petugas Berhasil! Lokasi Titik Bagi: Desa Banjar Bali.'),
        backgroundColor: Color(0xFF059669),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  void _showReportLocationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Laporkan Perubahan Lokasi'),
        content: const Text(
          'Jika Anda ditugaskan di desa/kelurahan yang berbeda dengan Desa Banjar Bali, silakan konfirmasi ke Koordinator Lapangan Kecamatan Buleleng untuk perpindahan kuota titik bagi.',
          style: TextStyle(fontSize: 12, height: 1.3),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dangerRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Laporan ketidaksesuaian penugasan telah diteruskan ke Korlap!')),
              );
            },
            child: const Text('Kirim Laporan'),
          ),
        ],
      ),
    );
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
                      OtpInput(
                        controllers: _otpControllers,
                        onOtpComplete: _verifyAndProceed,
                      ),
                      const SizedBox(height: 12),
                      const AssignmentLocation(),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE88B00),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _isVerifying ? null : _verifyAndProceed,
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black),
                            )
                          : const Text(
                              'VERIFIKASI & MASUK DASHBOARD',
                              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Colors.black),
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: _showReportLocationDialog,
                    child: const Text(
                      'Bukan Titik Penugasan Saya? Laporkan',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.dangerRed),
                    ),
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
