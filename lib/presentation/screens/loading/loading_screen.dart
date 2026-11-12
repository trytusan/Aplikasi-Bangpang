import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../dashboard/dashboard_screen.dart';

class LoadingScreen extends StatefulWidget {
  final Widget? targetScreen;
  final String title;
  final String subtitle;
  final Duration duration;
  final bool clearStack;
  final String logoPath;

  const LoadingScreen({
    super.key,
    this.targetScreen,
    this.title = 'MEMVALIDASI DATA LAPANGAN...',
    this.subtitle = 'Menghubungkan ke Server BULOG Titik Bagi Desa Banjar Bali',
    this.duration = const Duration(milliseconds: 1300),
    this.clearStack = false,
    this.logoPath = 'assets/images/logo.png',
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

    // Auto transisi setelah durasi loading
    Future.delayed(widget.duration, () {
      if (mounted) {
        final destination = widget.targetScreen ?? const DashboardScreen();
        if (widget.clearStack) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => destination),
            (route) => false,
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        }
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
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryAmber.withValues(alpha: 0.15),
                  ),
                ),
                // Spinner Melingkar
                RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryAmber),
                    ),
                  ),
                ),
                // Logo 1 Lingkaran Penuh, Besar & Jelas
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.logoPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Text('🌾', style: TextStyle(fontSize: 38)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textMain, letterSpacing: 1),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
