import 'package:flutter/material.dart';
import '../../widgets/common/center_alert.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../review_bast/review_bast_screen.dart';
import 'widgets/camera_capture_dialog.dart';
import 'widgets/gps_subbar.dart';
import 'widgets/kpm_summary.dart';
import 'widgets/ktp_photo_card.dart';
import 'widgets/recipient_photo_card.dart';

class CameraGeotagScreen extends StatefulWidget {
  const CameraGeotagScreen({super.key});

  @override
  State<CameraGeotagScreen> createState() => _CameraGeotagScreenState();
}

class _CameraGeotagScreenState extends State<CameraGeotagScreen> {
  String _ktpPhotoUrl = 'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600';
  String _recipientPhotoUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600';

  void _openCamera(String title, String guide, ValueChanged<String> onCaptured) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CameraCaptureDialog(
        title: title,
        guideText: guide,
        onPhotoCaptured: (newUrl) {
          onCaptured(newUrl);
          CenterAlert.showSuccess(
            context,
            title: 'Foto Berhasil Disimpan',
            message: 'Watermark Geotag GPS (±3.2m) & verifikasi OCR valid.',
          );
        },
      ),
    );
  }

  void _showImageLightbox(String title, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Dokumentasi & Geotag',
        subtitle: 'Tahap 3: Foto Fisik Beras & KTP',
      ),
      body: SafeArea(
        child: Column(
          children: [
            const GpsSubbar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF2563EB), size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pastikan foto KTP/KK dan penerima terlihat jelas, tidak buram, dan GPS aktif dengan akurasi tinggi (< 10 meter) untuk validasi BAST.',
                              style: TextStyle(fontSize: 10, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w500, height: 1.35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Foto KTP Card
                    KtpPhotoCard(
                      imageUrl: _ktpPhotoUrl,
                      onRetake: () {
                        _openCamera(
                          'Ambil Foto Fisik KTP/KK',
                          'Posisikan KTP / KK berada di dalam kotak bingkai oranye dan teks NIK terbaca jelas.',
                          (newUrl) => setState(() => _ktpPhotoUrl = newUrl),
                        );
                      },
                      onTapPreview: () => _showImageLightbox('Foto Fisik KTP / KK', _ktpPhotoUrl),
                    ),
                    const SizedBox(height: 14),

                    // Foto Penerima Card
                    RecipientPhotoCard(
                      imageUrl: _recipientPhotoUrl,
                      onRetake: () {
                        _openCamera(
                          'Ambil Foto Penerima Bersama Beras',
                          'Pastikan wajah penerima dan karung 10kg Beras Bantuan terlihat jelas bersamaan.',
                          (newUrl) => setState(() => _recipientPhotoUrl = newUrl),
                        );
                      },
                      onTapPreview: () => _showImageLightbox('Foto Penerima Bersama Beras', _recipientPhotoUrl),
                    ),
                    const SizedBox(height: 14),

                    const KpmSummary(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEEF2FF),
                          foregroundColor: const Color(0xFF1E3A8A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Kembali', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE88B00),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ReviewBastScreen()),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lanjut ke Review BAST',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                          ],
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
    );
  }
}
