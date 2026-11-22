import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/kpm_model.dart';
import '../../../data/repositories/bast_repository.dart';
import '../../widgets/common/app_confirmation_dialog.dart';
import '../../widgets/common/bottom_action_bar.dart';
import '../../widgets/common/center_alert.dart';
import '../../widgets/common/custom_app_bar.dart';
import 'widgets/bast_success_dialog.dart';
import 'widgets/beneficiary_card.dart';
import 'widgets/distribution_time_card.dart';
import 'widgets/geotag_map_box.dart';
import 'widgets/officer_notice.dart';
import 'widgets/signature_pad_dialog.dart';

class ReviewBastScreen extends StatefulWidget {
  final KpmModel? kpm;
  final String deliveryType;
  final String? replacedName;
  final String? ktpPhotoUrl;
  final String? recipientPhotoUrl;

  const ReviewBastScreen({
    super.key,
    this.kpm,
    this.deliveryType = 'PBP NORMAL',
    this.replacedName,
    this.ktpPhotoUrl,
    this.recipientPhotoUrl,
  });

  @override
  State<ReviewBastScreen> createState() => _ReviewBastScreenState();
}

class _ReviewBastScreenState extends State<ReviewBastScreen> {
  late KpmModel _currentKpm;
  List<Offset?>? _signaturePoints;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _currentKpm = widget.kpm ?? KpmModel.sampleData.first;
  }

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
            title: 'Tanda Tangan Tersimpan',
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
        // Pengguna membatalkan dialog
        return;
      }
      if (signFirst == true) {
        _openSignaturePad();
        return;
      }
      // Jika signFirst == false, pengguna memilih "Kirim Tanpa TTD"
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

    final now = DateTime.now();
    final bastNo = 'BAST-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.millisecondsSinceEpoch.toString().substring(7)}';

    // Simpan ke In-Memory Database (Opsi A)
    final newRecord = BastRecord(
      id: UniqueKey().toString(),
      bastNo: bastNo,
      nama: _currentKpm.nama,
      nik: _currentKpm.nik,
      noKk: _currentKpm.noKk,
      pbpNo: _currentKpm.nik.substring(0, 14.clamp(0, _currentKpm.nik.length)),
      waktu: 'Hari ini, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WITA',
      jenis: widget.deliveryType,
      imageUrl: widget.recipientPhotoUrl ?? 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200',
      lokasi: '${_currentKpm.dusun}, Banjar Bali',
      isSynced: true,
      replacedName: widget.replacedName ?? _currentKpm.namaPengganti,
    );
    BastRepository.instance.addRecord(newRecord);

    Navigator.pop(context); // Tutup dialog loading
    setState(() => _isSubmitting = false);

    // Tampilkan Dialog Sukses BAST
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BastSuccessDialog(
        bastNumber: bastNo,
        recipientName: newRecord.nama,
        nik: newRecord.nik,
        deliveryType: widget.deliveryType,
        address: '${_currentKpm.alamat}, ${_currentKpm.dusun}',
        imageUrl: newRecord.imageUrl,
        signaturePoints: _signaturePoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPengganti = widget.deliveryType.contains('PENGGANTI') || _currentKpm.isSptjm;
    final String riceImg = widget.recipientPhotoUrl ?? 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600';
    final String ktpImg = widget.ktpPhotoUrl ?? 'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=600';

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
                      nama: _currentKpm.nama,
                      nik: _currentKpm.nik,
                      noKk: _currentKpm.noKk,
                      alamat: '${_currentKpm.alamat}, ${_currentKpm.dusun}, Banjar Bali, Buleleng',
                      jenis: widget.deliveryType,
                      isPengganti: isPengganti,
                      replacedName: widget.replacedName ?? _currentKpm.namaPengganti,
                      ricePhotoUrl: riceImg,
                      sptjmPhotoUrl: ktpImg,
                      signaturePoints: _signaturePoints,
                      onTapSignature: _openSignaturePad,
                      onTapRicePhoto: () => _showImageLightbox(
                        'Foto Fisik Beras & Penerima',
                        riceImg,
                      ),
                      onTapSptjmPhoto: () => _showImageLightbox(
                        isPengganti ? 'Dokumen Surat SPTJM Terverifikasi' : 'Foto Fisik KTP/KK',
                        ktpImg,
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
          ],
        ),
      ),
      bottomNavigationBar: BanpangBottomActionBar(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8FAFC),
                    foregroundColor: const Color(0xFF475569),
                    side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
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
                    foregroundColor: const Color(0xFF0F172A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _isSubmitting ? null : _handleSubmitBast,
                  icon: const Icon(Icons.verified_rounded, size: 18, color: Color(0xFF0F172A)),
                  label: const Text(
                    'Sahkan & Terbitkan BAST',
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
