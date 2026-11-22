import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Helper ImageProvider yang kompatibel untuk Network URL, Local File (Kamera HP), dan Web Blob.
ImageProvider banpangImageProvider(String imagePath) {
  final trimmed = imagePath.trim();
  if (trimmed.startsWith('http://') ||
      trimmed.startsWith('https://') ||
      (kIsWeb && trimmed.startsWith('blob:'))) {
    return NetworkImage(trimmed);
  } else if (kIsWeb) {
    return NetworkImage(trimmed);
  } else {
    final file = File(trimmed);
    if (file.existsSync()) {
      return FileImage(file);
    }
    return NetworkImage(trimmed);
  }
}

/// Komponen rendering gambar seragam yang mendukung URL online (Unsplash/CDN),
/// file kamera lokal (Android/iOS File), maupun Web Blob URL.
class BanpangImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  const BanpangImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    final trimmed = imagePath.trim();

    if (trimmed.startsWith('http://') ||
        trimmed.startsWith('https://') ||
        (kIsWeb && trimmed.startsWith('blob:'))) {
      imageWidget = Image.network(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    } else if (kIsWeb) {
      imageWidget = Image.network(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    } else {
      final file = File(trimmed);
      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _errorWidget(),
        );
      } else {
        imageWidget = Image.network(
          trimmed,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _errorWidget(),
        );
      }
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }
    return imageWidget;
  }

  Widget _errorWidget() {
    return placeholder ??
        Container(
          width: width,
          height: height,
          color: const Color(0xFFE2E8F0),
          child: const Center(
            child: Icon(Icons.broken_image_rounded, color: Color(0xFF94A3B8), size: 28),
          ),
        );
  }
}
