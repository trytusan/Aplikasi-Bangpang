import 'package:flutter/material.dart';
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
              'Unggah Barcode / QR dari Galeri',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih foto undangan fisik atau kartu KPM yang tersimpan di memori perangkat.',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEFF6FF),
                child: Icon(Icons.photo_library, color: Color(0xFF1E3A8A)),
              ),
              title: const Text('Foto Undangan PBP (QR.jpg)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              subtitle: const Text('Terdeteksi: No. PBP 51080610270001', style: TextStyle(fontSize: 10)),
              onTap: () {
                Navigator.pop(ctx);
                CenterAlert.showSuccess(
                  context,
                  title: 'QR KPM Terverifikasi',
                  message: 'I Made Sukadana (51080610270001) terdaftar sebagai penerima bantuan.',
                );
              },
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
                    QrTabSwitcher(
                      activeTab: _activeTab,
                      onTabChanged: (val) => setState(() => _activeTab = val),
                    ),
                    const SizedBox(height: 12),

                    if (_activeTab == 0) ...[
                      const CameraViewfinder(),
                      const SizedBox(height: 12),

                      // Controls: Flash & Unggah Galeri
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() => _flashOn = !_flashOn);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(_flashOn ? 'Lampu Flash Aktif' : 'Lampu Flash Dimatikan'),
                                    duration: const Duration(milliseconds: 900),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE88B00),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(_flashOn ? Icons.flashlight_on : Icons.flashlight_off, color: Colors.black, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      _flashOn ? 'Flash Nyala' : 'Flash Mati',
                                      style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: _handleUploadGallery,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_outlined, color: Color(0xFF1E3A8A), size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Unggah Galeri',
                                      style: TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Tampilan Form Input Manual No. PBP
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.keyboard_outlined, size: 18, color: Color(0xFF1E3A8A)),
                                SizedBox(width: 8),
                                Text(
                                  'Input Manual Nomor PBP / NIK',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Gunakan jika barcode pada undangan basah atau rusak.',
                              style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _manualPbpController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.numbers, size: 20, color: Color(0xFF64748B)),
                                hintText: 'Masukkan 14 digit No. PBP atau 16 digit NIK',
                                hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                                filled: true,
                                fillColor: const Color(0xFFF8FAFC),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFE88B00), width: 1.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E3A8A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  CenterAlert.showSuccess(
                                    context,
                                    title: 'Data PBP Ditemukan',
                                    message: 'No. PBP ${_manualPbpController.text} cocok dengan basis data Bapanas.',
                                  );
                                },
                                icon: const Icon(Icons.search, size: 16),
                                label: const Text('Cari & Verifikasi KPM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),

                    const KpmVerified(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons (Scan Ulang & Gunakan Hasil Scan)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEEF2FF),
                          foregroundColor: const Color(0xFF1E3A8A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          CenterAlert.showInfo(
                            context,
                            title: 'Sensor Direset',
                            message: 'Pemindai kamera siap membaca kode QR baru.',
                          );
                        },
                        child: const Text('Scan Ulang', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE88B00),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CameraGeotagScreen()),
                          );
                        },
                        icon: const Icon(Icons.check, size: 16, color: Colors.black),
                        label: const Text(
                          'Gunakan Hasil Scan',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black),
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
