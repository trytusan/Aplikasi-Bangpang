import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/kpm_model.dart';
import '../../widgets/common/bottom_action_bar.dart';
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
  final GlobalKey<CameraViewfinderState> _viewfinderKey = GlobalKey<CameraViewfinderState>();
  int _activeTab = 0;
  bool _flashOn = false;
  final TextEditingController _manualPbpController = TextEditingController(text: '5108051205780004');

  late List<KpmModel> _availableKpmList;
  late KpmModel _selectedKpm;
  int _scanIndex = 0;

  @override
  void initState() {
    super.initState();
    _availableKpmList = KpmModel.sampleData;
    _selectedKpm = _availableKpmList[0];
  }

  @override
  void dispose() {
    _manualPbpController.dispose();
    super.dispose();
  }

  void _handleScannedCode(String rawCode) {
    final query = rawCode.trim();
    if (query.isEmpty) return;

    // Cari kecocokan di basis data KPM
    KpmModel? match;
    for (final k in _availableKpmList) {
      if (k.nik == query ||
          query.contains(k.nik) ||
          k.noKk == query ||
          query.contains(k.noKk) ||
          k.nama.toLowerCase() == query.toLowerCase()) {
        match = k;
        break;
      }
    }

    // Jika kode QR fisik baru yang tidak ada di sampel, parsing NIK / buat KPM dinamis
    if (match == null) {
      final digits = query.replaceAll(RegExp(r'\D'), '');
      final formattedNik = digits.length >= 16
          ? digits.substring(0, 16)
          : (digits.isNotEmpty ? digits.padRight(16, '0') : '5108051205780099');

      match = KpmModel(
        nik: formattedNik,
        noKk: '5108051901080033',
        nama: 'KPM FISIK ($formattedNik)',
        alamat: 'Banjar Dinas Bale Agung, RT 01',
        dusun: 'Desa Banjar Bali',
      );
    }

    _triggerScanSuccess(match);
  }

  void _triggerScanSuccess([KpmModel? specificKpm]) {
    HapticFeedback.heavyImpact();
    setState(() {
      if (specificKpm != null) {
        _selectedKpm = specificKpm;
      } else {
        _scanIndex = (_scanIndex + 1) % _availableKpmList.length;
        _selectedKpm = _availableKpmList[_scanIndex];
      }
      _manualPbpController.text = _selectedKpm.nik;
    });

    CenterAlert.showSuccess(
      context,
      title: 'QR KPM Terverifikasi',
      message: '${_selectedKpm.nama} (${_selectedKpm.nik}) terdaftar sebagai penerima bantuan 10 Kg.',
    );
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
            ..._availableKpmList.take(3).map((kpm) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    _triggerScanSuccess(kpm);
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kpm.nama, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A))),
                              const SizedBox(height: 2),
                              Text('NIK: ${kpm.nik} • ${kpm.dusun}', style: const TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 20),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _handleManualSearch() {
    final query = _manualPbpController.text.trim();
    if (query.isEmpty) {
      CenterAlert.showWarning(context, title: 'Nomor Kosong', message: 'Masukkan nomor PBP atau NIK KPM terlebih dahulu.');
      return;
    }

    final match = _availableKpmList.firstWhere(
      (k) => k.nik.contains(query) || k.noKk.contains(query) || k.nama.toLowerCase().contains(query.toLowerCase()),
      orElse: () => KpmModel(
        nik: query.length >= 16 ? query : '${query}0000000000000000'.substring(0, 16),
        noKk: '5108051901080033',
        nama: 'KPM HASIL INPUT MANUAL',
        alamat: 'RT 01 / RW 01',
        dusun: 'Desa Banjar Bali',
      ),
    );

    _triggerScanSuccess(match);
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
                      // Kamera Viewfinder Hardware Asli (Real Camera Stream)
                      CameraViewfinder(
                        key: _viewfinderKey,
                        onScanTriggered: () => _triggerScanSuccess(),
                        onCodeScanned: _handleScannedCode,
                      ),
                      const SizedBox(height: 12),

                      // Controls: Flash & Unggah Galeri
                      Row(
                        children: [
                          // Tombol Flash
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                _viewfinderKey.currentState?.toggleTorch();
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
                                onPressed: _handleManualSearch,
                                icon: const Icon(Icons.search_rounded, size: 18),
                                label: const Text('Cari & Verifikasi KPM', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),

                    // Kartu Hasil Verifikasi KPM Interaktif
                    KpmVerified(kpm: _selectedKpm),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BanpangBottomActionBar(
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
                    _triggerScanSuccess();
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 18, color: Color(0xFF64748B)),
                  label: const Text('Scan Acak', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
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
                      MaterialPageRoute(
                        builder: (_) => CameraGeotagScreen(
                          kpm: _selectedKpm,
                        ),
                      ),
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
    );
  }
}
