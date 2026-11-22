import 'package:flutter/material.dart';

class OfflineSync extends StatelessWidget {
  final bool offlineMode;
  final ValueChanged<bool> onToggleOfflineMode;
  final VoidCallback onSyncNow;
  final VoidCallback onRefreshCoordinates;
  final String cacheSize;
  final int pendingCount;

  const OfflineSync({
    super.key,
    required this.offlineMode,
    required this.onToggleOfflineMode,
    required this.onSyncNow,
    required this.onRefreshCoordinates,
    this.cacheSize = '0.0 MB',
    this.pendingCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final int photoCount = pendingCount * 2;
    final int signatureCount = pendingCount;
    final bool hasPending = pendingCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.tune, size: 14, color: Color(0xFF1E3A8A)),
            SizedBox(width: 6),
            Text('OPERASIONAL & SINKRONISASI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
          ],
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mode Luar Jaringan
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.signal_cellular_connected_no_internet_4_bar, color: Color(0xFF4F46E5), size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mode Luar Jaringan', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('Simpan data BAST & foto di penyimpanan lokal jika sinyal di pelosok lemah.', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), height: 1.25)),
                      ],
                    ),
                  ),
                  Switch(
                    value: offlineMode,
                    activeColor: const Color(0xFFE88B00),
                    onChanged: onToggleOfflineMode,
                  ),
                ],
              ),
              const Divider(height: 20),

              // Sinkronisasi Manual & Cache
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: hasPending ? const Color(0xFFFFFBEB) : const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      hasPending ? Icons.cloud_sync_outlined : Icons.cloud_done_rounded,
                      color: hasPending ? const Color(0xFFD97706) : const Color(0xFF059669),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sinkronisasi Manual & Cache', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text(
                          hasPending
                              ? '$pendingCount data BAST ($photoCount berkas foto & $signatureCount TTD) tersimpan di memori lokal.'
                              : 'Semua data BAST telah tersinkronisasi. Antrean memori bersih.',
                          style: const TextStyle(fontSize: 9.5, color: Color(0xFF64748B), height: 1.25),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: hasPending ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cacheSize,
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                        color: hasPending ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hasPending ? const Color(0xFFE88B00) : const Color(0xFF1E3A8A),
                    foregroundColor: hasPending ? const Color(0xFF0F172A) : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onSyncNow,
                  icon: Icon(hasPending ? Icons.cloud_upload_outlined : Icons.sync_rounded, size: 16),
                  label: Text(
                    hasPending ? 'Sinkronkan $pendingCount BAST Sekarang' : 'Cek Status Server Pusat',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const Divider(height: 20),

              // Perbarui Titik Lokasi GPS
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: const Color(0xFFE8FDF3), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.my_location, color: Color(0xFF059669), size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Perbarui Titik Lokasi GPS', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                      ],
                    ),
                  ),
                  const Text('🎯 Akurasi ±2.4m', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                child: const Text('Lat: -8.109613, Long: 115.0914146 (Desa Banjar Bali)', style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEEF2FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onRefreshCoordinates,
                  icon: const Icon(Icons.refresh, size: 14, color: Color(0xFF1E3A8A)),
                  label: const Text('Perbarui Koordinat Lapangan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
