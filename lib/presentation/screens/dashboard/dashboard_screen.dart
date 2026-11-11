import 'package:flutter/material.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../delivery_type/delivery_type_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../report/report_screen.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_menu.dart';
import 'widgets/quota_card.dart';
import 'widgets/sync_banner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kartu Statistik Kuota & Progress Bar
                    const QuotaCard(
                      totalQuota: 48,
                      distributed: 43,
                      remaining: 5,
                    ),
                    const SizedBox(height: 18),

                    // Label Menu Operasional
                    const Row(
                      children: [
                        Text(
                          'Menu Operasional',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Menu 1: Penyerahan PBP (Fitur Utama - Amber Gradient)
                    DashboardMenu(
                      icon: Icons.how_to_reg_rounded,
                      title: 'Penyerahan PBP',
                      description: 'Verifikasi identitas KPM, foto geotagging & TTD digital',
                      iconGradient: const LinearGradient(
                        colors: [Color(0xFFE88B00), Color(0xFFF59E0B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconColor: const Color(0xFFE88B00),
                      badgeText: 'UTAMA',
                      badgeColor: const Color(0xFFFEF3C7),
                      badgeTextColor: const Color(0xFFB45309),
                      isPrimary: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DeliveryTypeScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Menu 2: Pencarian PBP (Navy/Blue Gradient)
                    DashboardMenu(
                      icon: Icons.person_search_rounded,
                      title: 'Pencarian PBP',
                      description: 'Cari riwayat penerima berdasarkan NIK, KK, atau status BAST',
                      iconGradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconColor: const Color(0xFF1E3A8A),
                      badgeText: '48 Data',
                      badgeColor: const Color(0xFFEFF6FF),
                      badgeTextColor: const Color(0xFF1D4ED8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HistoryScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Menu 3: Laporan Sisa PBP (Teal/Emerald Gradient)
                    DashboardMenu(
                      icon: Icons.pie_chart_rounded,
                      title: 'Laporan Sisa PBP',
                      description: 'Rekapitulasi distribusi, ekspor Excel & notifikasi warga',
                      iconGradient: const LinearGradient(
                        colors: [Color(0xFF0F766E), Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconColor: const Color(0xFF0F766E),
                      badgeText: 'Sisa 5 KPM',
                      badgeColor: const Color(0xFFFFF1F2),
                      badgeTextColor: const Color(0xFFE11D48),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReportScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    // Banner Sinkronisasi Interaktif
                    const SyncBanner(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BanpangBottomNavBar(
        currentIndex: _currentTab,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          } else {
            setState(() => _currentTab = 0);
          }
        },
      ),
    );
  }
}
