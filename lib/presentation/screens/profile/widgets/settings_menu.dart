import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback? onTechSupport;
  final VoidCallback? onJuknisPdf;
  final VoidCallback? onRegulations;
  final VoidCallback? onChangePin;
  final VoidCallback? onDeviceRegistered;

  const SettingsMenu({
    super.key,
    required this.onLogout,
    this.onTechSupport,
    this.onJuknisPdf,
    this.onRegulations,
    this.onChangePin,
    this.onDeviceRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                onTap: onTechSupport,
              ),
              const Divider(height: 1, indent: 56),
              _menuItem(
                icon: Icons.menu_book_outlined,
                iconColor: const Color(0xFF4F46E5),
                title: 'Juknis Penyerahan CPP 2025',
                subtitle: 'Tata cara BAST, foto KTP, dan penanganan kendala fisik',
                badge: 'PDF',
                trailingIcon: Icons.open_in_new,
                onTap: onJuknisPdf,
              ),
              const Divider(height: 1, indent: 56),
              _menuItem(
                icon: Icons.gavel_outlined,
                iconColor: const Color(0xFFB45309),
                title: 'Syarat & Regulasi Distribusi',
                subtitle: 'Keputusan Kepala Bapanas No. 01/2025 tentang Bapang',
                onTap: onRegulations,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

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
                onTap: onChangePin,
              ),
              const Divider(height: 1, indent: 56),
              _menuItem(
                icon: Icons.devices,
                iconColor: const Color(0xFF059669),
                title: 'Perangkat Lapangan Terdaftar',
                subtitle: 'Samsung Tab Active4 Pro (IMEI terdaftar)',
                onTap: onDeviceRegistered,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE4E6),
              foregroundColor: const Color(0xFFE11D48),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onLogout,
            icon: const Icon(Icons.logout, size: 16),
            label: const Text('Keluar dari Sistem Lapangan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
    );
  }

  Widget _menuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? badge,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
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
      ),
    );
  }
}
