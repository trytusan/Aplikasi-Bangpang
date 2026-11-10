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
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const QuotaCard(),
                    const SizedBox(height: 16),

                    // Menu 1: Penyerahan PBP
                    DashboardMenu(
                      icon: Icons.inventory_2_outlined,
                      title: 'Penyerahan PBP',
                      description: 'Melakukan aktifitas penyerahan kepada PBP',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DeliveryTypeScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Menu 2: Pencarian PBP
                    DashboardMenu(
                      icon: Icons.person_search_outlined,
                      title: 'Pencarian PBP',
                      description: 'Melihat status PBP berdasarkan no. PBP',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HistoryScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Menu 3: Laporan Sisa PBP
                    DashboardMenu(
                      icon: Icons.folder_shared_outlined,
                      title: 'Laporan Sisa PBP',
                      description: 'Melihat sisa PBP yang sudah/belum dilakukan penyerahan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReportScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

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
