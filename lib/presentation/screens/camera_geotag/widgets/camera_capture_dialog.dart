import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraCaptureDialog extends StatefulWidget {
  final String title;
  final String guideText;
  final ValueChanged<String> onPhotoCaptured;

  const CameraCaptureDialog({
    super.key,
    required this.title,
    required this.guideText,
    required this.onPhotoCaptured,
  });

  @override
  State<CameraCaptureDialog> createState() => _CameraCaptureDialogState();
}

class _CameraCaptureDialogState extends State<CameraCaptureDialog> {
  bool _isCapturing = false;
  bool _flashAnimation = false;
  int _sampleIndex = 0;

  // Daftar sampel gambar realistis KTP atau Penerima
  final List<String> _sampleImages = [
    'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600',
    'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=600',
  ];

  Future<void> _takePicture() async {
    HapticFeedback.heavyImpact();
    setState(() {
      _flashAnimation = true;
      _isCapturing = true;
    });

    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    setState(() {
      _flashAnimation = false;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final selected = _sampleImages[_sampleIndex % _sampleImages.length];
    widget.onPhotoCaptured(selected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Dialog
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: const Color(0xFF0F172A),
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt, color: Color(0xFFF59E0B), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Viewfinder Kamera
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Simulasi viewfinder preview
                    Image.network(
                      _sampleImages[_sampleIndex % _sampleImages.length],
                      fit: BoxFit.cover,
                    ),

                    // Grid panduan
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 1),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Divider(color: Colors.white24, height: 1),
                          Divider(color: Colors.white24, height: 1),
                        ],
                      ),
                    ),

                    // Sudut target (Focus brackets)
                    Center(
                      child: Container(
                        width: 220,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE88B00), width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    // Geotag Watermark Overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        color: Colors.black.withValues(alpha: 0.75),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '📍 GPS: -8.109613, 115.0914146 (±3.2m)',
                              style: TextStyle(color: Color(0xFF34D399), fontSize: 8.5, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'WITA 09:44:10',
                              style: TextStyle(color: Colors.white70, fontSize: 8.5, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // White Shutter Flash Effect
                    if (_flashAnimation)
                      Container(color: Colors.white),

                    // Loading overlay saat memproses
                    if (_isCapturing && !_flashAnimation)
                      Container(
                        color: Colors.black.withValues(alpha: 0.6),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Color(0xFFE88B00), strokeWidth: 3),
                              SizedBox(height: 10),
                              Text(
                                'Memvalidasi Geotag & Standar BAST...',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Bottom Control Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                color: const Color(0xFF0F172A),
                child: Column(
                  children: [
                    Text(
                      widget.guideText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Tombol ganti kamera / sampel
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _sampleIndex++;
                            });
                          },
                          icon: const Icon(Icons.flip_camera_android, color: Colors.white, size: 24),
                          tooltip: 'Ganti Sudut / Kamera',
                        ),

                        // Shutter Button
                        GestureDetector(
                          onTap: _isCapturing ? null : _takePicture,
                          child: Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              color: const Color(0xFFE88B00),
                            ),
                            child: const Center(
                              child: Icon(Icons.camera_alt, color: Colors.black, size: 28),
                            ),
                          ),
                        ),

                        // Flash icon
                        const Icon(Icons.flash_auto, color: Colors.white70, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
