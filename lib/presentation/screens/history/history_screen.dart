import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../camera_geotag/camera_geotag_screen.dart';
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
  int _selectedFilter = 1; // 0: Semua, 1: Diterima, 2: Belum Verifikasi
  bool _isKetutSynced = false;
  bool _isKetutSyncing = false;
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

  Future<void> _syncKetut() async {
    setState(() => _isKetutSyncing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    setState(() {
      _isKetutSyncing = false;
      _isKetutSynced = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Data transaksi Ketut Artika (Perwakilan 1 KK) berhasil disinkronkan ke Server Pusat!'),
        backgroundColor: Color(0xFF059669),
      ),
    );
  }

  void _navigateToFixPhoto() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraGeotagScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Logika filter tampilan kartu
    final query = _searchQuery.toLowerCase().trim();

    final showNormal = (_selectedFilter == 0 || _selectedFilter == 1) &&
        (query.isEmpty || 'jro nyoman setiasih'.contains(query) || '510806'.contains(query));

    final showReplacement = (_selectedFilter == 0 || _selectedFilter == 1) &&
        (query.isEmpty || 'luh sumantri aryani'.contains(query) || 'i gede suardika'.contains(query));

    final showKetut = (_selectedFilter == 0 ||
            (_selectedFilter == 1 && _isKetutSynced) ||
            (_selectedFilter == 2 && !_isKetutSynced)) &&
        (query.isEmpty || 'ketut artika'.contains(query) || 'putu eka'.contains(query));

    final showRejected = (_selectedFilter == 0 || _selectedFilter == 2) &&
        (query.isEmpty || 'wayan sujana'.contains(query));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Pills
            HistoryFilter(
              selectedFilter: _selectedFilter,
              onSelectFilter: (val) => setState(() => _selectedFilter = val),
            ),

            // Search Bar Input
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(fontSize: 11.5, color: Color(0xFF0F172A)),
                  decoration: InputDecoration(
                    hintText: 'Cari nama KPM, NIK, atau No. BAST...',
                    hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 16, color: Color(0xFF64748B)),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
            ),

            // Daftar Kartu Riwayat
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                children: [
                  if (showNormal)
                    HistoryCardNormal(
                      onViewDetail: () => _showBastDetail(
                        bastNo: 'BAST-2026095108062005',
                        nama: 'JRO NYOMAN SETIASIH',
                        nik: '5108060101750001',
                        pbp: '5108062005000012',
                        waktu: '23 Juli 2025, 09:44 WITA',
                        jenis: 'Penerima Utama (Normal)',
                        imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200',
                      ),
                    ),
                  if (showReplacement)
                    HistoryCardReplacement(
                      onViewDetail: () => _showBastDetail(
                        bastNo: 'BAST-2026095108062006',
                        nama: 'LUH SUMANTRI ARYANI',
                        nik: '5108065209840002',
                        pbp: '5108062005000024',
                        waktu: '23 Juli 2025, 09:15 WITA',
                        jenis: 'Pengganti SPTJM Sah',
                        imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200',
                      ),
                    ),
                  if (showKetut)
                    HistoryCardRepresentative(
                      isSynced: _isKetutSynced,
                      isSyncing: _isKetutSyncing,
                      onSync: _syncKetut,
                      onViewDetail: () => _showBastDetail(
                        bastNo: 'BAST-2026095108062007',
                        nama: 'KETUT ARTIKA',
                        nik: '510806192700029',
                        pbp: '510806192700029',
                        waktu: '23 Juli 2025, 08:30 WITA',
                        jenis: 'Perwakilan (1 KK: Putu Eka)',
                        imageUrl: 'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=200',
                      ),
                    ),
                  if (showRejected)
                    HistoryCardRejected(
                      onFixPhoto: _navigateToFixPhoto,
                    ),
                  if (!showNormal && !showReplacement && !showKetut && !showRejected)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: const Column(
                        children: [
                          Icon(Icons.search_off, size: 40, color: Color(0xFF94A3B8)),
                          SizedBox(height: 8),
                          Text(
                            'Tidak ada data transaksi yang sesuai filter.',
                            style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Summary Bottom Bar
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
