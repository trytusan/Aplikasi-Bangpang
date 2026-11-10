import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../camera_geotag/camera_geotag_screen.dart';
import 'widgets/original_pbp_card.dart';
import 'widgets/reason_picker.dart';
import 'widgets/recipient_form.dart';
import 'widgets/sptjm_card.dart';

class ReplacementScreen extends StatefulWidget {
  const ReplacementScreen({super.key});

  @override
  State<ReplacementScreen> createState() => _ReplacementScreenState();
}

class _ReplacementScreenState extends State<ReplacementScreen> {
  bool _useMusdesData = true;
  String _selectedReason = 'Meninggal';
  String _sptjmFile = 'SPTJM-510806-2024-008.PDF';

  final _namaPenggantiController = TextEditingController(text: 'LUH SUMANTRI ARYANI');
  final _nikPenggantiController = TextEditingController(text: '5108065209840002');
  final _noKkPenggantiController = TextEditingController(text: '5108061204090011');
  final String _alamatPengganti = 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali';

  @override
  void dispose() {
    _namaPenggantiController.dispose();
    _nikPenggantiController.dispose();
    _noKkPenggantiController.dispose();
    super.dispose();
  }

  void _handleUploadSptjm() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unggah Dokumen SPTJM Pengganti',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih sumber dokumen fisik Surat Pertanggungjawaban Mutlak (SPTJM) yang telah ditandatangani Kepala Desa/Kelurahan.',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEFF6FF),
                child: Icon(Icons.camera_alt, color: Color(0xFF1E3A8A)),
              ),
              title: const Text('Foto Fisik SPTJM', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Ambil foto langsung dokumen kertas berstempel', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _sptjmFile = 'FOTO_SPTJM_${DateTime.now().millisecondsSinceEpoch}.JPG');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto dokumen SPTJM berhasil dilampirkan!'), backgroundColor: Color(0xFF059669)),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFFBEB),
                child: Icon(Icons.picture_as_pdf, color: Color(0xFFD97706)),
              ),
              title: const Text('Pilih Berkas PDF', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Lampirkan berkas scan PDF resmi kelurahan', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _sptjmFile = 'SPTJM-510806-2024-008-SIGNED.PDF');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berkas PDF SPTJM berhasil dimuat!'), backgroundColor: Color(0xFF059669)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToDocumentation() {
    if (_namaPenggantiController.text.trim().isEmpty || _nikPenggantiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi Nama dan NIK KPM Pengganti terlebih dahulu.'),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraGeotagScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield_outlined, color: Color(0xFFD97706), size: 18),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Protokol Penyaluran Cadangan Pangan',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Data penggantian dicatat langsung dalam Berita Acara Rekonsiliasi Desa & Terintegrasi Server Pusat BULOG.',
                                  style: TextStyle(fontSize: 10, color: Color(0xFF475569), height: 1.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    const OriginalPbpCard(),
                    const SizedBox(height: 12),

                    ReasonPicker(
                      useMusdesData: _useMusdesData,
                      onToggleMusdes: (val) => setState(() => _useMusdesData = val),
                      selectedReason: _selectedReason,
                      onSelectReason: (val) => setState(() => _selectedReason = val),
                    ),
                    const SizedBox(height: 16),

                    RecipientForm(
                      nameController: _namaPenggantiController,
                      nikController: _nikPenggantiController,
                      noKkController: _noKkPenggantiController,
                      address: _alamatPengganti,
                    ),
                    const SizedBox(height: 14),

                    SptjmCard(
                      fileName: _sptjmFile,
                      onTapUpload: _handleUploadSptjm,
                    ),
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
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEEF2FF),
                          foregroundColor: const Color(0xFF1E3A8A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: const Text('Kembali', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
                        onPressed: _proceedToDocumentation,
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                        label: const Text(
                          'Dokumentasi',
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
