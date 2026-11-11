import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryCardNormal extends StatelessWidget {
  final VoidCallback? onViewDetail;

  const HistoryCardNormal({super.key, this.onViewDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFF059669), width: 4.5)),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris Tag Alur & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'PBP NORMAL',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                          'Diterima (Terverifikasi)',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF047857)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Baris Nama KPM & Geotag Photo Thumbnail
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JRO NYOMAN SETIASIH',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '510806******0001 • No. PBP: 5108062005000012',
                          style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(9)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: const Text(
                            'GEOTAG OK',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF34D399), fontSize: 7.5, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Kotak Detail Distribusi
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('🌾', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 6),
                            Text(
                              '10 kg Beras CBP',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                        Text(
                          'BAST-2026095108062005',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF1E3A8A)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('23 Juli 2025, 09:44 WITA', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('Banjar Bali, Buleleng', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Footer: Status Sinkron & Tombol Detail
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF059669),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Tersinkronisasi ke Pusat',
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onViewDetail?.call();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'Lihat Detail BAST',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCardReplacement extends StatelessWidget {
  final VoidCallback? onViewDetail;

  const HistoryCardReplacement({super.key, this.onViewDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFFE88B00), width: 4.5)),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris Tag Alur & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.swap_horiz_rounded, size: 13, color: Color(0xFFD97706)),
                        SizedBox(width: 4),
                        Text(
                          'ALUR PENGGANTI (SPTJM)',
                          style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFFB45309)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                          'Diterima (Pengganti)',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF047857)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text(
                'LUH SUMANTRI ARYANI',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Menggantikan: I Gede Suardika (Alm)',
                      style: TextStyle(fontSize: 10, color: Color(0xFFBE123C), fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Kotak Detail Distribusi
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('🌾', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 6),
                            Text(
                              '10 kg Beras CBP (1 Karung)',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                        Text(
                          '5108062005000024',
                          style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('23 Juli 2025, 09:15 WITA', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                          ],
                        ),
                        Text(
                          'BAST-2026095108062006',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF1E3A8A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Footer: Status Dokumen SPTJM & Tombol Detail
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.description_rounded, size: 15, color: Color(0xFF059669)),
                      SizedBox(width: 6),
                      Text(
                        'Dokumen SPTJM Terlampir',
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onViewDetail?.call();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'Lihat Berita Acara',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCardRepresentative extends StatelessWidget {
  final bool isSynced;
  final bool isSyncing;
  final VoidCallback? onSync;
  final VoidCallback? onViewDetail;

  const HistoryCardRepresentative({
    super.key,
    this.isSynced = false,
    this.isSyncing = false,
    this.onSync,
    this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: isSynced ? const Color(0xFF059669) : const Color(0xFF2563EB), width: 4.5)),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tag Alur & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'PERWAKILAN (1 KK)',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isSynced ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSynced ? const Color(0xFFA7F3D0) : const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSynced ? Icons.check_circle_rounded : Icons.pending_rounded,
                          size: 12,
                          color: isSynced ? const Color(0xFF059669) : const Color(0xFFD97706),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isSynced ? 'Diterima (Terverifikasi)' : 'Menunggu Server',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: isSynced ? const Color(0xFF047857) : const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text(
                'KETUT ARTIKA',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 2),
              const Text(
                '👥 Diambil oleh: Putu Eka (Anak Kandung)',
                style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              // Kotak Detail
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🌾 10 kg Beras CBP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        SizedBox(height: 2),
                        Text('23 Juli 2025, 08:30 WITA', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      ],
                    ),
                    Text('PBP: 510806192700029', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Footer: Status & Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isSynced ? const Color(0xFF059669) : const Color(0xFFD97706),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isSynced ? 'Tersinkronisasi ke Pusat' : 'Tersimpan di Penyimpanan Lokal',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isSynced ? const Color(0xFF059669) : const Color(0xFFD97706),
                        ),
                      ),
                    ],
                  ),
                  if (!isSynced)
                    InkWell(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        if (!isSyncing) onSync?.call();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            isSyncing
                                ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 1.8, color: Colors.white))
                                : const Icon(Icons.cloud_upload_rounded, size: 13, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              isSyncing ? 'Mengunggah...' : 'Sinkronkan',
                              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onViewDetail?.call();
                      },
                      child: const Row(
                        children: [
                          Text('Lihat Detail BAST', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCardRejected extends StatelessWidget {
  final VoidCallback? onFixPhoto;

  const HistoryCardRejected({super.key, this.onFixPhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFFE11D48), width: 4.5)),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('PBP NORMAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFBE123C))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFECDD3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.error_outline_rounded, size: 12, color: Color(0xFFE11D48)),
                        SizedBox(width: 4),
                        Text('Ditolak / Foto Buram', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text('WAYAN SUJANA', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              const Text('NIK: 510806******0008', style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFECDD3)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_rounded, size: 15, color: Color(0xFFE11D48)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Dokumentasi foto KTP tidak jelas / NIK terpotong. Perlu foto ulang bersama fisik beras di lapangan.',
                        style: TextStyle(fontSize: 10, color: Color(0xFFBE123C), height: 1.35),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE11D48),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onFixPhoto?.call();
                  },
                  icon: const Icon(Icons.camera_alt_rounded, size: 16),
                  label: const Text('Perbaiki Dokumentasi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
