import 'package:flutter/material.dart';
import '../../widgets/common/app_confirmation_dialog.dart';
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFFE88B00), strokeWidth: 3),
                SizedBox(height: 18),
                Text(
                  'Menyinkronkan Berkas BAST...',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                ),
                SizedBox(height: 6),
                Text(
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
    AppConfirmationDialog.show(
      context,
      icon: Icons.support_agent_rounded,
      iconColor: const Color(0xFF1E3A8A),
      iconBackgroundColor: const Color(0xFFDBEAFE),
      title: 'Layanan Teknis & Bantuan',
      message: 'Pusat Bantuan Satgas Pangan BULOG Wilayah Bali siap melayani kendala operasional lapangan.',
      confirmText: 'Tutup',
      cancelText: null,
      customContent: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Call Center: 1500-BULOG (Bebas Pulsa)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
            SizedBox(height: 4),
            Text('• Hotline Buleleng: 0812-3456-7890', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
            SizedBox(height: 4),
            Text('• Helpdesk: it-support@bapanas.go.id', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
          ],
        ),
      ),
    );
  }

  void _showJuknisDialog() {
    AppConfirmationDialog.show(
      context,
      icon: Icons.menu_book_rounded,
      iconColor: const Color(0xFF4F46E5),
      iconBackgroundColor: const Color(0xFFEEF2FF),
      title: 'Juknis Penyerahan CPP 2025',
      message: 'Petunjuk Teknis Penyaluran Cadangan Beras Pemerintah untuk Keluarga Penerima Manfaat.',
      confirmText: 'Unduh PDF',
      confirmColor: const Color(0xFF4F46E5),
      confirmTextColor: Colors.white,
      cancelText: 'Tutup',
      customContent: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. Setiap KPM berhak menerima 10 Kg Beras Medium.', style: TextStyle(fontSize: 11, color: Color(0xFF334155))),
            SizedBox(height: 4),
            Text('2. Wajib verifikasi fisik KTP/KK & geotagging koordinat.', style: TextStyle(fontSize: 11, color: Color(0xFF334155))),
            SizedBox(height: 4),
            Text('3. Jika berhalangan tetap/meninggal, wajib sertakan SPTJM.', style: TextStyle(fontSize: 11, color: Color(0xFF334155))),
          ],
        ),
      ),
    ).then((proceed) {
      if (proceed == true && mounted) {
        CenterAlert.show(
          context,
          title: 'Mengunduh PDF',
          message: 'Berkas Juknis CPP 2025 tersimpan di folder Dokumen.',
          type: CenterAlertType.info,
        );
      }
    });
  }

  void _showRegulationsDialog() {
    AppConfirmationDialog.showInfo(
      context,
      icon: Icons.gavel_rounded,
      title: 'Syarat & Regulasi Distribusi',
      message: 'Keputusan Kepala Badan Pangan Nasional (Bapanas) Republik Indonesia Nomor 01/2025 tentang Penyaluran Bantuan Pangan Beras untuk Keluarga Penerima Manfaat.',
      confirmText: 'Tutup',
    );
  }

  void _showChangePinDialog() {
    final pinController = TextEditingController();
    AppConfirmationDialog.show(
      context,
      icon: Icons.pin_rounded,
      iconColor: const Color(0xFFE88B00),
      iconBackgroundColor: const Color(0xFFFEF3C7),
      title: 'Ubah PIN Otorisasi BAST',
      message: 'Masukkan 6 digit angka PIN baru untuk pengesahan berita acara serah terima di lapangan:',
      confirmText: 'Simpan PIN',
      cancelText: 'Batal',
      confirmColor: const Color(0xFFE88B00),
      confirmTextColor: const Color(0xFF0F172A),
      customContent: TextField(
        controller: pinController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 6,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 6),
        decoration: InputDecoration(
          counterText: '',
          hintText: '••••••',
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), letterSpacing: 6),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE88B00), width: 1.8)),
        ),
      ),
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        CenterAlert.showSuccess(
          context,
          title: 'PIN Berhasil Disimpan',
          message: 'PIN otorisasi BAST baru aktif untuk transaksi.',
        );
      }
    });
  }

  void _showDeviceRegisteredDialog() {
    AppConfirmationDialog.show(
      context,
      icon: Icons.verified_user_rounded,
      iconColor: const Color(0xFF059669),
      iconBackgroundColor: const Color(0xFFD1FAE5),
      title: 'Perangkat Terdaftar',
      message: 'Perangkat ini telah terdaftar dan terotorisasi resmi dalam sistem MDM Bulog.',
      confirmText: 'Tutup',
      cancelText: null,
      customContent: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Model: Samsung Tab Active4 Pro', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
            SizedBox(height: 3),
            Text('• IMEI: 358920192847192 (MDM Enrolled)', style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
            SizedBox(height: 3),
            Text('• Enkripsi: Knox Enterprise Valid', style: TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
            SizedBox(height: 3),
            Text('• Petugas: Putu Yogik (NIP. 198507232010121002)', style: TextStyle(fontSize: 10.5, color: Color(0xFF475569))),
          ],
        ),
      ),
    );
  }

  void _handleLogout() async {
    final confirmed = await AppConfirmationDialog.showDanger(
      context,
      title: 'Keluar dari Sistem Lapangan?',
      message: 'Pastikan seluruh data penyerahan BAST telah disinkronkan ke server pusat BULOG sebelum keluar.',
      confirmText: 'Ya, Keluar',
      cancelText: 'Batal',
    );

    if (confirmed == true && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
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
