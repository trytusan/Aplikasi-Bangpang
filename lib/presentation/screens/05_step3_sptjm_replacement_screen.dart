import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '06_step4_camera_geotag_screen.dart';

class Step3SptjmReplacementScreen extends StatefulWidget {
  const Step3SptjmReplacementScreen({super.key});

  @override
  State<Step3SptjmReplacementScreen> createState() => _Step3SptjmReplacementScreenState();
}

class _Step3SptjmReplacementScreenState extends State<Step3SptjmReplacementScreen> {
  String _selectedReason = 'MENINGGAL';
  final _namaPenggantiController = TextEditingController(text: 'NI LUH SARIASIH');
  final _nikPenggantiController = TextEditingController(text: '5108055509820001');
  final _hubunganController = TextEditingController(text: 'Anak Kandung (Satu Kartu Keluarga)');
  bool _sptjmAgreed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulir Legalitas SPTJM', style: TextStyle(fontSize: 10, color: AppColors.primaryAmber, fontWeight: FontWeight.w700)),
            Text('Penerima Kuasa / Pengganti', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Alasan Penggantian
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('ALASAN PENGGANTIAN KPM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: _selectedReason,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMain),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderLight)),
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'MENINGGAL', child: Text('KPM Meninggal Dunia (Ahli Waris)')),
                                  DropdownMenuItem(value: 'PINDAH', child: Text('Pindah Domisili ke Luar Wilayah')),
                                  DropdownMenuItem(value: 'SAKIT', child: Text('Sakit Keras / Lansia Tirah Baring')),
                                  DropdownMenuItem(value: 'GRADUASI', child: Text('Sudah Mampu / Mengundurkan Diri')),
                                ],
                                onChanged: (val) => setState(() => _selectedReason = val!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Identitas Pengganti
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('DATA PENERIMA KUASA / PENGGANTI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.navyPrimary)),
                              const SizedBox(height: 10),
                              const Text('NAMA LENGKAP PENGGANTI', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSubtle)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _namaPenggantiController,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderLight)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('NIK PENGGANTI (16 DIGIT)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSubtle)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _nikPenggantiController,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace'),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderLight)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('HUBUNGAN KELUARGA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSubtle)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _hubunganController,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderLight)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lampiran SPTJM
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAmber.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primaryAmberDark, style: BorderStyle.solid),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.document_scanner_outlined, color: AppColors.primaryAmberDark, size: 28),
                            const SizedBox(height: 6),
                            const Text('Foto Berkas SPTJM Kepala Desa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                            const Text('Wajib bertandatangan Lurah & cap basah', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.successGreenLight, borderRadius: BorderRadius.circular(8)),
                              child: const Text('✓ SPTJM-018-BANJARBALI.jpg Terlampir', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.successGreen)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _sptjmAgreed,
                            activeColor: AppColors.primaryAmberDark,
                            onChanged: (val) => setState(() => _sptjmAgreed = val ?? false),
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Menyatakan data pengganti sah dan dapat dipertanggungjawabkan sesuai hukum.',
                                style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const Step4CameraGeotagScreen()));
                },
                child: const Text('SIMPAN SPTJM & BUKA KAMERA GEOTAG'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
