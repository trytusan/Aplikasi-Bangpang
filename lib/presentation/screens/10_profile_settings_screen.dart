import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '01_login_screen.dart';
import '02_dashboard_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _offlineMode = false;

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
                  'Banpang Mobile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.3),
                ),
                Text(
                  'Penyerahan',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(12)),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, size: 6, color: Color(0xFF059669)),
                      SizedBox(width: 4),
                      Text('ONLINE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 34,
                  height: 34,
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
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Banner Server & Titik Bagi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on, size: 13, color: Color(0xFFE11D48)),
                              SizedBox(width: 4),
                              Text(
                                'Titik Bagi: Desa Banjar Bali, Buleleng',
                                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(6)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.circle, size: 5, color: Color(0xFF059669)),
                                    SizedBox(width: 4),
                                    Text('Server BULOG Terhubung (Online)', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                                  ],
                                ),
                              ),
                              const Text('Ping: 22ms', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 2. Dua Card Statistik: Total BAST Hari Ini vs Sisa Kuota Titik
                    Row(
                      children: [
                        // Card 1
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF059669), size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total BAST Hari Ini', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text('184', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                        SizedBox(width: 4),
                                        Text('KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Card 2
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.shield_outlined, color: Color(0xFFD97706), size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sisa Kuota Titik', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text('36', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFFB45309))),
                                        SizedBox(width: 4),
                                        Text('KPM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ================= SECTION 1: OPERASIONAL & SINKRONISASI =================
                    const Row(
                      children: [
                        Icon(Icons.tune, size: 14, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 6),
                        Text('OPERASIONAL & SINKRONISASI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                      ],
                    ),
                    const SizedBox(height: 8),

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
                          // Mode Luar Jaringan
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.signal_cellular_connected_no_internet_4_bar, color: Color(0xFF4F46E5), size: 18),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Mode Luar Jaringan', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                    Text('Simpan data BAST & foto di penyimpanan lokal jika sinyal di pelosok lemah.', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), height: 1.25)),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _offlineMode,
                                activeColor: const Color(0xFFE88B00),
                                onChanged: (val) => setState(() => _offlineMode = val),
                              ),
                            ],
                          ),
                          const Divider(height: 20),

                          // Sinkronisasi Manual & Cache
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.cloud_sync_outlined, color: Color(0xFFD97706), size: 18),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sinkronisasi Manual & Cache', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                    Text('14 berkas foto KPM dan 3 tanda tangan digital tersimpan di memori aman perangkat.', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), height: 1.25)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                                child: const Text('34.2 MB', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE88B00),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('✓ 14 berkas data BAST berhasil disinkronkan ke pusat!')),
                                );
                              },
                              icon: const Icon(Icons.cloud_upload_outlined, size: 16),
                              label: const Text('Sinkronkan Sekarang', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                            ),
                          ),
                          const Divider(height: 20),

                          // Perbarui Titik Lokasi GPS
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.my_location, color: Color(0xFF059669), size: 18),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Perbarui Titik Lokasi GPS', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                  ],
                                ),
                              ),
                              const Text('🎯 Akurasi 3m', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                            child: const Text('Lat: -8.109613, Long: 115.0914146', style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFFEEF2FF),
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.refresh, size: 14, color: Color(0xFF1E3A8A)),
                              label: const Text('Perbarui Koordinat Lapangan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ================= SECTION 2: PANDUAN & BANTUAN =================
                    const Row(
                      children: [
                        Icon(Icons.headset_mic_outlined, size: 14, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 6),
                        Text('PANDUAN & BANTUAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _menuItem(
                            icon: Icons.support_agent_outlined,
                            iconColor: const Color(0xFF1E3A8A),
                            title: 'Layanan Teknis & Bantuan',
                            subtitle: 'Call center Satgas BULOG & hotline Wilayah Bali',
                          ),
                          const Divider(height: 1, indent: 56),
                          _menuItem(
                            icon: Icons.menu_book_outlined,
                            iconColor: const Color(0xFF4F46E5),
                            title: 'Juknis Penyerahan CPP 2025',
                            subtitle: 'Tata cara BAST, foto KTP, dan penanganan kendala fisik',
                            badge: 'PDF',
                            trailingIcon: Icons.open_in_new,
                          ),
                          const Divider(height: 1, indent: 56),
                          _menuItem(
                            icon: Icons.gavel_outlined,
                            iconColor: const Color(0xFFB45309),
                            title: 'Syarat & Regulasi Distribusi',
                            subtitle: 'Keputusan Kepala Bapanas No. 01/2025 tentang Bapang',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ================= SECTION 3: KEAMANAN & AKUN =================
                    const Row(
                      children: [
                        Icon(Icons.security, size: 14, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 6),
                        Text('KEAMANAN & AKUN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _menuItem(
                            icon: Icons.pin_outlined,
                            iconColor: const Color(0xFF0F172A),
                            title: 'Ubah Kata Sandi & PIN BAST',
                            subtitle: 'Terakhir diubah 10 hari lalu',
                          ),
                          const Divider(height: 1, indent: 56),
                          _menuItem(
                            icon: Icons.devices,
                            iconColor: const Color(0xFF059669),
                            title: 'Perangkat Lapangan Terdaftar',
                            subtitle: 'Samsung Tab Active4 Pro (IMEI terdaftar)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Tombol Logout Merah Pastel
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFE4E6),
                          foregroundColor: const Color(0xFFBE123C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout, size: 16),
                        label: const Text('Keluar dari Sistem Lapangan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                      ),
                    ),
                    const SizedBox(height: 6),

                    const Center(
                      child: Text(
                        'Permohonan Penonaktifan Petugas ›',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFE11D48)),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Version Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'BANPANG MOBILE V1.3.3 (BUILD 2025072507)',
                            style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)),
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.circle, size: 6, color: Color(0xFF059669)),
                              SizedBox(width: 4),
                              Text('Production Environment (Prod-DPS-01)', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Color(0xFF065F46))),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '© Divisi Teknologi Informasi Perum BULOG & Badan Pangan Nasional RI 2025. Dilindungi hak cipta negara.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 7.5, color: Color(0xFF64748B), height: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen())),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inbox_rounded, color: Color(0xFF64748B), size: 24),
                            SizedBox(height: 4),
                            Text('Penyerahan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings_outlined, color: Color(0xFFE88B00), size: 24),
                          SizedBox(height: 4),
                          Text('Pengaturan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFE88B00))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? badge,
    IconData? trailingIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    if (badge != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(4)),
                        child: Text(badge, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                      ),
                    ],
                  ],
                ),
                Text(subtitle, style: const TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
              ],
            ),
          ),
          Icon(trailingIcon ?? Icons.chevron_right, size: 16, color: const Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}
