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
                      OtpInput(controllers: _otpControllers),
                      const SizedBox(height: 12),
                      const AssignmentLocation(),
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
