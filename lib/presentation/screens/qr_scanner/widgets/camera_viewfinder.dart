import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraViewfinder extends StatefulWidget {
  final VoidCallback? onScanTriggered;
  final ValueChanged<String>? onCodeScanned;
  final MobileScannerController? controller;

  const CameraViewfinder({
    super.key,
    this.onScanTriggered,
    this.onCodeScanned,
    this.controller,
  });

  @override
  State<CameraViewfinder> createState() => CameraViewfinderState();
}

class CameraViewfinderState extends State<CameraViewfinder> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _laserPosition;
  MobileScannerController? _internalController;
  bool _isScanningNow = false;

  MobileScannerController get controller => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      );
    }

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _laserPosition = Tween<double>(begin: 10.0, end: 170.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void toggleTorch() {
    controller.toggleTorch();
  }

  void switchCamera() {
    controller.switchCamera();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanningNow) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final first = barcodes.first;
    final value = first.rawValue ?? first.displayValue;
    if (value == null || value.trim().isEmpty) return;

    setState(() => _isScanningNow = true);
    HapticFeedback.heavyImpact();

    widget.onCodeScanned?.call(value);
    widget.onScanTriggered?.call();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isScanningNow = false);
    });
  }

  Future<void> _triggerManualTap() async {
    if (_isScanningNow) return;
    setState(() => _isScanningNow = true);
    HapticFeedback.heavyImpact();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _isScanningNow = false);

    widget.onScanTriggered?.call();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _triggerManualTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              // 1. Live Feed Kamera Hardware Asli (Real Camera Stream)
              MobileScanner(
                controller: controller,
                fit: BoxFit.cover,
                onDetect: _onDetect,
                errorBuilder: (context, error) {
                  return _buildCameraFallback(error.errorCode.name);
                },
              ),

              // 2. Lapisan Vignette & Dimming
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.85,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: _isScanningNow ? 0.3 : 0.6),
                    ],
                  ),
                ),
              ),

              // 3. Status Bar Atas (Indikator & Tombol Balik Kamera)
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isScanningNow ? const Color(0xFF10B981) : Colors.white24,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _isScanningNow ? const Color(0xFF10B981) : const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF22C55E).withValues(alpha: 0.7),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            _isScanningNow ? 'QR Terdeteksi!' : 'Kamera Fisik Aktif',
                            style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),

                    // Tombol Switch Kamera Depan/Belakang
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        switchCamera();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cameraswitch_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 5),
                            Text('Putar Lensa', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 4. Bingkai Sudut Bidik (Targeting Reticle)
              Center(
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Stack(
                    children: [
                      Positioned(top: 0, left: 0, child: _corner(true, true)),
                      Positioned(top: 0, right: 0, child: _corner(true, false)),
                      Positioned(bottom: 0, left: 0, child: _corner(false, true)),
                      Positioned(bottom: 0, right: 0, child: _corner(false, false)),

                      // Garis Laser Animasi
                      AnimatedBuilder(
                        animation: _laserPosition,
                        builder: (context, child) {
                          return Positioned(
                            top: _laserPosition.value,
                            left: 8,
                            right: 8,
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: _isScanningNow ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: (_isScanningNow ? const Color(0xFF10B981) : const Color(0xFFF59E0B)).withValues(alpha: 0.9),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // 5. Petunjuk Bawah
              Positioned(
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isScanningNow ? const Color(0xFF10B981) : const Color(0xFFE88B00),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isScanningNow ? Icons.check_circle_rounded : Icons.qr_code_scanner_rounded,
                        size: 14,
                        color: _isScanningNow ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        _isScanningNow ? 'Berhasil Membaca QR!' : 'Arahkan kamera ke QR KPM Fisik',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraFallback(String errorName) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withValues(alpha: 0.65),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_camera_front_rounded, size: 38, color: Color(0xFFF59E0B)),
            const SizedBox(height: 8),
            const Text(
              'Mode Simulasi / Akses Kamera',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              'Izin kamera belum aktif ($errorName).\nKetuk untuk simulasi scan langsung atau gunakan tombol di bawah.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 10, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _corner(bool isTop, bool isLeft) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFFF59E0B), width: 3.5) : BorderSide.none,
        ),
      ),
    );
  }
}
