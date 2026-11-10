import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipientPhotoCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onRetake;
  final VoidCallback? onTapPreview;

  const RecipientPhotoCard({
    super.key,
    this.imageUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600',
    this.onRetake,
    this.onTapPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 19, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Text(
                    'Foto Penerima Bersama Beras\nBantuan',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
                child: const Text('Wajib', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF2563EB))),
              ),
            ],
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              onTapPreview?.call();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 165,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      color: Colors.black.withValues(alpha: 0.82),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('🛡️ Banpang Mobile v1.3.3', style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800)),
                              Text('23/07/2025 09:43:05 WITA [GPS-LOCK]', style: TextStyle(color: Color(0xFF34D399), fontSize: 9.5, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Lat: -8.109613, Long: 115.0914146', style: TextStyle(color: Colors.white, fontSize: 9.0, fontFamily: 'monospace')),
                              Text('Akurasi: ±3.2m • Banjar Bali', style: TextStyle(color: Colors.white70, fontSize: 9.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF059669), size: 15),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Foto Memenuhi Standar BAST (Wajah & Beras Jelas)',
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF1F5F9),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                onRetake?.call();
              },
              icon: const Icon(Icons.camera_alt_outlined, size: 15, color: Color(0xFF0F172A)),
              label: const Text('Ambil Ulang Foto Penerima', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
            ),
          ),
        ],
      ),
    );
  }
}
