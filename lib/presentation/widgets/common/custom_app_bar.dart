import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_confirmation_dialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    this.title = 'Verifikasi KPM',
    this.subtitle = 'Badan Pangan Nasional / Perum BULOG',
    this.onBack,
    this.trailing,
  });

  void _showOfficerProfile(BuildContext context) {
    HapticFeedback.lightImpact();
    AppConfirmationDialog.show(
      context,
      icon: Icons.badge_rounded,
      iconColor: const Color(0xFF1E3A8A),
      iconBackgroundColor: const Color(0xFFDBEAFE),
      title: 'Putu Yogik',
      message: 'Petugas Lapangan Resmi Penyaluran Bantuan Pangan Beras CPP.',
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
            Text('• Satuan: Satgas BAPANAS / BULOG', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
            SizedBox(height: 3),
            Text('• NIP: 198507232010121002', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
            SizedBox(height: 3),
            Text('• Wilayah: Desa Banjar Bali, Kab. Buleleng', style: TextStyle(fontSize: 11, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w700)),
            SizedBox(height: 3),
            Text('• Status: Terverifikasi & Aktif (Online)', style: TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: (canPop || onBack != null)
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
              onPressed: () {
                HapticFeedback.lightImpact();
                if (onBack != null) {
                  onBack!();
                } else if (canPop) {
                  Navigator.pop(context);
                }
              },
            )
          : null,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          trailing ??
              GestureDetector(
                onTap: () => _showOfficerProfile(context),
                child: Container(
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
              ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
