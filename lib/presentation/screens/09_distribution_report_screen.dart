import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '03_step1_delivery_type_screen.dart';
import '05_step3_sptjm_replacement_screen.dart';

class DistributionReportScreen extends StatefulWidget {
  const DistributionReportScreen({super.key});

  @override
  State<DistributionReportScreen> createState() => _DistributionReportScreenState();
}

class _DistributionReportScreenState extends State<DistributionReportScreen> {
  int _activeFilter = 1; // 0: Semua (48), 1: Sisa Belum Diambil (5), 2: Sudah Diterima

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
                    // 1. Lokasi Titik Bagi Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Color(0xFF2563EB), size: 20),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('LOKASI TITIK BAGI', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF2563EB))),
                                  Text('Banjar Bali, Buleleng', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                  Text('KAB. BULELENG, BALI', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2. Realisasi Penyaluran Beras CPP (Donut Chart & Statistik)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Realisasi Penyaluran Beras\nCPP',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                                  ),
                                  SizedBox(height: 2),
                                  Text('Cadangan Pangan Pemerintah Alokasi 10 Kg', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.circle, size: 6, color: Color(0xFF059669)),
                                    SizedBox(width: 4),
                                    Text('Real-time', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Donut Chart Progress Lingkaran
                          const Center(
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: CircularProgressIndicator(
                                      value: 0.896,
                                      strokeWidth: 14,
                                      backgroundColor: Color(0xFFE11D48), // Segmen Merah Sisa 10.4%
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF047857)), // Segmen Hijau Selesai 89.6%
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('48', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1)),
                                      Text('KPM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                                      Text('Total Kuota Desa', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Kapsul Total Disalurkan
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Total Disalurkan: 430 Kg / 480 Kg Beras CBP',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 2 Kotak Status: Diserahkan vs Sisa Belum
                          Row(
                            children: [
                              // Diserahkan
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('DISERAHKAN', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                                          Icon(Icons.check_circle, size: 12, color: Color(0xFF059669)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      RichText(
                                        text: const TextSpan(
                                          text: '43 ',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                                          children: [
                                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF065F46))),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: const LinearProgressIndicator(
                                          value: 0.896,
                                          minHeight: 4,
                                          backgroundColor: Colors.white54,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF047857)),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Realisasi', style: TextStyle(fontSize: 8, color: Color(0xFF065F46))),
                                          Text('89.6%', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF047857))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Sisa Belum
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('SISA BELUM', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF9F1239))),
                                          Icon(Icons.inventory_2_outlined, size: 12, color: Color(0xFFE11D48)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      RichText(
                                        text: const TextSpan(
                                          text: '5 ',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFFE11D48)),
                                          children: [
                                            TextSpan(text: 'KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF9F1239))),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: const LinearProgressIndicator(
                                          value: 0.104,
                                          minHeight: 4,
                                          backgroundColor: Colors.white54,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE11D48)),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Sisa Stok', style: TextStyle(fontSize: 8, color: Color(0xFF9F1239))),
                                          Text('10.4%', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. Section Daftar Penerima Bantuan (PBP)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar Penerima Bantuan\n(PBP)',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                        ),
                        Text('Update 10:24\nWITA', textAlign: TextAlign.right, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Filter Chips Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _filterChip('Semua (48)', isSelected: _activeFilter == 0, onTap: () => setState(() => _activeFilter = 0)),
                          const SizedBox(width: 8),
                          _filterChip(
                            '• Sisa Belum Diambil (5)',
                            isSelected: _activeFilter == 1,
                            selectedBg: const Color(0xFF991B1B),
                            onTap: () => setState(() => _activeFilter = 1),
                          ),
                          const SizedBox(width: 8),
                          _filterChip('Sudah Diterima', isSelected: _activeFilter == 2, onTap: () => setState(() => _activeFilter = 2)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // LIST 5 KPM SISA BELUM DIAMBIL

                    // KPM 1: I KETUT WIDIA
                    _buildKpmCard(
                      number: '1',
                      nama: 'I KETUT WIDIA',
                      pbp: '510806102700021',
                      alamat: 'Banjar Dinas Bale Agung, RT 01',
                      badge: 'Belum Diambil',
                      badgeColor: const Color(0xFFFFE4E6),
                      badgeTextColor: const Color(0xFFE11D48),
                      actions: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            icon: const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF1E3A8A)),
                            label: const Text('Hubungi', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1DeliveryTypeScreen())),
                            icon: const Icon(Icons.inventory_2_outlined, size: 14),
                            label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // KPM 2: NI MADE WARTI (Keluarga Sakit)
                    _buildKpmCard(
                      number: '2',
                      nama: 'NI MADE WARTI',
                      pbp: '510806200500008',
                      alamat: 'Banjar Dinas Bale Agung, RT 02',
                      badge: '[+] Keluarga Sakit',
                      badgeColor: const Color(0xFFFEF3C7),
                      badgeTextColor: const Color(0xFFB45309),
                      note: 'Perlu distribusi kolektif / diantar ke rumah melalui satgas desa.',
                      actions: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            icon: const Icon(Icons.delivery_dining, size: 16),
                            label: const Text('Jadwal Antar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // KPM 3: KOMANG ARYA (Alamat Tdk Ditemukan)
                    _buildKpmCard(
                      number: '3',
                      nama: 'KOMANG ARYA',
                      pbp: '510806102700095',
                      alamat: 'Banjar Bali, RT 03',
                      badge: 'Alamat Tdk Ditemukan',
                      badgeColor: const Color(0xFFFFE4E6),
                      badgeTextColor: const Color(0xFFE11D48),
                      actions: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Step3SptjmReplacementScreen())),
                            icon: const Icon(Icons.block, size: 14, color: Color(0xFFE11D48)),
                            label: const Text('Ajukan Pengganti SPTJM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // KPM 4: DESAK PUTU SUCI
                    _buildKpmCard(
                      number: '4',
                      nama: 'DESAK PUTU SUCI',
                      pbp: '510806200500112',
                      alamat: 'Banjar Bali, RT 02',
                      badge: 'Belum Diambil',
                      badgeColor: const Color(0xFFFFE4E6),
                      badgeTextColor: const Color(0xFFE11D48),
                      actions: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            icon: const Icon(Icons.campaign_outlined, size: 14, color: Color(0xFF1E3A8A)),
                            label: const Text('Panggil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1DeliveryTypeScreen())),
                            icon: const Icon(Icons.inventory_2_outlined, size: 14),
                            label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // KPM 5: WAYAN GEDE SUKA
                    _buildKpmCard(
                      number: '5',
                      nama: 'WAYAN GEDE SUKA',
                      pbp: '510806102700140',
                      alamat: 'Banjar Bali, RT 04',
                      badge: 'Belum Diambil',
                      badgeColor: const Color(0xFFFFE4E6),
                      badgeTextColor: const Color(0xFFE11D48),
                      actions: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            icon: const Icon(Icons.campaign_outlined, size: 14, color: Color(0xFF1E3A8A)),
                            label: const Text('Panggil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1DeliveryTypeScreen())),
                            icon: const Icon(Icons.inventory_2_outlined, size: 14),
                            label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 4. Card Laporan Rekapitulasi (BAST Document)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.description_outlined, color: Color(0xFF1E3A8A), size: 18),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Laporan Rekapitulasi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                  Text('Dokumentasi Berita Acara Serah Terima (BAST)', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEEF2FF),
                                foregroundColor: const Color(0xFF1E3A8A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Mengunduh berkas BAST (.PDF / .XLS)...')),
                                );
                              },
                              icon: const Icon(Icons.download, size: 14),
                              label: const Text('Unduh Rekapitulasi BAST (.PDF / .XLS)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Action Button
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SizedBox(
                width: double.infinity,
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
                      const SnackBar(content: Text('Notifikasi pengingat berhasil dikirim ke 5 KPM!')),
                    );
                  },
                  icon: const Icon(Icons.forward_to_inbox, size: 18, color: Colors.black),
                  label: const Text('Kirim Pengingat KPM Sisa (5)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, {required bool isSelected, Color? selectedBg, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? (selectedBg ?? const Color(0xFF0F172A)) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildKpmCard({
    required String number,
    required String nama,
    required String pbp,
    required String alamat,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    String? note,
    required List<Widget> actions,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(6)),
                    child: Center(child: Text(number, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)))),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      Text('PBP: $pbp', style: const TextStyle(fontSize: 8.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(6)),
                child: Text(badge, style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: badgeTextColor)),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Alamat
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 11, color: Color(0xFF64748B)),
                const SizedBox(width: 4),
                Text(alamat, style: const TextStyle(fontSize: 9.5, color: Color(0xFF475569))),
              ],
            ),
          ),

          if (note != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 12, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(note, style: const TextStyle(fontSize: 9, color: Color(0xFFB45309), height: 1.25)),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 8),
          Row(children: actions),
        ],
      ),
    );
  }
}
