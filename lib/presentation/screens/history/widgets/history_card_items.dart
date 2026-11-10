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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFF059669), width: 4)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
                    child: const Text('PBP NORMAL', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, size: 12, color: Color(0xFF059669)),
                        SizedBox(width: 4),
                        Text('Diterima (Terverifikasi)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('JRO NYOMAN SETIASIH', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      SizedBox(height: 2),
                      Text(
                        '510806******0001 • No. PBP: 5108062...',
                        style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=200'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black.withValues(alpha: 0.75),
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: const Text('GEOTAG OK', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF34D399), fontSize: 8.5, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('📦 10 kg Beras CBP', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('BAST-2026095108062005', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF1E3A8A))),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 11, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('23 Juli 2025, 09:44 WITA', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 11, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('Banjar Bali, Buleleng', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Color(0xFF059669)),
                      SizedBox(width: 6),
                      Text('Tersinkronisasi ke Pusat', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onViewDetail?.call();
                    },
                    child: const Row(
                      children: [
                        Text('Lihat Detail BAST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                        Icon(Icons.chevron_right, size: 14, color: Color(0xFF1E3A8A)),
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFFD97706), width: 4)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(6)),
                    child: const Row(
                      children: [
                        Icon(Icons.swap_horiz, size: 12, color: Color(0xFFD97706)),
                        SizedBox(width: 4),
                        Text('ALUR PENGGANTI (SPTJM)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFFB45309))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, size: 12, color: Color(0xFF059669)),
                        SizedBox(width: 4),
                        Text('Diterima (Pengganti)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text('LUH SUMANTRI ARYANI', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              const Text(
                'Menggantikan: I Gede Suardika (Meninggal Dunia)',
                style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('📦 10 kg Beras CBP (1 Karung)', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('5108062005000024', style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 11, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text('23 Juli 2025, 09:15 WITA', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                          ],
                        ),
                        Text('BAST-2026095108062006', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF1E3A8A))),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.description_outlined, size: 14, color: Color(0xFF059669)),
                      SizedBox(width: 6),
                      Text('Dokumen SPTJM Terlampir', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onViewDetail?.call();
                    },
                    child: const Row(
                      children: [
                        Text('Lihat Berita Acara', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                        Icon(Icons.chevron_right, size: 14, color: Color(0xFF1E3A8A)),
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: isSynced ? const Color(0xFF059669) : const Color(0xFF64748B), width: 4)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
                    child: const Text('PERWAKILAN (1 KK)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSynced ? const Color(0xFFD1FAE5) : const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(isSynced ? Icons.check_circle : Icons.sync, size: 12, color: isSynced ? const Color(0xFF059669) : const Color(0xFF4F46E5)),
                        const SizedBox(width: 4),
                        Text(
                          isSynced ? 'Diterima (Terverifikasi)' : 'Menunggu Server',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            color: isSynced ? const Color(0xFF065F46) : const Color(0xFF4F46E5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text('KETUT ARTIKA', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              const Text(
                '👥 Diambil oleh: Putu Eka (Anak Kandung)',
                style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('10 kg Beras CBP', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('23 Juli 2025, 08:30 WITA', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B))),
                      ],
                    ),
                    Text('PBP: 510806192700029', style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
                  ],
                ),
              ),
              const Divider(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: isSynced ? const Color(0xFF059669) : const Color(0xFFD97706)),
                      const SizedBox(width: 6),
                      Text(
                        isSynced ? 'Tersinkronisasi ke Pusat' : 'Tersimpan di Penyimpanan\nLokal',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: isSynced ? const Color(0xFF059669) : const Color(0xFFD97706),
                          height: 1.15,
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
                        decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            isSyncing
                                ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFB45309)))
                                : const Icon(Icons.cloud_upload_outlined, size: 12, color: Color(0xFFB45309)),
                            const SizedBox(width: 4),
                            Text(isSyncing ? 'Mengunggah...' : 'Sinkronkan', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFB45309))),
                          ],
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: onViewDetail,
                      child: const Row(
                        children: [
                          Text('Lihat Detail BAST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                          Icon(Icons.chevron_right, size: 14, color: Color(0xFF1E3A8A)),
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xFFE11D48), width: 4)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFEE2E8), borderRadius: BorderRadius.circular(6)),
                    child: const Text('PBP NORMAL', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFFBE123C))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.error_outline, size: 12, color: Color(0xFFE11D48)),
                        SizedBox(width: 4),
                        Text('Ditolak / Foto Buram', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFFE11D48))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text('WAYAN SUJANA', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              const Text('NIK: 510806******0008', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B))),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 14, color: Color(0xFFE11D48)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Dokumentasi foto KTP tidak jelas / NIK terpotong. Perlu foto ulang bersama fisik beras di lapangan.',
                        style: TextStyle(fontSize: 9.5, color: Color(0xFFBE123C), height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE123C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onFixPhoto?.call();
                  },
                  icon: const Icon(Icons.camera_alt, size: 14),
                  label: const Text('Perbaiki Dokumentasi', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
