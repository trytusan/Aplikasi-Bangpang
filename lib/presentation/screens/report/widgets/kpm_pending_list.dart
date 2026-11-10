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

  void _showContactDialog(BuildContext context, String name, String phone) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone_in_talk, color: Color(0xFF1E3A8A), size: 20),
                const SizedBox(width: 8),
                Text('Hubungi $name', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 6),
            Text('Nomor kontak terdaftar di Dukcapil: $phone', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFDCFCE7),
                child: Icon(Icons.chat, color: Color(0xFF16A34A)),
              ),
              title: const Text('Kirim Pesan WhatsApp', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Kirimkan pengingat lokasi & jam pengambilan beras', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Membuka WhatsApp ke $name ($phone)...'), backgroundColor: const Color(0xFF059669)),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEFF6FF),
                child: Icon(Icons.phone, color: Color(0xFF2563EB)),
              ),
              title: const Text('Panggilan Suara Langsung', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Hubungi nomor telepon seluler warga', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menghubungi telepon seluler $name...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeliveryScheduleDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Jadwal Antar ke Rumah: $name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distribusi khusus untuk KPM sakit/lansia melalui Satgas Desa Banjar Bali.',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Color(0xFF1E3A8A)),
                  SizedBox(width: 8),
                  Text('Hari Ini, 14:00 WITA (Sesi Sore)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✓ Jadwal pengantaran untuk $name berhasil dikonfirmasi ke Satgas!'),
                  backgroundColor: const Color(0xFF059669),
                ),
              );
            },
            child: const Text('Tetapkan Jadwal Antar'),
          ),
        ],
      ),
    );
  }

  void _callQueue(BuildContext context, String number, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.volume_up, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text('Memanggil Antrean Nomor $number: $name ke meja verifikasi BAST.')),
          ],
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
              _filterChip('Sudah Diterima (43)', isSelected: activeFilter == 2, onTap: () => onFilterChanged(2)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Jika Tab "Sudah Diterima" (2)
        if (activeFilter == 2) ...[
          _buildKpmCard(
            context: context,
            number: '✓',
            nama: 'JRO NYOMAN SETIASIH',
            pbp: '510806102700001',
            alamat: 'Banjar Dinas Bale Agung, RT 01',
            badge: 'Sudah Diterima',
            badgeColor: const Color(0xFFD1FAE5),
            badgeTextColor: const Color(0xFF065F46),
            actions: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('BAST: BAST-2026095108062005 (10 kg Beras CBP Diserahkan)')),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF059669)),
                  label: const Text('Bukti BAST Sah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildKpmCard(
            context: context,
            number: '✓',
            nama: 'LUH SUMANTRI ARYANI',
            pbp: '5108062005000024',
            alamat: 'Banjar Dinas Bale Agung, RT 02',
            badge: 'Sudah Diterima (SPTJM)',
            badgeColor: const Color(0xFFD1FAE5),
            badgeTextColor: const Color(0xFF065F46),
            actions: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFF6FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('BAST: BAST-2026095108062006 (Pengganti Sah)')),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF059669)),
                  label: const Text('Bukti BAST Sah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                ),
              ),
            ],
          ),
        ],

        // Jika Tab "Semua" (0) atau "Sisa Belum Diambil" (1)
        if (activeFilter == 0 || activeFilter == 1) ...[
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
                  onPressed: () => _showContactDialog(context, 'I KETUT WIDIA', '0812-3456-7890'),
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
                  onPressed: () => _showDeliveryScheduleDialog(context, 'NI MADE WARTI'),
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
                  style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEEF2FF), side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ReplacementScreen()));
                  },
                  icon: const Icon(Icons.cancel_outlined, size: 14, color: Color(0xFFE11D48)),
                  label: const Text('Ajukan Pengganti SPTJM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFE11D48))),
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
                  onPressed: () => _callQueue(context, '4', 'DESAK PUTU SUCI'),
                  icon: const Icon(Icons.campaign_outlined, size: 16, color: Color(0xFF1E3A8A)),
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
                  onPressed: () => _callQueue(context, '5', 'WAYAN GEDE SUKA'),
                  icon: const Icon(Icons.campaign_outlined, size: 16, color: Color(0xFF1E3A8A)),
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
      ],
    );
  }

  Widget _filterChip(String label, {required bool isSelected, Color? selectedBg, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? (selectedBg ?? const Color(0xFF1E3A8A)) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : const Color(0xFF64748B)),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 11,
                    backgroundColor: const Color(0xFFEFF6FF),
                    child: Text(number, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      Text('PBP: $pbp', style: const TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontFamily: 'monospace')),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(6)),
                child: Text(badge, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: badgeTextColor)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF64748B)),
                const SizedBox(width: 4),
                Expanded(child: Text(alamat, style: const TextStyle(fontSize: 9.5, color: Color(0xFF64748B)))),
              ],
            ),
          ),

          if (note != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 12, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Expanded(child: Text(note, style: const TextStyle(fontSize: 9.5, color: Color(0xFF92400E)))),
                ],
              ),
            ),
          ],

          const SizedBox(height: 10),
          Row(children: actions),
        ],
      ),
    );
  }
}
