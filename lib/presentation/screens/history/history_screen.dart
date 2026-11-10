import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../delivery_type/delivery_type_screen.dart';
import 'widgets/history_card_items.dart';
import 'widgets/history_filter.dart';
import 'widgets/history_summary_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedFilter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            HistoryFilter(
              selectedFilter: _selectedFilter,
              onSelectFilter: (val) => setState(() => _selectedFilter = val),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: const [
                  HistoryCardNormal(),
                  HistoryCardReplacement(),
                  HistoryCardRepresentative(),
                  HistoryCardRejected(),
                ],
              ),
            ),
            HistorySummaryBar(
              onNewDelivery: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DeliveryTypeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
