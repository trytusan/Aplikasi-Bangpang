import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '07_step5_review_bast_screen.dart';

class Step4CameraGeotagScreen extends StatefulWidget {
  const Step4CameraGeotagScreen({super.key});

  @override
  State<Step4CameraGeotagScreen> createState() => _Step4CameraGeotagScreenState();
}

class _Step4CameraGeotagScreenState extends State<Step4CameraGeotagScreen> {
  bool _photoTaken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Langkah 3 dari 4', style: TextStyle(fontSize: 10, color: AppColors.primaryAmber, fontWeight: FontWeight.w700)),
            Text('Dokumentasi Geotag Bapanas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Frame Foto dengan Watermark
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_photoTaken)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(19),
                          child: Container(
                            color: const Color(0xFF334155),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle_outline, color: AppColors.successGreen, size: 64),
                                  SizedBox(height: 8),
                                  Text('Foto Penerima & Sak Beras Terverifikasi', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 56),
                            SizedBox(height: 10),
                            Text(
                              'Posisikan KPM memegang KTP asli\ndan Karung Beras Bantuan 10 Kg',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                      // Live Watermark Geotagging Overlay (BPK & Bapanas Audit Grade)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('BAPANAS - CADANGAN BERAS PEMERINTAH', style: TextStyle(color: AppColors.primaryAmber, fontSize: 9, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
                                  Text('AKURASI: ±2.8m', style: TextStyle(color: AppColors.successGreen, fontSize: 8, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text('KOR: -8.113256, 115.088219 (Lat, Long)', style: TextStyle(color: Colors.white, fontSize: 8, fontFamily: 'monospace')),
                              Text('LOKASI: KANTOR DESA BANJAR BALI, BULELENG, BALI', style: TextStyle(color: Colors.white, fontSize: 8, fontFamily: 'monospace')),
                              Text('WAKTU: 09-NOV-2026 10:24:18 WITA', style: TextStyle(color: Colors.white70, fontSize: 8, fontFamily: 'monospace')),
                              Text('PBP: I KETUT WIDNYANA (5108051205780004)', style: TextStyle(color: Colors.white70, fontSize: 8, fontFamily: 'monospace')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Shutter Button Controls
              if (!_photoTaken)
                GestureDetector(
                  onTap: () => setState(() => _photoTaken = true),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryAmber,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(color: AppColors.primaryAmber.withValues(alpha: 0.4), blurRadius: 16),
                      ],
                    ),
                    child: const Icon(Icons.camera_alt, color: AppColors.navyDark, size: 30),
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white38),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => setState(() => _photoTaken = false),
                        child: const Text('AMBIL ULANG'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step5ReviewBastScreen()));
                        },
                        child: const Text('GUNAKAN FOTO & BAST →'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
