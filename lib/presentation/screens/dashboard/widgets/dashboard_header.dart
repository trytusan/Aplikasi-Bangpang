import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/common/app_confirmation_dialog.dart';

class DashboardHeader extends StatelessWidget {
  final bool isOnline;

  const DashboardHeader({super.key, this.isOnline = true});

  void _showOfficerDetails(BuildContext context) {
    HapticFeedback.lightImpact();
    AppConfirmationDialog.show(
      context,
      icon: Icons.badge_rounded,
      iconColor: const Color(0xFF1E3A8A),
      iconBackgroundColor: const Color(0xFFDBEAFE),
      title: 'Putu Yogik (NIP. 19850723...)',
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
            Text('• Satgas: BAPANAS / BULOG Wilayah Bali', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
            SizedBox(height: 3),
            Text('• Titik Distribusi: Balai Desa Banjar Bali, Buleleng', style: TextStyle(fontSize: 11, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w700)),
            SizedBox(height: 3),
            Text('• Otoritas: Verifikator BAST Lapangan & SPTJM', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
            SizedBox(height: 3),
            Text('• Keamanan: MDM Knox Enrolled & Enkripsi AES-256', style: TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profil & Lokasi
          InkWell(
            onTap: () => _showOfficerDetails(context),
            borderRadius: BorderRadius.circular(14),
            child: Row(
              children: [
                // Avatar dengan Ring Status
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE88B00), Color(0xFFF59E0B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE88B00).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Desa Banjar Bali',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.verified_rounded,
                          size: 15,
                          color: Colors.blue.shade700,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Putu Yogik • Satgas Bulog Bali',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Badge Status Online
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFA7F3D0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF059669),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF065F46),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
