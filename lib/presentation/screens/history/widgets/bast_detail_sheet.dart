import 'package:flutter/material.dart';

class BastDetailSheet extends StatelessWidget {
  final String bastNo;
  final String nama;
  final String nik;
  final String pbp;
  final String waktu;
  final String jenis;
  final String imageUrl;

  const BastDetailSheet({
    super.key,
    required this.bastNo,
    required this.nama,
    required this.nik,
    required this.pbp,
    required this.waktu,
    required this.jenis,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Berita Acara (BAST)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bastNo,
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A), fontFamily: 'monospace'),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 16),

          // Foto bukti & KPM
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 2),
                    Text('NIK: $nik', style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                    Text('No. PBP: $pbp', style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        jenis,
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Rincian Penyerahan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _rowItem('Waktu Penyerahan', waktu),
                const SizedBox(height: 6),
                _rowItem('Komoditas', '10 Kg Beras CPP Medium'),
                const SizedBox(height: 6),
                _rowItem('Lokasi Titik Bagi', 'Banjar Dinas Bale Agung, Banjar Bali'),
                const SizedBox(height: 6),
                _rowItem('Status Sinkronisasi', 'Tersinkronisasi ke Server Pusat BULOG'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tombol Unduh & Bagikan
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E3A8A)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tautan dokumen "$bastNo" berhasil disalin!')),
                    );
                  },
                  icon: const Icon(Icons.share, size: 16, color: Color(0xFF1E3A8A)),
                  label: const Text('Bagikan', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE88B00),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dokumen BAST "$bastNo.pdf" berhasil diunduh!'),
                        backgroundColor: const Color(0xFF059669),
                      ),
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf, size: 16, color: Colors.black),
                  label: const Text('Unduh PDF BAST', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
        ),
      ],
    );
  }
}
