import 'package:flutter/material.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/center_alert.dart';
import '../login/login_screen.dart';
import 'widgets/offline_sync.dart';
import 'widgets/server_status.dart';
import 'widgets/settings_menu.dart';
import 'widgets/stat_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _offlineMode = false;
  String _cacheSize = '34.2 MB';

  void _handleSyncNow() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Color(0xFFE88B00), strokeWidth: 3),
                const SizedBox(height: 18),
                const Text(
                  'Menyinkronkan Berkas BAST...',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Mengunggah 14 berkas foto KPM dan 3 tanda tangan digital ke server cloud BULOG...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Color(0xFF64748B), height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.pop(context); // Tutup dialog loading
      setState(() => _cacheSize = '0.0 MB');
      CenterAlert.showSuccess(
        context,
        title: 'Data Berhasil Disimpan',
        message: '14 berkas foto KPM dan 3 tanda tangan telah tersinkronisasi ke server pusat.',
      );
    });
  }

  void _handleRefreshCoordinates() {
    CenterAlert.showInfo(
      context,
      title: 'Titik Lokasi Diperbarui',
      message: 'Koordinat GPS terkunci: -8.109613, 115.0914146 (Akurasi: ±2.8m)',
    );
  }

  void _showTechSupportDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.support_agent, color: Color(0xFF1E3A8A), size: 22),
            SizedBox(width: 8),
            Text('Layanan Teknis & Bantuan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pusat Bantuan Satgas Pangan BULOG Wilayah Bali:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('• Call Center: 1500-BULOG (Bebas Pulsa)\n• Hotline Korlap Buleleng: 0812-3456-7890\n• Helpdesk IT Bapanas: it-support@bapanas.go.id', style: TextStyle(fontSize: 10.5, color: Color(0xFF475569), height: 1.4)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showJuknisDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF4F46E5), size: 20),
            SizedBox(width: 8),
            Text('Juknis Penyerahan CPP 2025', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
        content: const Text(
          'Petunjuk Teknis Penyaluran Cadangan Beras Pemerintah:\n1. Setiap KPM berhak menerima 10 Kg Beras Medium CPP.\n2. Wajib verifikasi fisik KTP/KK dan geotagging koordinat di titik bagi.\n3. Apabila KPM berhalangan tetap/meninggal, wajib dilengkapi Surat Pertanggungjawaban Mutlak (SPTJM) Desa.',
          style: TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.35),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F46E5), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mengunduh dokumen PDF Juknis Resmi...')),
              );
            },
            child: const Text('Unduh PDF Lengkap'),
          ),
        ],
      ),
    );
  }

  void _showRegulationsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Syarat & Regulasi Distribusi'),
        content: const Text(
          'Keputusan Kepala Badan Pangan Nasional (Bapanas) Republik Indonesia Nomor 01/2025 tentang Penyaluran Bantuan Pangan Beras untuk Keluarga Penerima Manfaat.',
          style: TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.3),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showChangePinDialog() {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Ubah PIN Otorisasi BAST'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Masukkan 6-digit PIN keamanan baru untuk pengesahan BAST:', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            const SizedBox(height: 12),
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4),
              decoration: InputDecoration(
                counterText: '',
                hintText: '••••••',
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(ctx);
              CenterAlert.showSuccess(
                context,
                title: 'PIN Berhasil Disimpan',
                message: 'PIN otorisasi BAST baru aktif untuk transaksi.',
              );
            },
            child: const Text('Simpan PIN'),
          ),
        ],
      ),
    );
  }

  void _showDeviceRegisteredDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Perangkat Lapangan Terdaftar'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Model: Samsung Tab Active4 Pro', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            Text('• IMEI: 358920192847192 (MDM Enrolled)', style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
            Text('• Status Enkripsi: Knox Enterprise Security Valid', style: TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
            Text('• Petugas Otorisasi: Putu Yogik (NIP. 198507232010121002)', style: TextStyle(fontSize: 10.5, color: Color(0xFF475569))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari Sistem Lapangan?'),
        content: const Text(
          'Pastikan seluruh data penyerahan BAST telah disinkronkan ke server pusat BULOG sebelum keluar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header Top Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFDBEAFE)),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      color: Color(0xFF1E3A8A),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Banpang Mobile',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.circle, size: 6, color: _offlineMode ? const Color(0xFFD97706) : const Color(0xFF059669)),
                            const SizedBox(width: 3),
                            Text(
                              _offlineMode ? 'OFFLINE' : 'ONLINE',
                              style: TextStyle(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                color: _offlineMode ? const Color(0xFFD97706) : const Color(0xFF059669),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Pengaturan & Akun Petugas Lapangan',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=120&q=80',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),

            if (_offlineMode)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: const Color(0xFFFEF3C7),
                child: const Row(
                  children: [
                    Icon(Icons.wifi_off, size: 14, color: Color(0xFFB45309)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Mode Luar Jaringan Aktif: Seluruh berkas BAST & foto tersimpan aman di memori lokal.',
                        style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFFB45309)),
                      ),
                    ),
                  ],
                ),
              ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ServerStatus(),
                    const SizedBox(height: 12),
                    const StatCard(),
                    const SizedBox(height: 16),
                    OfflineSync(
                      offlineMode: _offlineMode,
                      onToggleOfflineMode: (val) {
                        setState(() => _offlineMode = val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(val ? 'Mode Luar Jaringan Dinyalakan' : 'Kembali ke Mode Online Server'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      onSyncNow: _handleSyncNow,
                      onRefreshCoordinates: _handleRefreshCoordinates,
                    ),
                    const SizedBox(height: 16),
                    SettingsMenu(
                      onLogout: _handleLogout,
                      onTechSupport: _showTechSupportDialog,
                      onJuknisPdf: _showJuknisDialog,
                      onRegulations: _showRegulationsDialog,
                      onChangePin: _showChangePinDialog,
                      onDeviceRegistered: _showDeviceRegisteredDialog,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BanpangBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
