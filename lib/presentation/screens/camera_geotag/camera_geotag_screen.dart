import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/kpm_model.dart';
import '../../widgets/common/bottom_action_bar.dart';
import '../../widgets/common/center_alert.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../review_bast/review_bast_screen.dart';
import 'widgets/camera_capture_dialog.dart';
import 'widgets/gps_subbar.dart';
import 'widgets/kpm_summary.dart';
import 'widgets/ktp_photo_card.dart';
import 'widgets/recipient_photo_card.dart';

class CameraGeotagScreen extends StatefulWidget {
  final KpmModel? kpm;
  final String deliveryType;
  final String? replacedName;

  const CameraGeotagScreen({
    super.key,
    this.kpm,
    this.deliveryType = 'PBP NORMAL',
    this.replacedName,
  });

  @override
  State<CameraGeotagScreen> createState() => _CameraGeotagScreenState();
}

class _CameraGeotagScreenState extends State<CameraGeotagScreen> {
  late KpmModel _currentKpm;
  String _ktpPhotoUrl = 'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600';
  String _recipientPhotoUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600';

  @override
  void initState() {
    super.initState();
    _currentKpm = widget.kpm ?? KpmModel.sampleData.first;
  }

  void _openCamera(String title, String guide, bool isKtp, ValueChanged<String> onCaptured) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CameraCaptureDialog(
        title: title,
        guideText: guide,
        isKtp: isKtp,
        onPhotoCaptured: (newUrl) {
          onCaptured(newUrl);
          CenterAlert.showSuccess(
            context,
            title: 'Foto Berhasil Disimpan',
            message: 'Watermark Geotag GPS (±2.4m RTK) & OCR telah diverifikasi sah.',
          );
        },
      ),
    );
  }

  void _showImageLightbox(String title, String imageUrl) {
    HapticFeedback.lightImpact();
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
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w800),
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
            // Status Akurasi GPS RTK Bar
            const GpsSubbar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Petunjuk Validasi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield_outlined, color: Color(0xFF2563EB), size: 18),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Standar Verifikasi Dokumen BAST',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Pastikan fisik KTP/KK dan wajah penerima tampak jelas, tidak silau/buram, serta GPS terkunci akurat (< 10 meter) untuk keabsahan hukum penyerahan.',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: Color(0xFF3B82F6),
                                    fontWeight: FontWeight.w500,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Foto KTP Card
                    KtpPhotoCard(
                      imageUrl: _ktpPhotoUrl,
                      onRetake: () {
                        _openCamera(
                          'Ambil Foto Fisik KTP/KK',
                          'Posisikan KTP / KK berada di dalam kotak bingkai oranye dan teks NIK terbaca jelas.',
                          true,
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
                          false,
                          (newUrl) => setState(() => _recipientPhotoUrl = newUrl),
                        );
                      },
                      onTapPreview: () => _showImageLightbox('Foto Penerima Bersama Beras', _recipientPhotoUrl),
                    ),
                    const SizedBox(height: 14),

                    // Ringkasan Data KPM
                    KpmSummary(
                      name: _currentKpm.nama,
                      nik: _currentKpm.nik,
                      allocation: '${_currentKpm.alokasiKg} Kg Beras Medium CPP (Tahap III / 2024)',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BanpangBottomActionBar.dual(
        onBack: () => Navigator.pop(context),
        onNext: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReviewBastScreen(
                kpm: _currentKpm,
                deliveryType: widget.deliveryType,
                replacedName: widget.replacedName,
                ktpPhotoUrl: _ktpPhotoUrl,
                recipientPhotoUrl: _recipientPhotoUrl,
              ),
            ),
          );
        },
        nextText: 'Lanjut ke Review BAST',
        nextIcon: Icons.arrow_forward_rounded,
      ),
    );
  }
}
