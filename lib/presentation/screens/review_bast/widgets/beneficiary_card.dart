import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signature_pad_dialog.dart';

class BeneficiaryCard extends StatelessWidget {
  final String nama;
  final String nik;
  final String noKk;
  final String alamat;
  final String jenis;
  final bool isPengganti;
  final String? replacedName;
  final String ricePhotoUrl;
  final String sptjmPhotoUrl;
  final List<Offset?>? signaturePoints;
  final VoidCallback? onTapSignature;
  final VoidCallback? onTapRicePhoto;
  final VoidCallback? onTapSptjmPhoto;

  const BeneficiaryCard({
    super.key,
    this.nama = 'LUH SUMANTRI ARYANI',
    this.nik = '5108065209840002',
    this.noKk = '5108061204090011',
    this.alamat = 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali, Buleleng, Bali',
    this.jenis = 'PBP NORMAL',
    this.isPengganti = false,
    this.replacedName,
    this.ricePhotoUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200',
    this.sptjmPhotoUrl = 'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=200',
    this.signaturePoints,
    this.onTapSignature,
    this.onTapRicePhoto,
    this.onTapSptjmPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSignature = signaturePoints != null && signaturePoints!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Judul & Status Kemendagri
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.badge_rounded, size: 20, color: Color(0xFF1E3A8A)),
                  SizedBox(width: 8),
                  Text(
                    'Data Penerima Manfaat',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF059669)),
                    SizedBox(width: 4),
                    Text(
                      'Kemendagri Valid',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF047857),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Profil Penerima
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  image: DecorationImage(
                    image: NetworkImage(ricePhotoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: isPengganti ? const Color(0xFFFEF3C7) : const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isPengganti ? 'KPM Pengganti Sah' : 'PBP Terverifikasi',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: isPengganti ? const Color(0xFFB45309) : const Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                        Text(
                          'NIK: $nik',
                          style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF475569), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Grid KK & (jika pengganti) KPM Sebelumnya
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nomor Kartu Keluarga', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 3),
                      Text(noKk, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, fontFamily: 'monospace', color: Color(0xFF0F172A))),
                    ],
                  ),
                ),
              ),
              if (isPengganti) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFECDD3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('KPM Sebelumnya (Diganti)', style: TextStyle(fontSize: 9.5, color: Color(0xFF9F1239), fontWeight: FontWeight.w600)),
                        const SizedBox(height: 3),
                        Text(replacedName ?? 'I GEDE SUARDIKA', style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                        const Text('(Meninggal Dunia)', style: TextStyle(fontSize: 9.5, color: Color(0xFFBE123C))),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          // Alokasi Bantuan Pangan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE88B00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ALOKASI BANTUAN PANGAN', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF92400E))),
                      SizedBox(height: 1),
                      Text('Beras Medium CPP 10 Kg', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '1 Karung',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Alamat Domisili KPM
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_rounded, size: 16, color: Color(0xFFE88B00)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Alamat Domisili KPM', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(
                        alamat,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A), height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 3 Lampiran Bukti Penyerahan
          const Row(
            children: [
              Text(
                'LAMPIRAN BUKTI PENYERAHAN',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.3),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Lampiran 1: Fisik Beras
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTapRicePhoto?.call();
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      image: DecorationImage(
                        image: NetworkImage(ricePhotoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: const Text('Fisik Beras', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Lampiran 2: Fisik KTP / SPTJM
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTapSptjmPhoto?.call();
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      image: DecorationImage(
                        image: NetworkImage(sptjmPhotoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        isPengganti ? 'Surat SPTJM' : 'Foto KTP / KK',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Lampiran 3: Tanda Tangan Digital
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTapSignature?.call();
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: hasSignature ? const Color(0xFFF0FDF4) : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasSignature ? const Color(0xFF86EFAC) : const Color(0xFFBFDBFE),
                        width: 1.2,
                      ),
                    ),
                    child: hasSignature
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 6, 6, 22),
                                    child: CustomPaint(
                                      painter: SignaturePainter(
                                        points: signaturePoints!,
                                        fit: true,
                                        strokeWidth: 2.4,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF059669),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      '✓ TTD Sah',
                                      style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.draw_rounded, size: 20, color: Color(0xFF2563EB)),
                              SizedBox(height: 4),
                              Text(
                                'Tanda Tangan\n(Klik di Sini)',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A), height: 1.2),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
