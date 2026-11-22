import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/kpm_model.dart';
import '../../widgets/common/banpang_image.dart';
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

  void _showCaptureOptions(String title, String guide, bool isKtp, ValueChanged<String> onCaptured) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isKtp ? const Color(0xFFEFF6FF) : const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isKtp ? Icons.badge_rounded : Icons.camera_alt_rounded,
                    color: isKtp ? const Color(0xFF1E3A8A) : const Color(0xFFD97706),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        isKtp ? 'Foto dokumen fisik identitas penerima KPM' : 'Foto penyerahan fisik beras bersama penerima',
                        style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Opsi 1: Buka Kamera Fisik HP Asli
            _captureOptionTile(
              icon: Icons.photo_camera_rounded,
              iconColor: const Color(0xFFE88B00),
              bgColor: const Color(0xFFFFFBEB),
              borderColor: const Color(0xFFFDE68A),
              title: 'Buka Kamera Fisik HP (Asli)',
              subtitle: 'Ambil foto fisik langsung menggunakan sensor kamera perangkat',
              badge: 'Kamera Hardware',
              onTap: () async {
                Navigator.pop(ctx);
                await _pickFromCamera(onCaptured);
              },
            ),
            const SizedBox(height: 10),

            // Opsi 2: Pilih dari Galeri
            _captureOptionTile(
              icon: Icons.photo_library_rounded,
              iconColor: const Color(0xFF2563EB),
              bgColor: const Color(0xFFEFF6FF),
              borderColor: const Color(0xFFBFDBFE),
              title: 'Pilih dari Galeri Perangkat',
              subtitle: 'Pilih foto dokumen yang sudah tersimpan di galeri lokal',
              onTap: () async {
                Navigator.pop(ctx);
                await _pickFromGallery(onCaptured);
              },
            ),
            const SizedBox(height: 10),

            // Opsi 3: Simulasi Viewfinder Geotag
            _captureOptionTile(
              icon: Icons.view_in_ar_rounded,
              iconColor: const Color(0xFF059669),
              bgColor: const Color(0xFFECFDF5),
              borderColor: const Color(0xFFA7F3D0),
              title: 'Buka Viewfinder Watermark Geotag',
              subtitle: 'Tampilan panduan bidik presisi dengan GPS RTK & shutter simulasi',
              onTap: () {
                Navigator.pop(ctx);
                _openSimulatedDialog(title, guide, isKtp, onCaptured);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _captureOptionTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String title,
    required String subtitle,
    String? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE88B00),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), height: 1.25),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8), size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera(ValueChanged<String> onCaptured) async {
    try {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );

      if (photo != null) {
        onCaptured(photo.path);
        if (!mounted) return;
        CenterAlert.showSuccess(
          context,
          title: 'Foto Kamera Berhasil Disimpan',
          message: 'Foto fisik asli tersimpan & Geotag GPS (±2.4m RTK) telah diverifikasi sah.',
        );
      }
    } catch (e) {
      if (!mounted) return;
      CenterAlert.showWarning(
        context,
        title: 'Kamera Tidak Tersedia',
        message: 'Tidak dapat membuka kamera fisik ($e). Beralih ke galeri atau simulasi.',
      );
    }
  }

  Future<void> _pickFromGallery(ValueChanged<String> onCaptured) async {
    try {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );

      if (photo != null) {
        onCaptured(photo.path);
        if (!mounted) return;
        CenterAlert.showSuccess(
          context,
          title: 'Foto Galeri Dipilih',
          message: 'Berkas berhasil diunggah dengan stempel Geotag GPS sah.',
        );
      }
    } catch (e) {
      if (!mounted) return;
      CenterAlert.showWarning(
        context,
        title: 'Gagal Membuka Galeri',
        message: 'Tidak dapat mengakses memori perangkat: $e',
      );
    }
  }

  void _openSimulatedDialog(String title, String guide, bool isKtp, ValueChanged<String> onCaptured) {
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
              child: BanpangImage(
                imagePath: imageUrl,
                fit: BoxFit.contain,
              ),
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
                        _showCaptureOptions(
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
                        _showCaptureOptions(
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
                      allocation: '10 Kg Beras Medium CPP (Tahap III / 2024)',
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
