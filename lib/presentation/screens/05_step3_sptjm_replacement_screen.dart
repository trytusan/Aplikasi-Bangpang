import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '06_step4_camera_geotag_screen.dart';

class Step3SptjmReplacementScreen extends StatefulWidget {
  const Step3SptjmReplacementScreen({super.key});

  @override
  State<Step3SptjmReplacementScreen> createState() => _Step3SptjmReplacementScreenState();
}

class _Step3SptjmReplacementScreenState extends State<Step3SptjmReplacementScreen> {
  bool _useMusdesData = true;
  String _selectedReason = 'Meninggal'; // 'Tidak Ditemukan' | 'Sudah Mampu' | 'ASN' | 'TNI' | 'Polri' | 'Meninggal'

  final _namaPenggantiController = TextEditingController(text: 'LUH SUMANTRI ARYANI');
  final _nikPenggantiController = TextEditingController(text: '5108065209840002');
  final _noKkPenggantiController = TextEditingController(text: '5108061204090011');
  final _alamatPenggantiController = TextEditingController(text: 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verifikasi Kpm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.3),
                ),
                Text(
                  'Badan Pangan Nasional / Perum BULOG',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
              ],
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
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
                    // 1. Protokol Penyaluran Cadangan Pangan Banner
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

                    // 2. Data PBP Awal yang Digantikan
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2F6),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.person_remove_outlined, size: 16, color: Color(0xFF64748B)),
                                  SizedBox(width: 6),
                                  Text(
                                    'Data PBP Awal yang Digantikan',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF475569)),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFFFE4E6), borderRadius: BorderRadius.circular(12)),
                                child: const Row(
                                  children: [
                                    Text('•', style: TextStyle(color: Color(0xFFE11D48), fontSize: 12)),
                                    SizedBox(width: 4),
                                    Text('Digantikan', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFFE11D48))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black12),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I GEDE SUARDIKA',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                    ),
                                    SizedBox(height: 2),
                                    Text('NIK: 510806******0004', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                                    Text('No. PBP: 510806200500019', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFFFDE68A)),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.edit_outlined, size: 12, color: Color(0xFFD97706)),
                                    SizedBox(width: 4),
                                    Text('Ubah Data', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFD97706))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3. Gunakan penerima pengganti dari data cadangan resmi SPTJM Desa
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.check_box_outlined, color: Color(0xFFD97706), size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gunakan penerima pengganti dari data cadangan resmi SPTJM Desa',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.25),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Daftar terdaftar pada Musdes Penetapan Tambahan',
                                  style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _useMusdesData,
                            activeColor: const Color(0xFFE88B00),
                            activeTrackColor: const Color(0xFFFDE68A),
                            onChanged: (val) => setState(() => _useMusdesData = val),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 4. Alasan Penggantian PBP * (Wajib Sesuai Juknis)
                    RichText(
                      text: const TextSpan(
                        text: 'Alasan Penggantian PBP ',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                        children: [
                          TextSpan(text: '* ', style: TextStyle(color: Color(0xFFE11D48))),
                          TextSpan(text: '(Wajib Sesuai Juknis)', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Dropdown Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_pin_outlined, size: 18, color: Color(0xFFD97706)),
                              SizedBox(width: 8),
                              Text('Meninggal Dunia', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Alert kecil surat kematian
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 14, color: Color(0xFF2563EB)),
                          SizedBox(width: 8),
                          Text(
                            'Memerlukan surat keterangan kematian atau SPTJM resmi.',
                            style: TextStyle(fontSize: 9.5, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Pilihan Alasan Cepat
                    const Text('Pilihan Alasan Cepat:', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _reasonChip('Alamat Tidak Ditemukan'),
                        _reasonChip('Sudah Mampu'),
                        _reasonChip('ASN'),
                        _reasonChip('TNI'),
                        _reasonChip('Polri'),
                        _reasonChip('Meninggal'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 5. Card Data Penerima Pengganti (VALIDASI DUKCAPIL)
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person_add_alt_1_outlined, size: 20, color: Color(0xFFD97706)),
                                  SizedBox(width: 8),
                                  Text(
                                    'Data Penerima\nPengganti',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                                  ),
                                ],
                              ),
                              Text(
                                'VALIDASI\nDUKCAPIL',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 0.5),
                              ),
                            ],
                          ),
                          const Divider(height: 20),

                          // Nama Penerima Pengganti
                          const Text('Nama Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _namaPenggantiController,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.check_circle_outline, color: Color(0xFF059669), size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // NIK Penerima Pengganti
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NIK Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                              Text('✓ 16 / 16 Karakter', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _nikPenggantiController,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF0F172A)),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.check_circle_outline, color: Color(0xFF059669), size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // No. KK Penerima Pengganti
                          const Text('No. KK Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _noKkPenggantiController,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF0F172A)),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.badge_outlined, color: Color(0xFF64748B), size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Alamat Penerima Pengganti
                          const Text('Alamat Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _alamatPenggantiController.text,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Aturan Validasi Lapangan Alert
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1F2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFFECDD3)),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Color(0xFFE11D48), size: 18),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Aturan Validasi Lapangan:',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFBE123C)),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'NIK tidak boleh kosong dan harus 16 digit angka valid yang telah terdaftar di database DKB Kemendagri.',
                                        style: TextStyle(fontSize: 9.5, color: Color(0xFFBE123C), height: 1.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 6. SPTJM Pengganti Terlampir Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.qr_code_2, color: Color(0xFF4F46E5), size: 22),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SPTJM Pengganti Terlampir',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'SPTJM-510806-2024-008.PDF',
                                  style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle_outline, color: Color(0xFF059669), size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons (Kembali & Dokumentasi)
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step4CameraGeotagScreen()));
                        },
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                        label: const Text('Dokumentasi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black)),
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

  Widget _reasonChip(String label) {
    final bool isSelected = _selectedReason == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedReason = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE88B00) : const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.black : const Color(0xFF1E3A8A),
          ),
        ),
      ),
    );
  }
}
