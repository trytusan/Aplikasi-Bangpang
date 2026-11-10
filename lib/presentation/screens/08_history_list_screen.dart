import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/kpm_model.dart';

class HistoryListScreen extends StatefulWidget {
  const HistoryListScreen({super.key});

  @override
  State<HistoryListScreen> createState() => _HistoryListScreenState();
}

class _HistoryListScreenState extends State<HistoryListScreen> {
  String _selectedFilter = 'ALL'; // 'ALL' | 'DONE' | 'PENDING' | 'SPTJM'
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listKpm = KpmModel.sampleData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Penyerahan BAST', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Horizontal Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filterChip('Semua (48)', 'ALL'),
                    const SizedBox(width: 8),
                    _filterChip('Tersalur (43)', 'DONE'),
                    const SizedBox(width: 8),
                    _filterChip('Sisa / Pending (5)', 'PENDING'),
                    const SizedBox(width: 8),
                    _filterChip('Pengganti SPTJM (2)', 'SPTJM'),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Search Bar
              TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan NIK atau Nama KPM...',
                  hintStyle: const TextStyle(fontSize: 11, color: AppColors.textSubtle),
                  prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderLight)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderLight)),
                ),
              ),
              const SizedBox(height: 12),

              // List of History Cards
              Expanded(
                child: ListView.separated(
                  itemCount: listKpm.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = listKpm[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.nama, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: item.isDiserahkan ? AppColors.successGreenLight : AppColors.warningOrangeLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.isDiserahkan ? '☁️ TERSINKRON' : '⏳ BELUM AMBIL',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: item.isDiserahkan ? AppColors.successGreen : AppColors.primaryAmberDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('NIK: ${item.nik}', style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.textMuted)),
                            const Divider(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.isDiserahkan ? '${item.waktuSerah} • ${item.nomorBast}' : item.dusun,
                                  style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                                ),
                                Text(
                                  item.isSptjm ? 'Pengganti SPTJM' : '10 Kg Beras',
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.navyPrimary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    final bool isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryAmber : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primaryAmberDark : AppColors.borderLight),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: isSelected ? AppColors.navyDark : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
