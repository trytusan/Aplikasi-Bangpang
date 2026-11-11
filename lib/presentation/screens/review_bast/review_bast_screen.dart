import 'package:flutter/material.dart';
import '../../widgets/common/app_confirmation_dialog.dart';
import '../../widgets/common/center_alert.dart';
import '../../widgets/common/custom_app_bar.dart';
import 'widgets/bast_success_dialog.dart';
import 'widgets/beneficiary_card.dart';
import 'widgets/distribution_time_card.dart';
import 'widgets/geotag_map_box.dart';
import 'widgets/officer_notice.dart';
import 'widgets/signature_pad_dialog.dart';

class ReviewBastScreen extends StatefulWidget {
  const ReviewBastScreen({super.key});

  @override
  State<ReviewBastScreen> createState() => _ReviewBastScreenState();
}

class _ReviewBastScreenState extends State<ReviewBastScreen> {
  List<Offset?>? _signaturePoints;
  bool _isSubmitting = false;

  void _openSignaturePad() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SignaturePadDialog(
        initialPoints: _signaturePoints,
        onSaved: (points) {
          setState(() {
            _signaturePoints = points;
          });
          CenterAlert.showSuccess(
            context,
            title: 'Data Berhasil Disimpan',
            message: 'Tanda tangan digital penerima telah tercatat sah dalam BAST.',
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

  Future<void> _handleSubmitBast() async {
    // Jika tanda tangan belum ada, ingatkan terlebih dahulu
    if (_signaturePoints == null || _signaturePoints!.isEmpty) {
      final signFirst = await AppConfirmationDialog.show(
        context,
        icon: Icons.draw_rounded,
        iconColor: const Color(0xFFD97706),
        iconBackgroundColor: const Color(0xFFFEF3C7),
        title: 'Tanda Tangan Belum Diisi',
        message: 'Apakah Anda ingin membubuhkan tanda tangan penerima terlebih dahulu agar BAST sah secara hukum?',
        confirmText: 'Tanda Tangan Sekarang',
        confirmColor: const Color(0xFFE88B00),
        confirmTextColor: const Color(0xFF0F172A),
        cancelText: 'Kirim Tanpa TTD',
        stackedButtons: true,
      );

      if (signFirst == null) {
        // Pengguna menutup / membatalkan dialog
        return;
      }
      if (signFirst == true) {
        // Pengguna memilih untuk tanda tangan terlebih dahulu
        _openSignaturePad();
        return;
      }
      // Jika signFirst == false, berarti pengguna memilih "Kirim Tanpa TTD", lanjutkan
    }

    // Tampilkan Loading Sinkronisasi BAST
    setState(() => _isSubmitting = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFFE88B00), strokeWidth: 3.5),
                SizedBox(height: 18),
                Text(
                  'Mengirim Berita Acara (BAST)...',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                ),
                SizedBox(height: 6),
                Text(
                  'Menyinkronkan data GPS, foto bukti, & TTD ke Server Pusat BULOG & BAPANAS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Color(0xFF64748B), height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    Navigator.pop(context); // Tutup dialog loading
    setState(() => _isSubmitting = false);

    // Tampilkan Dialog Sukses BAST
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const BastSuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Review Berita Acara',
        subtitle: 'Tahap Akhir: Pengesahan BAST',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DistributionTimeCard(),
                    const SizedBox(height: 14),
                    BeneficiaryCard(
                      signaturePoints: _signaturePoints,
                      onTapSignature: _openSignaturePad,
                      onTapRicePhoto: () => _showImageLightbox(
                        'Foto Fisik Beras & Penerima',
                        'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=800',
                      ),
                      onTapSptjmPhoto: () => _showImageLightbox(
                        'Dokumen Surat SPTJM Terverifikasi',
                        'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=800',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const GeotagMapBox(),
                    const SizedBox(height: 14),
                    const OfficerNotice(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons (Kembali & Kirim Penyerahan)
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
                        child: const Text('← Kembali', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE88B00),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _isSubmitting ? null : _handleSubmitBast,
                        icon: const Icon(Icons.cloud_upload_outlined, size: 16, color: Colors.black),
                        label: const Text(
                          'Kirim Penyerahan',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black),
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
