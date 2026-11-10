import 'package:flutter/material.dart';
import '04_step2_qr_scanner_screen.dart';
import '05_step3_sptjm_replacement_screen.dart';

class Step1DeliveryTypeScreen extends StatefulWidget {
  const Step1DeliveryTypeScreen({super.key});

  @override
  State<Step1DeliveryTypeScreen> createState() => _Step1DeliveryTypeScreenState();
}

class _Step1DeliveryTypeScreenState extends State<Step1DeliveryTypeScreen> {
  // 'NORMAL' | '1KK' | 'BEDAKK' | 'PENGGANTI' | 'KOLEKTIF'
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verifikasi Kpm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Badan Pangan Nasional / Perum BULOG',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
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
                    // Stepper Progress Bar Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'LANGKAH 1 DARI 4',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFD97706),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                'Tahap Identifikasi',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              // Step 1 Active (Orange)
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE88B00),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Step 2 Inactive
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Step 3 Inactive
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Step 4 Inactive
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1. Jenis', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFFD97706))),
                              Text('2. Scan QR', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                              Text('3. Verifikasi', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                              Text('4. Geotag', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Info Alert Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF2563EB), size: 18),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Pastikan fisik KTP/KK asli diperiksa sebelum mengambil dokumentasi foto geotag di tahap akhir.',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E3A8A),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 5 Pilihan Mode Penyerahan
                    _buildOptionCard(
                      id: 'NORMAL',
                      title: 'Normal',
                      badge: 'Paling Sering',
                      icon: Icons.person_add_alt_1_outlined,
                      description: 'PBP menerima bantuan secara langsung. Contoh: PBP hadir langsung dan menerima sendiri beras bantuan dengan membawa KTP asli.',
                    ),
                    const SizedBox(height: 10),

                    _buildOptionCard(
                      id: '1KK',
                      title: 'Perwakilan (1 KK)',
                      icon: Icons.people_outline,
                      description: 'Diterima anggota keluarga dalam SATU KK dengan PBP. Contoh: pasangan (suami/istri) atau anak yang tercatat dalam KK yang sama.',
                    ),
                    const SizedBox(height: 10),

                    _buildOptionCard(
                      id: 'BEDAKK',
                      title: 'Perwakilan (Beda KK)',
                      icon: Icons.badge_outlined,
                      description: 'Diterima orang lain dari BEDA KK dengan PBP. Contoh: tetangga atau kerabat beda KK dengan melampirkan surat kuasa RT/Desa.',
                    ),
                    const SizedBox(height: 10),

                    _buildOptionCard(
                      id: 'PENGGANTI',
                      title: 'Pengganti',
                      icon: Icons.swap_horiz,
                      description: 'Penerima baru menggantikan penerima yang tidak lagi memenuhi kriteria. Contoh: penerima sebelumnya sudah mampu, pindah domisili, ASN/TNI/Polri, atau meninggal dunia.',
                    ),
                    const SizedBox(height: 10),

                    _buildOptionCard(
                      id: 'KOLEKTIF',
                      title: 'Kolektif',
                      icon: Icons.local_shipping_outlined,
                      description: 'Bantuan disalurkan bersama melalui kepala dusun/perwakilan di daerah pelosok/3T yang sudah disetujui resmi oleh BULOG.',
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
                        backgroundColor: const Color(0xFFE88B00), // Solid Amber / Orange
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_selectedOption == 'PENGGANTI') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step3SptjmReplacementScreen()));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step2QrScannerScreen()));
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lanjut ke Scan PBP',
                            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18, color: Colors.black),
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

  Widget _buildOptionCard({
    required String id,
    required String title,
    String? badge,
    required IconData icon,
    required String description,
  }) {
    final bool isSelected = _selectedOption == id;

    return InkWell(
      onTap: () => setState(() => _selectedOption = id),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFBEB) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
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
                    // Radio Button with check
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? const Color(0xFFE88B00) : const Color(0xFFEFF6FF),
                        border: isSelected ? null : Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF047857),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Icon(icon, size: 20, color: const Color(0xFF475569)),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
