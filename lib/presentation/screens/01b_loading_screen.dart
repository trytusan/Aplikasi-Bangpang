import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '01c_otp_assignment_screen.dart';

class LoadingTransitionScreen extends StatefulWidget {
  const LoadingTransitionScreen({super.key});

  @override
  State<LoadingTransitionScreen> createState() => _LoadingTransitionScreenState();
}

class _LoadingTransitionScreenState extends State<LoadingTransitionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

    // Auto transisi ke Layar 01c setelah simulasi loading cepat
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OtpAssignmentScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Amber Glow
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryAmber.withValues(alpha: 0.15),
                  ),
                ),
                // Spinner Melingkar
                RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: const CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryAmber),
                    ),
                  ),
                ),
                // Emblem Beras di Tengah
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: const Center(
                    child: Text('🌾', style: TextStyle(fontSize: 22)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'MEMVALIDASI DATA LAPANGAN...',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textMain, letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}
