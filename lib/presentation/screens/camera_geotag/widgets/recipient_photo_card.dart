import 'package:flutter/material.dart';

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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
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
                  Icon(Icons.location_on_outlined, size: 18, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Text(
                    'Foto Penerima Bersama Beras\nBantuan',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
                child: const Text('Wajib', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF2563EB))),
              ),
            ],
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: onTapPreview,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      color: Colors.black.withValues(alpha: 0.8),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('🛡️ Banpang Mobile v1.3.3', style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w800)),
                              Text('23/07/2025 09:43:05 WITA [GPS-LOCK]', style: TextStyle(color: Color(0xFF34D399), fontSize: 8, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Lat: -8.109613, Long: 115.0914146', style: TextStyle(color: Colors.white70, fontSize: 7.5, fontFamily: 'monospace')),
                              Text('Akurasi: ±3.2m • Banjar Ba...', style: TextStyle(color: Colors.white70, fontSize: 7.5)),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF059669), size: 14),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Foto Memenuhi Standar BAST (Wajah & Beras Jelas)',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF065F46)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF1F5F9),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onRetake,
              icon: const Icon(Icons.camera_alt_outlined, size: 14, color: Color(0xFF0F172A)),
              label: const Text('Ambil Ulang', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
            ),
          ),
        ],
      ),
    );
  }
}
