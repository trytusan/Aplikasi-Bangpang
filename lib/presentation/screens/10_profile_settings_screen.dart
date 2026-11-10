import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '01_login_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _compressPhoto = true;
  bool _autoGeotag = true;
  bool _lockGpsRadius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan & Profil Petugas', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Card Profil
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.primaryAmber,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                            ),
                            child: const Center(
                              child: Text('YK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.navyDark)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Yogik Kurniawan, S.T.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                              Text('NIP. 19890412 201402 1 003', style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.textMuted)),
                              SizedBox(height: 4),
                              Text('Satgas Bapanas Kab. Buleleng', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.navyPrimary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Offline Storage & Sync Controls
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('PENYIMPANAN OFFLINE & SINKRONISASI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSubtle)),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Data BAST di Memori HP', style: TextStyle(fontSize: 11, color: AppColors.textMain)),
                              Text('36 Data & Foto', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.navyPrimary)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.successGreen,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('✓ 36 Data BAST Berhasil Disinkronisasi ke Cloud!')),
                                );
                              },
                              icon: const Icon(Icons.sync, size: 16),
                              label: const Text('SINKRONISASI SEKARANG (FORCE SYNC)'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Preferensi Perangkat
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('PREFERENSI PERANGKAT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSubtle)),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Kompresi Foto (Hemat Kuota)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                            value: _compressPhoto,
                            activeColor: AppColors.primaryAmberDark,
                            onChanged: (val) => setState(() => _compressPhoto = val),
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Watermark Koordinat Otomatis', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                            value: _autoGeotag,
                            activeColor: AppColors.primaryAmberDark,
                            onChanged: (val) => setState(() => _autoGeotag = val),
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Kunci Radius GPS (< 20 Meter)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                            value: _lockGpsRadius,
                            activeColor: AppColors.primaryAmberDark,
                            onChanged: (val) => setState(() => _lockGpsRadius = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  foregroundColor: AppColors.dangerRed,
                  side: const BorderSide(color: Color(0xFFFECACA)),
                  backgroundColor: AppColors.dangerRedLight,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text('KELUAR DARI AKUN (LOGOUT)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
