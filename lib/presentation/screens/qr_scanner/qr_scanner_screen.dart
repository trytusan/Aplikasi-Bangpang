import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/common/center_alert.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../camera_geotag/camera_geotag_screen.dart';
import 'widgets/camera_viewfinder.dart';
import 'widgets/kpm_verified.dart';
import 'widgets/qr_tab_switcher.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  int _activeTab = 0;
  bool _flashOn = true;
  final TextEditingController _manualPbpController = TextEditingController(text: '51080610270001');

  @override
  void dispose() {
    _manualPbpController.dispose();
    super.dispose();
  }

  void _handleUploadGallery() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Color(0xFF1E3A8A), size: 20),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih Berkas QR Undangan',
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                    ),
                    Text(
                      'Ambil dari memori perangkat lokal',
                      style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pop(ctx);
                CenterAlert.showSuccess(
                  context,
                  title: 'QR KPM Terverifikasi',
                  message: 'I Made Sukadana (51080610270001) terdaftar sebagai penerima bantuan.',
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.qr_code_2_rounded, color: Color(0xFF1E3A8A), size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Foto Undangan PBP (QR_01.jpg)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A))),
                          SizedBox(height: 2),
                          Text('Terdeteksi: No. PBP 51080610270001', style: TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Pindai Undangan PBP',
        subtitle: 'Tahap 2: Pemindaian QR & Barcode KPM',
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
                    // Tab Switcher Scan vs Input Manual
                    QrTabSwitcher(
                      activeTab: _activeTab,
                      onTabChanged: (val) => setState(() => _activeTab = val),
                    ),
                    const SizedBox(height: 12),

                    if (_activeTab == 0) ...[
                      // Kamera Viewfinder Interaktif
                      const CameraViewfinder(),
                      const SizedBox(height: 12),

                      // Controls: Flash & Unggah Galeri (Proporsional & Seimbang)
                      Row(
                        children: [
                          // Tombol Flash
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() => _flashOn = !_flashOn);
                                CenterAlert.show(
                                  context,
                                  title: _flashOn ? 'Lampu Flash Aktif' : 'Lampu Flash Mati',
                                  message: _flashOn ? 'Pencahayaan kamera diaktifkan.' : 'Pencahayaan dinonaktifkan.',
                                  type: CenterAlertType.info,
                                  duration: const Duration(milliseconds: 1000),
                                );
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 44,
                                decoration: BoxDecoration(
                                  color: _flashOn ? const Color(0xFFFEF3C7) : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: _flashOn ? const Color(0xFFFDE68A) : const Color(0xFFE2E8F0),
                                    width: _flashOn ? 1.5 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _flashOn
                                          ? const Color(0xFFE88B00).withValues(alpha: 0.15)
                                          : Colors.black.withValues(alpha: 0.02),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _flashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                                      color: _flashOn ? const Color(0xFFB45309) : const Color(0xFF64748B),
                                      size: 19,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _flashOn ? 'Flash Nyala' : 'Flash Mati',
                                      style: TextStyle(
                                        color: _flashOn ? const Color(0xFF78350F) : const Color(0xFF475569),
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Tombol Galeri
                          Expanded(
                            child: InkWell(
                              onTap: _handleUploadGallery,
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFBFDBFE)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2563EB).withValues(alpha: 0.08),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo_library_rounded, color: Color(0xFF1E3A8A), size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Unggah Galeri',
                                      style: TextStyle(
                                        color: Color(0xFF1E3A8A),
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Form Input Manual No. PBP / NIK
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.keyboard_alt_rounded, size: 20, color: Color(0xFF1E3A8A)),
                                SizedBox(width: 8),
                                Text(
                                  'Input Manual Nomor PBP / NIK',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Gunakan opsi ini jika QR code pada undangan basah, robek, atau kusam.',
                              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              controller: _manualPbpController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.numbers_rounded, size: 20, color: Color(0xFF1E3A8A)),
                                hintText: 'Masukkan 14 digit No. PBP atau 16 digit NIK',
                                hintStyle: const TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                                filled: true,
                                fillColor: const Color(0xFFF8FAFC),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Color(0xFFE88B00), width: 1.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E3A8A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  CenterAlert.showSuccess(
                                    context,
                                    title: 'Data PBP Ditemukan',
                                    message: 'No. PBP ${_manualPbpController.text} cocok dengan basis data Bapanas.',
                                  );
                                },
                                icon: const Icon(Icons.search_rounded, size: 18),
                                label: const Text('Cari & Verifikasi KPM', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),

                    // Kartu Hasil Verifikasi KPM
                    const KpmVerified(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons (Scan Ulang & Gunakan Hasil Scan)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
                border: const Border(
                  top: BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
                ),
              ),
              child: Row(
                children: [
                  // Tombol Scan Ulang
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF8FAFC),
                          foregroundColor: const Color(0xFF475569),
                          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          CenterAlert.showInfo(
                            context,
                            title: 'Sensor Direset',
                            message: 'Pemindai kamera siap membaca kode QR baru.',
                          );
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 18, color: Color(0xFF64748B)),
                        label: const Text('Scan Ulang', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Tombol Gunakan Hasil Scan
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE88B00),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CameraGeotagScreen()),
                          );
                        },
                        icon: const Icon(Icons.check_circle_rounded, size: 18, color: Color(0xFF0F172A)),
                        label: const Text(
                          'Gunakan Hasil Scan',
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
