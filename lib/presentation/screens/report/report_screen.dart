import 'package:flutter/material.dart';
import '../../widgets/common/app_confirmation_dialog.dart';
import '../../widgets/common/center_alert.dart';
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
  String _selectedVillage = 'Banjar Bali, Buleleng';
  String _selectedRegency = 'KAB. BULELENG, BALI';

  void _chooseLocation() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Titik Lokasi Bagi',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih desa / kelurahan penugasan penyaluran beras bantuan.',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            _locationTile(
              'Banjar Bali, Buleleng',
              'KAB. BULELENG, BALI • Kuota 48 KPM (Aktif)',
              isSelected: _selectedVillage.startsWith('Banjar Bali'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _selectedVillage = 'Banjar Bali, Buleleng';
                  _selectedRegency = 'KAB. BULELENG, BALI';
                });
              },
            ),
            _locationTile(
              'Kaliuntu, Buleleng',
              'KAB. BULELENG, BALI • Kuota 62 KPM',
              isSelected: _selectedVillage.startsWith('Kaliuntu'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _selectedVillage = 'Kaliuntu, Buleleng';
                  _selectedRegency = 'KAB. BULELENG, BALI';
                });
              },
            ),
            _locationTile(
              'Temukus, Banjar',
              'KAB. BULELENG, BALI • Kuota 55 KPM',
              isSelected: _selectedVillage.startsWith('Temukus'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _selectedVillage = 'Temukus, Banjar';
                  _selectedRegency = 'KAB. BULELENG, BALI';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationTile(String title, String subtitle, {required bool isSelected, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isSelected ? const Color(0xFFD1FAE5) : const Color(0xFFEFF6FF),
        child: Icon(Icons.location_on, color: isSelected ? const Color(0xFF059669) : const Color(0xFF1E3A8A), size: 18),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 10)),
      trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF059669)) : null,
      onTap: onTap,
    );
  }

  void _handleDownloadReport() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unduh Rekapitulasi Berita Acara (BAST)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih format file laporan rekapitulasi penyaluran beras titik bagi Desa Banjar Bali.',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFEE2E2),
                child: Icon(Icons.picture_as_pdf, color: Color(0xFFDC2626)),
              ),
              title: const Text('Dokumen PDF Resmi (.PDF)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Lengkap dengan tanda tangan, geotag & rekap foto BAST', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                CenterAlert.showSuccess(
                  context,
                  title: 'Data Berhasil Disimpan',
                  message: 'Berkas "REKAP_BAST_BANJAR_BALI_2025.PDF" berhasil diunduh.',
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFDCFCE7),
                child: Icon(Icons.table_chart, color: Color(0xFF16A34A)),
              ),
              title: const Text('Lembar Kerja Excel (.XLSX)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Format spreadsheet tabel data KPM untuk arsip dinas', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                CenterAlert.showSuccess(
                  context,
                  title: 'Data Berhasil Disimpan',
                  message: 'Berkas "REKAP_BAST_BANJAR_BALI_2025.XLSX" berhasil diekspor.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendBroadcastReminder() async {
    final confirmed = await AppConfirmationDialog.show(
      context,
      icon: Icons.notifications_active_rounded,
      iconColor: const Color(0xFFE88B00),
      iconBackgroundColor: const Color(0xFFFEF3C7),
      title: 'Kirim Pengingat ke 5 KPM?',
      message: 'Sistem akan mengirimkan pesan notifikasi WhatsApp/SMS otomatis kepada 5 KPM yang belum mengambil beras bantuan di Balai Desa Banjar Bali.',
      confirmText: 'Kirim Sekarang',
      confirmColor: const Color(0xFFE88B00),
      confirmTextColor: const Color(0xFF0F172A),
      cancelText: 'Batal',
    );

    if (confirmed == true && mounted) {
      CenterAlert.showSuccess(
        context,
        title: 'Pengingat Terkirim',
        message: 'Pesan notifikasi berhasil disebarkan ke 5 warga KPM.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Laporan Distribusi Beras',
        subtitle: 'Realisasi Penyaluran CPP Titik Bagi',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationCard(
                      village: _selectedVillage,
                      regency: _selectedRegency,
                      onTap: _chooseLocation,
                    ),
                    const SizedBox(height: 14),
                    const DonutChart(),
                    const SizedBox(height: 16),
                    KpmPendingList(
                      activeFilter: _activeFilter,
                      onFilterChanged: (val) => setState(() => _activeFilter = val),
                    ),
                    const SizedBox(height: 16),
                    BastDownloadCard(
                      onDownload: _handleDownloadReport,
                    ),
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
                  onPressed: _sendBroadcastReminder,
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
