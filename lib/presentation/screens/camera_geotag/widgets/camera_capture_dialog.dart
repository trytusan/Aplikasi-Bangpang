import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraCaptureDialog extends StatefulWidget {
  final String title;
  final String guideText;
  final ValueChanged<String> onPhotoCaptured;
  final bool isKtp;

  const CameraCaptureDialog({
    super.key,
    required this.title,
    required this.guideText,
    required this.onPhotoCaptured,
    this.isKtp = false,
  });

  @override
  State<CameraCaptureDialog> createState() => _CameraCaptureDialogState();
}

class _CameraCaptureDialogState extends State<CameraCaptureDialog> {
  bool _isCapturing = false;
  bool _flashAnimation = false;
  int _sampleIndex = 0;

  late final List<String> _sampleImages;

  @override
  void initState() {
    super.initState();
    if (widget.isKtp) {
      _sampleImages = [
        'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600',
        'https://images.unsplash.com/photo-1618042164219-62c820f10723?q=80&w=600',
      ];
    } else {
      _sampleImages = [
        'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=600',
        'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=600',
      ];
    }
  }

  Future<void> _takePicture() async {
    HapticFeedback.heavyImpact();
    setState(() {
      _flashAnimation = true;
      _isCapturing = true;
    });

    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    setState(() {
      _flashAnimation = false;
    });

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    final selected = _sampleImages[_sampleIndex % _sampleImages.length];
    widget.onPhotoCaptured(selected);
    Navigator.pop(context);
  }

  Future<void> _pickFromRealCamera() async {
    try {
      HapticFeedback.lightImpact();
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (photo != null) {
        widget.onPhotoCaptured(photo.path);
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error camera: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      HapticFeedback.lightImpact();
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (photo != null) {
        widget.onPhotoCaptured(photo.path);
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeStr = 'WITA ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

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
                height: 290,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Preview Kamera
                    Image.network(
                      _sampleImages[_sampleIndex % _sampleImages.length],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF1E293B),
                        child: const Center(
                          child: Icon(Icons.camera_rounded, color: Colors.white38, size: 48),
                        ),
                      ),
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
                        width: widget.isKtp ? 240 : 200,
                        height: widget.isKtp ? 150 : 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE88B00), width: 2),
                          borderRadius: BorderRadius.circular(14),
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
                        color: Colors.black.withValues(alpha: 0.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '📍 GPS: -8.1124, 115.0876 (±2.4m RTK)',
                              style: TextStyle(color: Color(0xFF34D399), fontSize: 9, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              timeStr,
                              style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tombol Pintas Kamera Fisik (Melayang di Atas Kanan)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE88B00),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: _pickFromRealCamera,
                        icon: const Icon(Icons.camera_rounded, size: 14, color: Colors.black),
                        label: const Text(
                          'Kamera HP Asli',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),

                    // White Shutter Flash Effect
                    if (_flashAnimation)
                      Container(color: Colors.white),

                    // Loading overlay saat memproses
                    if (_isCapturing && !_flashAnimation)
                      Container(
                        color: Colors.black.withValues(alpha: 0.7),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Color(0xFFE88B00), strokeWidth: 3.5),
                              SizedBox(height: 12),
                              Text(
                                'Menyematkan Geotag & Watermark...',
                                style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w800),
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
                      style: const TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Tombol ganti kamera / sudut sampel
                        InkWell(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _sampleIndex++;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.flip_camera_android_rounded, color: Colors.white, size: 22),
                          ),
                        ),

                        // Shutter Button (Jepret Foto Simulasi)
                        GestureDetector(
                          onTap: _isCapturing ? null : _takePicture,
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              color: const Color(0xFFE88B00),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFE88B00).withValues(alpha: 0.4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.camera_alt_rounded, color: Colors.black, size: 28),
                            ),
                          ),
                        ),

                        // Tombol Galeri HP Asli
                        InkWell(
                          onTap: _pickFromGallery,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.photo_library_rounded, color: Colors.white, size: 22),
                          ),
                        ),
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
