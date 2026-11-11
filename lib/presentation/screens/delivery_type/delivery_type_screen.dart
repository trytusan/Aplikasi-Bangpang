import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Color get _selectedAccentColor {
    switch (_selectedOption) {
      case 'NORMAL':
        return const Color(0xFFE88B00);
      case '1KK':
        return const Color(0xFF2563EB);
      case 'BEDAKK':
        return const Color(0xFF7C3AED);
      case 'PENGGANTI':
        return const Color(0xFFE11D48);
      case 'KOLEKTIF':
        return const Color(0xFF059669);
      default:
        return const Color(0xFFE88B00);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Pilih Alur Penyerahan',
        subtitle: 'Tahap 1: Identifikasi Penerima Manfaat',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stepper Progres Langkah
                    const StepProgress(
                      currentStep: 1,
                      totalSteps: 4,
                      stageTitle: 'Tahap Identifikasi',
                    ),
                    const SizedBox(height: 14),

                    // Banner Instruksi Petugas
                    const DeliveryInfo(),
                    const SizedBox(height: 16),

                    const Text(
                      'Pilih Metode Serah Terima:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 1. Normal
                    DeliveryOption(
                      id: 'NORMAL',
                      title: 'Normal (PBP Langsung)',
                      badge: 'Paling Sering',
                      badgeColor: const Color(0xFFFEF3C7),
                      badgeTextColor: const Color(0xFFB45309),
                      icon: Icons.how_to_reg_rounded,
                      accentColor: const Color(0xFFE88B00),
                      description: 'PBP hadir langsung dan menerima sendiri beras bantuan 10 Kg.',
                      requirement: 'Syarat: KTP Asli PBP Penerima',
                      isSelected: _selectedOption == 'NORMAL',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    // 2. Perwakilan 1 KK
                    DeliveryOption(
                      id: '1KK',
                      title: 'Perwakilan (1 KK)',
                      badge: 'Keluarga Serumah',
                      badgeColor: const Color(0xFFEFF6FF),
                      badgeTextColor: const Color(0xFF1D4ED8),
                      icon: Icons.family_restroom_rounded,
                      accentColor: const Color(0xFF2563EB),
                      description: 'Diterima oleh pasangan (suami/istri) atau anak yang terdaftar di KK yang sama.',
                      requirement: 'Syarat: KTP Pengambil + KK Asli',
                      isSelected: _selectedOption == '1KK',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    // 3. Perwakilan Beda KK
                    DeliveryOption(
                      id: 'BEDAKK',
                      title: 'Perwakilan (Beda KK)',
                      badge: 'Surat Kuasa',
                      badgeColor: const Color(0xFFF3E8FF),
                      badgeTextColor: const Color(0xFF7E22CE),
                      icon: Icons.badge_rounded,
                      accentColor: const Color(0xFF7C3AED),
                      description: 'Diterima tetangga atau kerabat beda KK karena penerima berhalangan sementara.',
                      requirement: 'Syarat: Surat Kuasa RT/Desa + KTP Pengambil',
                      isSelected: _selectedOption == 'BEDAKK',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    // 4. Pengganti SPTJM
                    DeliveryOption(
                      id: 'PENGGANTI',
                      title: 'Pengganti (SPTJM Desa)',
                      badge: 'Khusus Kendala',
                      badgeColor: const Color(0xFFFFF1F2),
                      badgeTextColor: const Color(0xFFE11D48),
                      icon: Icons.published_with_changes_rounded,
                      accentColor: const Color(0xFFE11D48),
                      description: 'Penggantian penerima yang telah meninggal, pindah domisili, atau mampu.',
                      requirement: 'Syarat: Form SPTJM Resmi & Rekomendasi Desa',
                      isSelected: _selectedOption == 'PENGGANTI',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                    const SizedBox(height: 10),

                    // 5. Kolektif Daerah 3T
                    DeliveryOption(
                      id: 'KOLEKTIF',
                      title: 'Kolektif Daerah 3T',
                      badge: 'Pelosok / Terpencil',
                      badgeColor: const Color(0xFFECFDF5),
                      badgeTextColor: const Color(0xFF047857),
                      icon: Icons.local_shipping_rounded,
                      accentColor: const Color(0xFF059669),
                      description: 'Penyaluran terpusat melalui kepala dusun untuk wilayah yang sulit dijangkau.',
                      requirement: 'Syarat: Berita Acara Kolektif BULOG',
                      isSelected: _selectedOption == 'KOLEKTIF',
                      onSelect: (val) => setState(() => _selectedOption = val),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Jenis Terpilih & Tombol Lanjut
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.touch_app_rounded, size: 16, color: _selectedAccentColor),
                          const SizedBox(width: 6),
                          const Text(
                            'Alur: ',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _selectedLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: const Text(
                          'Siap',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF047857),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE88B00),
                        foregroundColor: const Color(0xFF0F172A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
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
                            _selectedOption == 'PENGGANTI'
                                ? 'Lanjut ke Form SPTJM'
                                : 'Lanjut ke Scan PBP',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 18, color: Color(0xFF0F172A)),
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
