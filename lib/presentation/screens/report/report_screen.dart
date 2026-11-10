import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import 'widgets/bast_download_card.dart';
import 'widgets/donut_chart.dart';
import 'widgets/kpm_pending_list.dart';
import 'widgets/location_card.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _activeFilter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LocationCard(),
                    const SizedBox(height: 14),
                    const DonutChart(),
                    const SizedBox(height: 16),
                    KpmPendingList(
                      activeFilter: _activeFilter,
                      onFilterChanged: (val) => setState(() => _activeFilter = val),
                    ),
                    const SizedBox(height: 16),
                    const BastDownloadCard(),
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
}
