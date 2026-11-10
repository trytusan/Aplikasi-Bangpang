import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../qr_scanner/qr_scanner_screen.dart';
import '../replacement/replacement_screen.dart';
import 'widgets/delivery_info.dart';
import 'widgets/delivery_option.dart';
import 'widgets/step_progress.dart';

class DeliveryTypeScreen extends StatefulWidget {
  const DeliveryTypeScreen({super.key});

  @override
  State<DeliveryTypeScreen> createState() => _DeliveryTypeScreenState();
}

class _DeliveryTypeScreenState extends State<DeliveryTypeScreen> {
  String _selectedOption = 'NORMAL';

  String get _selectedLabel {
    switch (_selectedOption) {
      case 'NORMAL':
        return 'Normal (PBP Langsung)';
      case '1KK':
        return 'Perwakilan (1 KK)';
      case 'BEDAKK':
        return 'Perwakilan (Beda KK)';
      case 'PENGGANTI':
        return 'Pengganti SPTJM';
      case 'KOLEKTIF':
        return 'Kolektif Daerah 3T';
      default:
        return 'Normal (PBP Langsung)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StepProgress(
                      currentStep: 1,
                      totalSteps: 4,
                      stageTitle: 'Tahap Identifikasi',
                    ),
                    const SizedBox(height: 12),
                    const DeliveryInfo(),
                    const SizedBox(height: 14),

                    // 5 Pilihan Mode Penyerahan
                    DeliveryOption(
                      id: 'NORMAL',
                      title: 'Normal',
                      badge: 'Paling Sering',
                      icon: Icons.person_add_alt_1_outlined,
                      description: 'PBP menerima bantuan secara langsung. Contoh: PBP hadir langsung dan menerima sendiri beras bantuan dengan membawa KTP asli.',
                      isSelected: _selectedOption == 'NORMAL',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    DeliveryOption(
                      id: '1KK',
                      title: 'Perwakilan (1 KK)',
                      icon: Icons.people_outline,
                      description: 'Diterima anggota keluarga dalam SATU KK dengan PBP. Contoh: pasangan (suami/istri) atau anak yang tercatat dalam KK yang sama.',
                      isSelected: _selectedOption == '1KK',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    DeliveryOption(
                      id: 'BEDAKK',
                      title: 'Perwakilan (Beda KK)',
                      icon: Icons.badge_outlined,
                      description: 'Diterima orang lain dari BEDA KK dengan PBP. Contoh: tetangga atau kerabat beda KK dengan melampirkan surat kuasa RT/Desa.',
                      isSelected: _selectedOption == 'BEDAKK',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    DeliveryOption(
                      id: 'PENGGANTI',
                      title: 'Pengganti',
                      icon: Icons.swap_horiz,
                      description: 'Penerima baru menggantikan penerima yang tidak lagi memenuhi kriteria. Contoh: penerima sebelumnya sudah mampu, pindah domisili, ASN/TNI/Polri, atau meninggal dunia.',
                      isSelected: _selectedOption == 'PENGGANTI',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    DeliveryOption(
                      id: 'KOLEKTIF',
                      title: 'Kolektif',
                      icon: Icons.local_shipping_outlined,
                      description: 'Bantuan disalurkan bersama melalui kepala dusun/perwakilan di daerah pelosok/3T yang sudah disetujui resmi oleh BULOG.',
                      isSelected: _selectedOption == 'KOLEKTIF',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Jenis Terpilih & Tombol Lanjut
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.touch_app_outlined, size: 16, color: Color(0xFFB45309)),
                          const SizedBox(width: 6),
                          RichText(
                            text: TextSpan(
                              text: 'Jenis Terpilih: ',
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: _selectedLabel,
                                  style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8FDF3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Siap',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE88B00),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_selectedOption == 'PENGGANTI') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ReplacementScreen()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const QrScannerScreen()),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedOption == 'PENGGANTI' ? 'Lanjut ke Form SPTJM' : 'Lanjut ke Scan PBP',
                            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
                        ],
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
