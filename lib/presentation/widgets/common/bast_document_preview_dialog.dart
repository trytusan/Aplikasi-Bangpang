import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'banpang_image.dart';
import 'center_alert.dart';

class BastDocumentPreviewDialog extends StatelessWidget {
  final String bastNo;
  final String nama;
  final String nik;
  final String noKk;
  final String pbpNo;
  final String waktu;
  final String jenis;
  final String alamat;
  final String imageUrl;
  final List<Offset?>? signaturePoints;

  const BastDocumentPreviewDialog({
    super.key,
    required this.bastNo,
    required this.nama,
    required this.nik,
    this.noKk = '5108061204090011',
    required this.pbpNo,
    required this.waktu,
    required this.jenis,
    this.alamat = 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali, Kec. Buleleng',
    this.imageUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600',
    this.signaturePoints,
  });

  static Future<void> show(
    BuildContext context, {
    required String bastNo,
    required String nama,
    required String nik,
    String noKk = '5108061204090011',
    required String pbpNo,
    required String waktu,
    required String jenis,
    String alamat = 'Banjar Dinas Bale Agung, RT 02 / RW 01, Banjar Bali, Kec. Buleleng',
    String imageUrl = 'https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=600',
    List<Offset?>? signaturePoints,
  }) {
    HapticFeedback.mediumImpact();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => BastDocumentPreviewDialog(
        bastNo: bastNo,
        nama: nama,
        nik: nik,
        noKk: noKk,
        pbpNo: pbpNo,
        waktu: waktu,
        jenis: jenis,
        alamat: alamat,
        imageUrl: imageUrl,
        signaturePoints: signaturePoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Bar Modal
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE88B00).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFE88B00), size: 18),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pratinjau Dokumen Resmi BAST',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      Text(
                        'Format Standar Berita Acara BAPANAS / Perum BULOG',
                        style: TextStyle(fontSize: 9.5, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Kertas Dokumen Fisik A4 (Scrollable)
          Flexible(
            child: Container(
              color: const Color(0xFFE2E8F0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KOP SURAT RESMI
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'BULOG',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BADAN PANGAN NASIONAL (BAPANAS)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                Text(
                                  'PERUSAHAAN UMUM BULOG - KANWIL BALI',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Kantor Cabang Buleleng • Titik Penyerahan Desa Banjar Bali',
                                  style: TextStyle(fontSize: 8, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Garis Double Pembatas Kop
                      Container(height: 2, color: const Color(0xFF0F172A)),
                      const SizedBox(height: 2),
                      Container(height: 0.8, color: const Color(0xFF0F172A)),
                      const SizedBox(height: 12),

                      // JUDUL BERITA ACARA
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'BERITA ACARA SERAH TERIMA (BAST)',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Nomor Registrasi: $bastNo',
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E3A8A),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Paragraf Pembuka
                      Text(
                        'Pada hari ini, telah diserahkan secara resmi Bantuan Pangan Cadangan Beras Pemerintah (CPP) Tahap III Tahun 2024 kepada Penerima Bantuan Pangan (PBP) dengan rincian data sebagai berikut:',
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade800, height: 1.35),
                      ),
                      const SizedBox(height: 10),

                      // TABEL IDENTITAS PENERIMA
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: [
                            _tableRow('Nama Penerima (KPM)', nama, isHighlight: true),
                            _tableRow('Nomor Induk Kependudukan (NIK)', nik),
                            _tableRow('Nomor Kartu Keluarga (KK)', noKk),
                            _tableRow('Nomor Registrasi PBP', pbpNo),
                            _tableRow('Alur Penyaluran', jenis, isBadge: true),
                            _tableRow('Alamat Domisili KPM', alamat),
                            _tableRow('Komoditas Bantuan', '10 Kg Beras Medium CPP (1 Karung)'),
                            _tableRow('Waktu Penyerahan', waktu),
                            _tableRow('Koordinat Geotag GPS', '-8.109613, 115.0914146 (±2.4m RTK)'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // DOKUMENTASI FISIK BERAS & KTP
                      const Text(
                        'Lampiran Dokumentasi Fisik Penyerahan:',
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                                image: DecorationImage(
                                  image: banpangImageProvider(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                color: Colors.black.withValues(alpha: 0.7),
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: const Text(
                                  'Foto Fisik Beras & KPM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 7.5, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                                image: const DecorationImage(
                                  image: NetworkImage('https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=400'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                color: Colors.black.withValues(alpha: 0.7),
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: const Text(
                                  'Verifikasi KTP / SPTJM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 7.5, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // AREA TANDA TANGAN PENYERAHAN
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kolom Petugas
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Petugas Penyalur Lapangan\n(Perum BULOG / Mitra)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 48,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFF8FAFC),
                                  ),
                                  child: const Text(
                                    'TERTANDA DIGITAL\nBULOG CADANGAN PANGAN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'I Putu Agus Pratama',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                ),
                                const Text('NIP. 198804122014021003', style: TextStyle(fontSize: 7.5, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Kolom Penerima
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Penerima Manfaat (KPM)\n/ Yang Mewakili Sah',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 48,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFF8FAFC),
                                  ),
                                  child: signaturePoints != null && signaturePoints!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CustomPaint(
                                              size: const Size(double.infinity, 40),
                                              painter: DocumentSignaturePainter(
                                                points: signaturePoints!,
                                                fit: true,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          'TERTANDA TANGAN SAH',
                                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                                        ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  nama,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                ),
                                Text('NIK: $nik', style: const TextStyle(fontSize: 7.5, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // FOOTER LEGALITAS & QR CODE
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: const Icon(Icons.qr_code_2_rounded, size: 32, color: Color(0xFF0F172A)),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DOKUMEN ELEKTRONIK SAH BADAN PANGAN NASIONAL',
                                    style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                                  ),
                                  Text(
                                    'Telah dienkripsi SHA-256 & terdaftar resmi pada Sistem Aplikasi Banpang Mobile Perum BULOG.',
                                    style: TextStyle(fontSize: 7, color: Color(0xFF64748B), height: 1.25),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Action Buttons Bar
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        CenterAlert.showSuccess(
                          context,
                          title: 'Simulasi Cetak Berhasil',
                          message: 'Koneksi ke printer thermal / cetak nirkabel siap.',
                        );
                      },
                      icon: const Icon(Icons.print_rounded, size: 18, color: Color(0xFF1E3A8A)),
                      label: const Text('Cetak Dokumen', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE88B00),
                        foregroundColor: const Color(0xFF0F172A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                        CenterAlert.showSuccess(
                          context,
                          title: 'Berkas PDF Tersimpan',
                          message: 'Dokumen "$bastNo.pdf" berhasil disimpan di memori perangkat.',
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 18, color: Color(0xFF0F172A)),
                      label: const Text('Unduh PDF', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableRow(String label, String value, {bool isHighlight = false, bool isBadge = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(fontSize: 8.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
            ),
          ),
          const Text(' : ', style: TextStyle(fontSize: 8.5, color: Color(0xFF94A3B8))),
          Expanded(
            child: isBadge
                ? Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                        ),
                      ),
                    ],
                  )
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 8.5,
                      fontWeight: isHighlight ? FontWeight.w900 : FontWeight.w700,
                      color: isHighlight ? const Color(0xFF0F172A) : const Color(0xFF1E293B),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DocumentSignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final bool fit;

  DocumentSignaturePainter({
    required this.points,
    this.fit = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;

    if (!fit) {
      for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i + 1] != null) {
          canvas.drawLine(points[i]!, points[i + 1]!, paint);
        } else if (points[i] != null && points[i + 1] == null) {
          canvas.drawCircle(points[i]!, 1.0, paint);
        }
      }
      return;
    }

    final validPoints = points.whereType<Offset>().toList();
    if (validPoints.isEmpty) return;

    double minX = validPoints.first.dx;
    double maxX = validPoints.first.dx;
    double minY = validPoints.first.dy;
    double maxY = validPoints.first.dy;

    for (final p in validPoints) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    final origWidth = maxX - minX;
    final origHeight = maxY - minY;

    const padding = 4.0;
    final availWidth = size.width - (padding * 2);
    final availHeight = size.height - (padding * 2);

    if (availWidth <= 0 || availHeight <= 0) return;

    double scale = 1.0;
    if (origWidth > 0 && origHeight > 0) {
      final scaleX = availWidth / origWidth;
      final scaleY = availHeight / origHeight;
      scale = scaleX < scaleY ? scaleX : scaleY;
    }

    final scaledWidth = origWidth * scale;
    final scaledHeight = origHeight * scale;
    final offsetX = padding + (availWidth - scaledWidth) / 2 - (minX * scale);
    final offsetY = padding + (availHeight - scaledHeight) / 2 - (minY * scale);

    paint.strokeWidth = (2.0 * scale).clamp(1.2, 2.2);

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (p1 != null && p2 != null) {
        final sp1 = Offset(p1.dx * scale + offsetX, p1.dy * scale + offsetY);
        final sp2 = Offset(p2.dx * scale + offsetX, p2.dy * scale + offsetY);
        canvas.drawLine(sp1, sp2, paint);
      } else if (p1 != null && p2 == null) {
        final sp1 = Offset(p1.dx * scale + offsetX, p1.dy * scale + offsetY);
        canvas.drawCircle(sp1, paint.strokeWidth / 2, paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant DocumentSignaturePainter oldDelegate) => true;
}
