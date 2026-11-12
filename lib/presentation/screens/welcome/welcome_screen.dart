import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  /// Path logo yang dimuat. Default membaca 'assets/images/logo.png'.
  final String logoPath;

  const WelcomeScreen({
    super.key,
    this.logoPath = 'assets/images/logo.png',
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animasi Fase 1: Logo Splash Awal Masuk (0.0 - 0.25)
  late Animation<double> _initialLogoFade;
  late Animation<double> _initialLogoScale;

  // Animasi Fase 2: Efek "Zoom in / Reveal" pada Logo & Blobs (0.28 - 0.55)
  late Animation<double> _zoomPunchScale;
  late Animation<double> _blobsScale;
  late Animation<double> _blobsFade;

  // Animasi Fase 2b: Elemen Teks & Progress Bar Meluncur Masuk (0.40 - 0.60)
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  // Animasi Fase 3: Pengisian Progress Bar (0.55 - 0.92)
  late Animation<double> _progressAnimation;

  String _statusText = 'Menyiapkan modul...';
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    // 1. Logo awal fade & scale-in lembut
    _initialLogoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.20, curve: Curves.easeIn),
    );
    _initialLogoScale = Tween<double>(begin: 0.70, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.28, curve: Curves.easeOutBack),
      ),
    );

    // 2. Efek Zoom Punch pada Logo saat transisi ke Welcome Screen
    _zoomPunchScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.22).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.22, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 55,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.28, 0.52),
      ),
    );

    // 3. Blobs pastel mekar keluar (scale & fade)
    _blobsScale = Tween<double>(begin: 0.35, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.28, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _blobsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.28, 0.50, curve: Curves.easeIn),
    );

    // 4. Fade & Slide teks + progress bar
    _contentFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.42, 0.62, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.42, 0.62, curve: Curves.easeOutCubic),
      ),
    );

    // 5. Progress bar loading (0% -> 100%)
    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.92, curve: Curves.easeInOutCubic),
    );

    _controller.addListener(() {
      final p = _progressAnimation.value;
      if (p < 0.35) {
        if (_statusText != 'Menyiapkan modul...') {
          setState(() => _statusText = 'Menyiapkan modul...');
        }
      } else if (p < 0.75) {
        if (_statusText != 'Menghubungkan data...') {
          setState(() => _statusText = 'Menghubungkan data...');
        }
      } else {
        if (_statusText != 'Memuat sistem...') {
          setState(() => _statusText = 'Memuat sistem...');
        }
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToLogin();
      }
    });

    _controller.forward();
  }

  void _navigateToLogin() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: GestureDetector(
        onTap: _navigateToLogin, // Sentuh layar untuk langsung lompat ke Login
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Hitung scale gabungan untuk logo
            final isZoomPhase = _controller.value >= 0.28;
            final currentLogoScale = isZoomPhase
                ? _zoomPunchScale.value
                : _initialLogoScale.value;
            final currentLogoOpacity = _initialLogoFade.value;

            return Stack(
              children: [
                // ==========================================
                // 1. PASTEL BLOBS BACKGROUND (Mekar saat Zoom)
                // ==========================================
                Opacity(
                  opacity: _blobsFade.value,
                  child: Transform.scale(
                    scale: _blobsScale.value,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        // Blob Mint Pastel Kiri Atas
                        Positioned(
                          top: -40,
                          left: -40,
                          child: Container(
                            width: 220,
                            height: 220,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD3F2E3),
                            ),
                          ),
                        ),

                        // Blob Kuning / Peach Pastel Kanan Tengah
                        Positioned(
                          top: size.height * 0.35,
                          right: -60,
                          child: Container(
                            width: 230,
                            height: 230,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFDE8C7),
                            ),
                          ),
                        ),

                        // Blob Hijau Mint Pastel Bawah
                        Positioned(
                          bottom: 80,
                          left: 40,
                          child: Container(
                            width: 220,
                            height: 220,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFDDF5EA),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ==========================================
                // 2. KONTEN UTAMA (Logo + Teks + Progress Bar)
                // ==========================================
                SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 3),

                      // LOGO UTAMA DENGAN EFEK ZOOM
                      Center(
                        child: Opacity(
                          opacity: currentLogoOpacity,
                          child: Transform.scale(
                            scale: currentLogoScale,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08 * _contentFade.value.clamp(0.4, 1.0)),
                                    blurRadius: 30,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  widget.logoPath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 52,
                                          height: 52,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE8F7EE),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFF2EB872).withValues(alpha: 0.3),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text('🌾', style: TextStyle(fontSize: 26)),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'TARUH LOGO',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF23654E),
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // ==========================================
                      // 3. ELEMEN MUNCUL DENGAN FADE & SLIDE UP
                      // ==========================================
                      Opacity(
                        opacity: _contentFade.value,
                        child: SlideTransition(
                          position: _contentSlide,
                          child: Column(
                            children: [
                              // NAMA APLIKASI
                              const Text(
                                'BANPANG MOBILE',
                                style: TextStyle(
                                  color: Color(0xFF23654E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // SUBJUDUL / TAGLINE
                              const Text(
                                'Aplikasi Distribusi Bantuan Pangan Beras',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 48),

                              // PROGRESS BAR & STATUS LOADING
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 46.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _statusText,
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            color: Color(0xFF6B7280),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${(_progressAnimation.value * 100).toInt()}%',
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF23654E),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 5.5,
                                        width: double.infinity,
                                        color: const Color(0xFFE5E7EB),
                                        alignment: Alignment.centerLeft,
                                        child: FractionallySizedBox(
                                          widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2EB872),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(flex: 4),

                      // FOOTER (Fade in bersama konten)
                      Opacity(
                        opacity: _contentFade.value,
                        child: const Column(
                          children: [
                            Text(
                              'Badan Pangan Nasional • Perum BULOG',
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sistem Penyaluran CBP v1.3.3',
                              style: TextStyle(
                                color: Color(0xFFD1D5DB),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
