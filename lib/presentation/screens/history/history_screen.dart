import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/repositories/bast_repository.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../delivery_type/delivery_type_screen.dart';
import 'widgets/bast_detail_sheet.dart';
import 'widgets/history_card_items.dart';
import 'widgets/history_filter.dart';
import 'widgets/history_summary_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedFilter = 0; // 0: Semua, 1: PBP Normal, 2: Pengganti SPTJM, 3: Perwakilan KK
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showBastDetail({
    required String bastNo,
    required String nama,
    required String nik,
    required String pbp,
    required String waktu,
    required String jenis,
    required String imageUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BastDetailSheet(
        bastNo: bastNo,
        nama: nama,
        nik: nik,
        pbp: pbp,
        waktu: waktu,
        jenis: jenis,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.toLowerCase().trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Riwayat Transaksi BAST',
        subtitle: 'Monitoring Penyerahan Beras Bapanas',
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: BastRepository.instance,
          builder: (context, _) {
            final repo = BastRepository.instance;
            final allRecords = repo.records;

            // Hitung statistik kategori
            final normalCount = repo.normalCount;
            final replacementCount = repo.replacementCount;
            final representativeCount = repo.representativeCount;

            // Logika Penyaringan Kategori & Pencarian
            final filtered = allRecords.where((r) {
              // 1. Filter Kategori
              if (_selectedFilter == 1 && !r.jenis.contains('NORMAL')) return false;
              if (_selectedFilter == 2 && !r.jenis.contains('PENGGANTI')) return false;
              if (_selectedFilter == 3 && !r.jenis.contains('PERWAKILAN')) return false;

              // 2. Filter Pencarian Teks
              if (query.isNotEmpty) {
                final matchName = r.nama.toLowerCase().contains(query);
                final matchNik = r.nik.contains(query);
                final matchBast = r.bastNo.toLowerCase().contains(query);
                final matchPbp = r.pbpNo.contains(query);
                final matchReplaced = r.replacedName != null && r.replacedName!.toLowerCase().contains(query);

                if (!matchName && !matchNik && !matchBast && !matchPbp && !matchReplaced) {
                  return false;
                }
              }

              return true;
            }).toList();

            return Column(
              children: [
                // Filter Kategori Chips
                HistoryFilter(
                  selectedFilter: _selectedFilter,
                  onSelectFilter: (val) => setState(() => _selectedFilter = val),
                  totalCount: allRecords.length,
                  normalCount: normalCount,
                  replacementCount: replacementCount,
                  representativeCount: representativeCount,
                ),

                // Search Bar Input Modern
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: query.isNotEmpty ? const Color(0xFFE88B00) : const Color(0xFFCBD5E1),
                        width: query.isNotEmpty ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: 'Cari nama KPM, 16 digit NIK, atau No. BAST...',
                        hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                        prefixIcon: const Icon(Icons.search_rounded, size: 20, color: Color(0xFF1E3A8A)),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.cancel_rounded, size: 18, color: Color(0xFF64748B)),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                    ),
                  ),
                ),

                // Konten Daftar Transaksi
                Expanded(
                  child: allRecords.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF1F5F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.inventory_2_outlined, size: 36, color: Color(0xFF94A3B8)),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Database Masih Kosong',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Belum ada data penyerahan BAST yang diinput (Opsi A).\nSilakan lakukan input penyerahan untuk melihat riwayat di sini.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.4),
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE88B00),
                                      foregroundColor: const Color(0xFF0F172A),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const DeliveryTypeScreen()),
                                      );
                                    },
                                    icon: const Icon(Icons.add_circle_outline, size: 16),
                                    label: const Text('Input Penyerahan BAST', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : filtered.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFEF3C7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.search_off_rounded, size: 30, color: Color(0xFFD97706)),
                                    ),
                                    const SizedBox(height: 14),
                                    const Text(
                                      'Tidak Ada Hasil yang Cocok',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      query.isNotEmpty
                                          ? 'Tidak ditemukan KPM dengan kata kunci "$query".'
                                          : 'Tidak ada data transaksi pada kategori ini.',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                    ),
                                    const SizedBox(height: 14),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _searchQuery = '';
                                          _selectedFilter = 0;
                                        });
                                      },
                                      child: const Text('Reset Filter & Pencarian', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E3A8A))),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                              itemCount: filtered.length,
                              itemBuilder: (ctx, index) {
                                final item = filtered[index];
                                return HistoryCardDynamic(
                                  record: item,
                                  onViewDetail: () => _showBastDetail(
                                    bastNo: item.bastNo,
                                    nama: item.nama,
                                    nik: item.nik,
                                    pbp: item.pbpNo,
                                    waktu: item.waktu,
                                    jenis: item.jenis,
                                    imageUrl: item.imageUrl,
                                  ),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: HistorySummaryBar(
        onNewDelivery: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DeliveryTypeScreen()),
          );
        },
      ),
    );
  }
}
