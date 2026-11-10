import 'package:flutter/material.dart';
import '02_dashboard_screen.dart';

class Step5ReviewBastScreen extends StatelessWidget {
  const Step5ReviewBastScreen({super.key});

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
                    // 1. Status Waktu & Subjek Distribusi
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
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
                                  Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF64748B)),
                                  SizedBox(width: 6),
                                  Text('Waktu Distribusi', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Text('23 Juli 2025, 09:44 WITA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF64748B)),
                                  SizedBox(width: 6),
                                  Text('Status Subjek', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(6)),
                                child: const Text('Pengganti SPTJM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFB45309))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(8)),
                            child: const Row(
                              children: [
                                Icon(Icons.info_outline, size: 12, color: Color(0xFFD97706)),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Diubah → Pengganti (Sesuai SPTJM Kelurahan/Desa)',
                                    style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFFB45309)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2. Data Penerima Manfaat Card (Kemendagri Valid)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.badge_outlined, size: 18, color: Color(0xFF1E3A8A)),
                                  SizedBox(width: 8),
                                  Text(
                                    'Data Penerima\nManfaat',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(20)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle, size: 12, color: Color(0xFF059669)),
                                    SizedBox(width: 4),
                                    Text('Kemendagri\nValid', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF065F46), height: 1.1)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Profil KPM Pengganti
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('LUH SUMANTRI ARYANI', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                    SizedBox(height: 2),
                                    Text('KPM Pengganti Sah', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFD97706))),
                                    Text('NIK: 5108065209840002', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // 2 Kolom Detail Legalitas
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Nomor Kartu Keluarga', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                                      SizedBox(height: 2),
                                      Text('5108061204090011', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('KPM Sebelumnya (Diganti)', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                                      SizedBox(height: 2),
                                      Text('I GEDE SUARDIKA', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                                      Text('(Meninggal Dunia)', style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B))),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Alokasi Bantuan Pangan
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(color: const Color(0xFFF59E0B), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.inventory_2, color: Colors.white, size: 18),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ALOKASI BANTUAN PANGAN', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFFB45309))),
                                      Text('Beras Medium CPP 10 Kg', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                    ],
                                  ),
                                ),
                                const Text('1 Karung', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Alamat Domisili KPM
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Alamat Domisili KPM', style: TextStyle(fontSize: 9, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                SizedBox(height: 2),
                                Text(
                                  'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali, Buleleng, Kabupaten Buleleng, Bali',
                                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A), height: 1.3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 3 Lampiran Bukti Penyerahan
                          const Text('LAMPIRAN BUKTI PENYERAHAN', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // 1. Fisik Beras
                              Expanded(
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.black.withValues(alpha: 0.7),
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: const Text('Fisik Beras', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w800)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // 2. Surat SPTJM
                              Expanded(
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=200'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.black.withValues(alpha: 0.7),
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: const Text('Surat SPTJM', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w800)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // 3. Tanda Tangan Terverifikasi
                              Expanded(
                                child: Container(
                                  height: 70,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFBFDBFE))),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit_note, color: Color(0xFF2563EB), size: 24),
                                      SizedBox(height: 2),
                                      Text('Tanda Tangan\nTerverifikasi', textAlign: TextAlign.center, style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A), height: 1.1)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 3. Verifikasi Titik Koordinat (Map Box)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                                  Icon(Icons.my_location, size: 18, color: Color(0xFF059669)),
                                  SizedBox(width: 8),
                                  Text('Verifikasi Titik\nKoordinat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                                child: const Text('🎯 Radius Valid (< 50m)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Map Box Preview
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Stack(
                              children: [
                                const Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, color: Color(0xFFE11D48), size: 16),
                                      SizedBox(width: 4),
                                      Text('V3FG+8JP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    color: Colors.black.withValues(alpha: 0.75),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Baktiseraga, Kab. Buleleng', style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w700)),
                                            Text('Lat: -8.109613, Long: 115.0914146', style: TextStyle(color: Colors.white70, fontSize: 7.5, fontFamily: 'monospace')),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('Akurasi 3.2m', style: TextStyle(color: Color(0xFF34D399), fontSize: 8.5, fontWeight: FontWeight.w900)),
                                            Text('Tinggi (GPS Satelit)', style: TextStyle(color: Colors.white70, fontSize: 7.5)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 4. Perhatian Khusus Petugas Lapangan Alert
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.warning_rounded, color: Color(0xFFD97706), size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Perhatian Khusus Petugas Lapangan',
                                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFFB45309)),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Pastikan fisik beras telah diserahterimakan dan Berita Acara telah ditandatangani/cap jempol sebelum menekan tombol Kirim BAST. Data tersinkronisasi langsung ke sistem pusat PANGAN BULOG.',
                                  style: TextStyle(fontSize: 9.5, color: Color(0xFF92400E), height: 1.35),
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✓ Penyerahan Beras Berhasil Disinkronkan ke Pusat BAPANAS & BULOG!')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.cloud_upload_outlined, size: 16, color: Colors.black),
                        label: const Text('Kirim Penyerahan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black)),
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
