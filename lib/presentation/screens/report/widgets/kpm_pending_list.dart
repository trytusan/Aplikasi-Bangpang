import 'package:flutter/material.dart';
import '../../delivery_type/delivery_type_screen.dart';
import '../../replacement/replacement_screen.dart';

class KpmPendingList extends StatelessWidget {
  final int activeFilter;
  final ValueChanged<int> onFilterChanged;

  const KpmPendingList({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daftar Penerima Bantuan\n(PBP)',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
            ),
            Text('Update 10:24\nWITA', textAlign: TextAlign.right, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
          ],
        ),
        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _filterChip('Semua (48)', isSelected: activeFilter == 0, onTap: () => onFilterChanged(0)),
              const SizedBox(width: 8),
              _filterChip(
                '• Sisa Belum Diambil (5)',
                isSelected: activeFilter == 1,
                selectedBg: const Color(0xFF991B1B),
                onTap: () => onFilterChanged(1),
              ),
              const SizedBox(width: 8),
              _filterChip('Sudah Diterima', isSelected: activeFilter == 2, onTap: () => onFilterChanged(2)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // KPM 1
        _buildKpmCard(
          context: context,
          number: '1',
          nama: 'I KETUT WIDIA',
          pbp: '510806102700021',
          alamat: 'Banjar Dinas Bale Agung, RT 01',
          badge: 'Belum Diambil',
          badgeColor: const Color(0xFFFFE4E6),
          badgeTextColor: const Color(0xFFE11D48),
          actions: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                icon: const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF1E3A8A)),
                label: const Text('Hubungi', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryTypeScreen())),
                icon: const Icon(Icons.inventory_2_outlined, size: 14),
                label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // KPM 2
        _buildKpmCard(
          context: context,
          number: '2',
          nama: 'NI MADE WARTI',
          pbp: '510806200500008',
          alamat: 'Banjar Dinas Bale Agung, RT 02',
          badge: '[+] Keluarga Sakit',
          badgeColor: const Color(0xFFFEF3C7),
          badgeTextColor: const Color(0xFFB45309),
          note: 'Perlu distribusi kolektif / diantar ke rumah melalui satgas desa.',
          actions: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                icon: const Icon(Icons.delivery_dining, size: 16),
                label: const Text('Jadwal Antar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // KPM 3
        _buildKpmCard(
          context: context,
          number: '3',
          nama: 'KOMANG ARYA',
          pbp: '510806102700095',
          alamat: 'Banjar Bali, RT 03',
          badge: 'Alamat Tdk Ditemukan',
          badgeColor: const Color(0xFFFFE4E6),
          badgeTextColor: const Color(0xFFE11D48),
          actions: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReplacementScreen())),
                icon: const Icon(Icons.block, size: 14, color: Color(0xFFE11D48)),
                label: const Text('Ajukan Pengganti SPTJM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // KPM 4
        _buildKpmCard(
          context: context,
          number: '4',
          nama: 'DESAK PUTU SUCI',
          pbp: '510806200500112',
          alamat: 'Banjar Bali, RT 02',
          badge: 'Belum Diambil',
          badgeColor: const Color(0xFFFFE4E6),
          badgeTextColor: const Color(0xFFE11D48),
          actions: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                icon: const Icon(Icons.campaign_outlined, size: 14, color: Color(0xFF1E3A8A)),
                label: const Text('Panggil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryTypeScreen())),
                icon: const Icon(Icons.inventory_2_outlined, size: 14),
                label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // KPM 5
        _buildKpmCard(
          context: context,
          number: '5',
          nama: 'WAYAN GEDE SUKA',
          pbp: '510806102700140',
          alamat: 'Banjar Bali, RT 04',
          badge: 'Belum Diambil',
          badgeColor: const Color(0xFFFFE4E6),
          badgeTextColor: const Color(0xFFE11D48),
          actions: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                icon: const Icon(Icons.campaign_outlined, size: 14, color: Color(0xFF1E3A8A)),
                label: const Text('Panggil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE88B00), foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryTypeScreen())),
                icon: const Icon(Icons.inventory_2_outlined, size: 14),
                label: const Text('Salurkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _filterChip(String label, {required bool isSelected, Color? selectedBg, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? (selectedBg ?? const Color(0xFF0F172A)) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildKpmCard({
    required BuildContext context,
    required String number,
    required String nama,
    required String pbp,
    required String alamat,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    String? note,
    required List<Widget> actions,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(6)),
                    child: Center(child: Text(number, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)))),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      Text('PBP: $pbp', style: const TextStyle(fontSize: 8.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(6)),
                child: Text(badge, style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: badgeTextColor)),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 11, color: Color(0xFF64748B)),
                const SizedBox(width: 4),
                Text(alamat, style: const TextStyle(fontSize: 9.5, color: Color(0xFF475569))),
              ],
            ),
          ),

          if (note != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 12, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(note, style: const TextStyle(fontSize: 9, color: Color(0xFFB45309), height: 1.25)),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 8),
          Row(children: actions),
        ],
      ),
    );
  }
}
