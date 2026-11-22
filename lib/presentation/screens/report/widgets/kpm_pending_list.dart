import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../data/models/kpm_model.dart';
import '../../../../data/repositories/bast_repository.dart';
import '../../../widgets/common/app_confirmation_dialog.dart';
import '../../../widgets/common/bast_document_preview_dialog.dart';
import '../../../widgets/common/center_alert.dart';
import '../../camera_geotag/camera_geotag_screen.dart';

class KpmPendingList extends StatelessWidget {
  final int activeFilter;
  final ValueChanged<int> onFilterChanged;

  const KpmPendingList({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  void _showContactDialog(BuildContext context, String name, String phone) {
    HapticFeedback.lightImpact();
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

  void _showDeliveryScheduleDialog(BuildContext context, KpmModel kpm) async {
    HapticFeedback.lightImpact();
    final confirmed = await AppConfirmationDialog.show(
      context,
      icon: Icons.local_shipping_rounded,
      iconColor: const Color(0xFF1E3A8A),
      iconBackgroundColor: const Color(0xFFDBEAFE),
      title: 'Jadwal Antar ke Rumah',
      message: 'Distribusi langsung ke rumah KPM ${kpm.nama} (kategori lansia/sakit) melalui Satgas Desa Banjar Bali.',
      confirmText: 'Tetapkan Jadwal',
      confirmColor: const Color(0xFF1E3A8A),
      confirmTextColor: Colors.white,
      cancelText: 'Tutup',
      customContent: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Row(
          children: [
            Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF1E3A8A)),
            SizedBox(width: 8),
            Text(
              'Hari Ini, 14:00 WITA (Sesi Sore)',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && context.mounted) {
      // Simpan jadwal pengantaran ke database KPM
      BastRepository.instance.updatePbpNote(
        kpm.nik,
        'Jadwal Antar Terkonfirmasi: Hari Ini, 14:00 WITA (Satgas Desa Banjar Bali)',
      );

      CenterAlert.showSuccess(
        context,
        title: 'Jadwal Tersimpan di Database',
        message: 'Pengantaran untuk ${kpm.nama} berhasil dicatat dalam basis data.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: BastRepository.instance,
      builder: (context, _) {
        final repo = BastRepository.instance;
        final allPbp = repo.allPbp;
        final pendingPbp = repo.pendingPbp;
        final deliveredPbp = repo.deliveredPbp;

        final int totalQuota = repo.totalQuota;
        final int distributedCount = repo.distributedCount;
        final int remainingCount = repo.remainingCount;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Penerima Bantuan (PBP)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Data terintegrasi langsung dengan database lapangan',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 11, color: Color(0xFF64748B)),
                      SizedBox(width: 4),
                      Text(
                        '10:24 WITA',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tab Filter Dinamis Terhubung ke Database
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip(
                    'Semua ($totalQuota)',
                    isSelected: activeFilter == 0,
                    onTap: () => onFilterChanged(0),
                  ),
                  const SizedBox(width: 8),
                  _filterChip(
                    'Sisa Belum Diambil ($remainingCount)',
                    isSelected: activeFilter == 1,
                    selectedBg: const Color(0xFFE11D48),
                    onTap: () => onFilterChanged(1),
                  ),
                  const SizedBox(width: 8),
                  _filterChip(
                    'Sudah Diterima ($distributedCount)',
                    isSelected: activeFilter == 2,
                    selectedBg: const Color(0xFF059669),
                    onTap: () => onFilterChanged(2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // KONTEN TAB: SUDAH DITERIMA (2)
            if (activeFilter == 2) ...[
              if (deliveredPbp.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.inventory_2_outlined, color: Color(0xFF94A3B8), size: 36),
                      SizedBox(height: 10),
                      Text(
                        'Belum Ada Beras yang Diserahkan',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Seluruh KPM pada basis data masih berstatus sisa menunggu pengambilan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                )
              else
                ...deliveredPbp.map((kpm) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildKpmCard(
                      context: context,
                      number: '✓',
                      nama: kpm.nama,
                      pbp: kpm.nik.substring(0, 14.clamp(0, kpm.nik.length)),
                      alamat: '${kpm.alamat}, ${kpm.dusun}',
                      accentColor: const Color(0xFF059669),
                      badge: kpm.isSptjm ? 'Sudah Diterima (SPTJM)' : 'Sudah Diterima',
                      badgeColor: const Color(0xFFD1FAE5),
                      badgeTextColor: const Color(0xFF065F46),
                      note: kpm.nomorBast != null ? 'Nomor Dokumen: ${kpm.nomorBast} • ${kpm.waktuSerah ?? "Hari ini"}' : null,
                      actions: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                BastDocumentPreviewDialog.show(
                                  context,
                                  bastNo: kpm.nomorBast ?? 'BAST-${DateTime.now().millisecondsSinceEpoch}',
                                  nama: kpm.nama,
                                  nik: kpm.nik,
                                  noKk: kpm.noKk,
                                  pbpNo: kpm.nik.substring(0, 14.clamp(0, kpm.nik.length)),
                                  waktu: kpm.waktuSerah ?? 'Hari ini, WITA',
                                  jenis: kpm.isSptjm ? 'ALUR PENGGANTI (SPTJM)' : 'PBP NORMAL',
                                  alamat: '${kpm.alamat}, ${kpm.dusun}',
                                );
                              },
                              icon: const Icon(Icons.picture_as_pdf_rounded, size: 15, color: Color(0xFFFDE68A)),
                              label: const Text('Bukti BAST Sah (PDF)', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],

            // KONTEN TAB: SISA BELUM DIAMBIL (1)
            if (activeFilter == 1) ...[
              if (pendingPbp.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 36),
                      SizedBox(height: 10),
                      Text(
                        'Semua Bantuan Berhasil Diserahkan!',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF065F46)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tidak ada sisa KPM tertunggak di titik bagi Desa Banjar Bali.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.5, color: Color(0xFF047857)),
                      ),
                    ],
                  ),
                )
              else
                ...pendingPbp.asMap().entries.map((entry) {
                  final idx = entry.key + 1;
                  final kpm = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildKpmCard(
                      context: context,
                      number: '$idx',
                      nama: kpm.nama,
                      pbp: kpm.nik.substring(0, 14.clamp(0, kpm.nik.length)),
                      alamat: '${kpm.alamat}, ${kpm.dusun}',
                      accentColor: kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFD97706) : const Color(0xFFE11D48),
                      badge: kpm.status == 'PERLU_DIANTAR' ? '[+] Perlu Diantar' : 'Belum Diambil',
                      badgeColor: kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFFEF3C7) : const Color(0xFFFFE4E6),
                      badgeTextColor: kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFB45309) : const Color(0xFFE11D48),
                      note: kpm.note,
                      actions: [
                        if (kpm.status == 'PERLU_DIANTAR') ...[
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFBEB),
                                  side: const BorderSide(color: Color(0xFFFDE68A)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => _showDeliveryScheduleDialog(context, kpm),
                                icon: const Icon(Icons.delivery_dining, size: 16, color: Color(0xFFD97706)),
                                label: const Text('Jadwal Antar', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFFB45309))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ] else ...[
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEFF6FF),
                                  side: const BorderSide(color: Color(0xFFBFDBFE)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => _showContactDialog(context, kpm.nama, kpm.phone),
                                icon: const Icon(Icons.phone_outlined, size: 15, color: Color(0xFF1E3A8A)),
                                label: const Text('Hubungi', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE88B00),
                                foregroundColor: const Color(0xFF0F172A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CameraGeotagScreen(
                                      kpm: kpm,
                                      deliveryType: 'PBP NORMAL',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.inventory_2_outlined, size: 15),
                              label: const Text('Salurkan', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],

            // KONTEN TAB: SEMUA (0)
            if (activeFilter == 0) ...[
              ...allPbp.asMap().entries.map((entry) {
                final idx = entry.key + 1;
                final kpm = entry.value;
                final bool isDone = kpm.isDiserahkan;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildKpmCard(
                    context: context,
                    number: isDone ? '✓' : '$idx',
                    nama: kpm.nama,
                    pbp: kpm.nik.substring(0, 14.clamp(0, kpm.nik.length)),
                    alamat: '${kpm.alamat}, ${kpm.dusun}',
                    accentColor: isDone
                        ? const Color(0xFF059669)
                        : (kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFD97706) : const Color(0xFFE11D48)),
                    badge: isDone
                        ? (kpm.isSptjm ? 'Sudah Diterima (SPTJM)' : 'Sudah Diterima')
                        : (kpm.status == 'PERLU_DIANTAR' ? '[+] Perlu Diantar' : 'Belum Diambil'),
                    badgeColor: isDone
                        ? const Color(0xFFD1FAE5)
                        : (kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFFEF3C7) : const Color(0xFFFFE4E6)),
                    badgeTextColor: isDone
                        ? const Color(0xFF065F46)
                        : (kpm.status == 'PERLU_DIANTAR' ? const Color(0xFFB45309) : const Color(0xFFE11D48)),
                    note: isDone
                        ? (kpm.nomorBast != null ? 'Nomor Dokumen: ${kpm.nomorBast}' : null)
                        : kpm.note,
                    actions: [
                      if (isDone) ...[
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                BastDocumentPreviewDialog.show(
                                  context,
                                  bastNo: kpm.nomorBast ?? 'BAST-${DateTime.now().millisecondsSinceEpoch}',
                                  nama: kpm.nama,
                                  nik: kpm.nik,
                                  noKk: kpm.noKk,
                                  pbpNo: kpm.nik.substring(0, 14.clamp(0, kpm.nik.length)),
                                  waktu: kpm.waktuSerah ?? 'Hari ini, WITA',
                                  jenis: kpm.isSptjm ? 'ALUR PENGGANTI (SPTJM)' : 'PBP NORMAL',
                                  alamat: '${kpm.alamat}, ${kpm.dusun}',
                                );
                              },
                              icon: const Icon(Icons.picture_as_pdf_rounded, size: 15, color: Color(0xFFFDE68A)),
                              label: const Text('Bukti BAST Sah (PDF)', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFFEFF6FF),
                                side: const BorderSide(color: Color(0xFFBFDBFE)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () => _showContactDialog(context, kpm.nama, kpm.phone),
                              icon: const Icon(Icons.phone_outlined, size: 15, color: Color(0xFF1E3A8A)),
                              label: const Text('Hubungi', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE88B00),
                                foregroundColor: const Color(0xFF0F172A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CameraGeotagScreen(
                                      kpm: kpm,
                                      deliveryType: 'PBP NORMAL',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.inventory_2_outlined, size: 15),
                              label: const Text('Salurkan', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          ],
        );
      },
    );
  }

  Widget _filterChip(String label, {required bool isSelected, Color? selectedBg, required VoidCallback onTap}) {
    final effectiveColor = selectedBg ?? const Color(0xFF1E3A8A);
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
        decoration: BoxDecoration(
          color: isSelected ? effectiveColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFCBD5E1),
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: effectiveColor.withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
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
    required Color accentColor,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    String? note,
    required List<Widget> actions,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: accentColor, width: 4.5)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nama,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF0F172A),
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                'PBP: $pbp',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF64748B),
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: badgeTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        alamat,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (note != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 14, color: Color(0xFFD97706)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          note,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF92400E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 12),
              Row(children: actions),
            ],
          ),
        ),
      ),
    );
  }
}
