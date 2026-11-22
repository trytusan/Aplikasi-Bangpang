import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignaturePadDialog extends StatefulWidget {
  final List<Offset?>? initialPoints;
  final ValueChanged<List<Offset?>> onSaved;

  const SignaturePadDialog({
    super.key,
    this.initialPoints,
    required this.onSaved,
  });

  @override
  State<SignaturePadDialog> createState() => _SignaturePadDialogState();
}

class _SignaturePadDialogState extends State<SignaturePadDialog> {
  final List<Offset?> _points = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialPoints != null) {
      _points.addAll(widget.initialPoints!);
    }
  }

  void _clearSignature() {
    HapticFeedback.lightImpact();
    setState(() {
      _points.clear();
    });
  }

  void _generateSampleSignature() {
    HapticFeedback.selectionClick();
    setState(() {
      _points.clear();
      // Pola garis tanda tangan artistik realistis
      const startX = 40.0;
      const startY = 90.0;
      _points.add(const Offset(startX, startY));
      _points.add(const Offset(startX + 20, startY - 40));
      _points.add(const Offset(startX + 35, startY + 30));
      _points.add(const Offset(startX + 50, startY - 30));
      _points.add(const Offset(startX + 65, startY + 15));
      _points.add(const Offset(startX + 90, startY - 10));
      _points.add(const Offset(startX + 120, startY));
      _points.add(null);

      // Garis bawah tanda tangan
      _points.add(const Offset(startX - 10, startY + 35));
      _points.add(const Offset(startX + 160, startY + 35));
      _points.add(null);

      // Titik aksen
      _points.add(const Offset(startX + 170, startY + 25));
      _points.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.draw_outlined, color: Color(0xFF1E3A8A), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Tanda Tangan Penerima',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Bubuhkan tanda tangan basah digital KPM / Penerima Kuasa di bawah ini sebagai bukti serah terima resmi beras CPP.',
              style: TextStyle(fontSize: 10, color: Color(0xFF64748B), height: 1.3),
            ),
            const SizedBox(height: 12),

            // Kanvas Tanda Tangan
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GestureDetector(
                            onPanStart: (DragStartDetails details) {
                              setState(() {
                                final p = details.localPosition;
                                final clamped = Offset(
                                  p.dx.clamp(0.0, constraints.maxWidth),
                                  p.dy.clamp(0.0, constraints.maxHeight),
                                );
                                _points.add(clamped);
                              });
                            },
                            onPanUpdate: (DragUpdateDetails details) {
                              setState(() {
                                final p = details.localPosition;
                                final clamped = Offset(
                                  p.dx.clamp(0.0, constraints.maxWidth),
                                  p.dy.clamp(0.0, constraints.maxHeight),
                                );
                                _points.add(clamped);
                              });
                            },
                            onPanEnd: (DragEndDetails details) {
                              setState(() {
                                _points.add(null);
                              });
                            },
                            child: CustomPaint(
                              painter: SignaturePainter(points: _points),
                              size: Size.infinite,
                            ),
                          );
                        },
                      ),
                    ),
                    if (_points.isEmpty)
                      const Center(
                        child: Text(
                          'Coretkan tanda tangan dengan jari / stylus di sini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                    // Tombol Contoh TTD Cepat (Kiri Bawah)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFEFF6FF),
                          foregroundColor: const Color(0xFF1E3A8A),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _generateSampleSignature,
                        icon: const Icon(Icons.auto_fix_high_rounded, size: 13),
                        label: const Text('Contoh TTD', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700)),
                      ),
                    ),

                    // Tombol Hapus (Kanan Bawah)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFFEE2E2),
                          foregroundColor: const Color(0xFFDC2626),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _points.isEmpty ? null : _clearSignature,
                        icon: const Icon(Icons.delete_outline, size: 14),
                        label: const Text('Hapus', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Tombol Aksi
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE88B00),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _points.isEmpty
                          ? null
                          : () {
                              HapticFeedback.mediumImpact();
                              widget.onSaved(_points);
                              Navigator.pop(context);
                            },
                      icon: const Icon(Icons.check, size: 16, color: Colors.black),
                      label: const Text('Simpan Tanda Tangan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;
  final bool fit;

  SignaturePainter({
    required this.points,
    this.color = const Color(0xFF0F172A),
    this.strokeWidth = 2.8,
    this.fit = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    if (!fit) {
      // Gambar langsung 1:1 di kanvas input
      for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i + 1] != null) {
          canvas.drawLine(points[i]!, points[i + 1]!, paint);
        } else if (points[i] != null && points[i + 1] == null) {
          canvas.drawCircle(points[i]!, strokeWidth / 2, paint);
        }
      }
      return;
    }

    // Auto-fit & Auto-center ke dalam kotak pratinjau (agar tidak lewat dari kotak)
    final validPoints = points.whereType<Offset>().toList();
    if (validPoints.isEmpty) return;

    double minX = validPoints.first.dx;
    double maxX = validPoints.first.dx;
    double minY = validPoints.first.dy;
    double maxY = validPoints.first.dy;

    for (final p in validPoints) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    final origWidth = maxX - minX;
    final origHeight = maxY - minY;

    const padding = 6.0;
    final availWidth = size.width - (padding * 2);
    final availHeight = size.height - (padding * 2);

    if (availWidth <= 0 || availHeight <= 0) return;

    double scale = 1.0;
    if (origWidth > 0 && origHeight > 0) {
      final scaleX = availWidth / origWidth;
      final scaleY = availHeight / origHeight;
      scale = scaleX < scaleY ? scaleX : scaleY;
    }

    final scaledWidth = origWidth * scale;
    final scaledHeight = origHeight * scale;
    final offsetX = padding + (availWidth - scaledWidth) / 2 - (minX * scale);
    final offsetY = padding + (availHeight - scaledHeight) / 2 - (minY * scale);

    paint.strokeWidth = (strokeWidth * scale).clamp(1.4, 2.5);

    // Kunci agar goresan gambar TIDAK LEWAT dari kotak gambar
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (p1 != null && p2 != null) {
        final sp1 = Offset(p1.dx * scale + offsetX, p1.dy * scale + offsetY);
        final sp2 = Offset(p2.dx * scale + offsetX, p2.dy * scale + offsetY);
        canvas.drawLine(sp1, sp2, paint);
      } else if (p1 != null && p2 == null) {
        final sp1 = Offset(p1.dx * scale + offsetX, p1.dy * scale + offsetY);
        canvas.drawCircle(sp1, paint.strokeWidth / 2, paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SignaturePainter oldDelegate) => true;
}
