import 'package:flutter/material.dart';

class OfflineSync extends StatelessWidget {
  final bool offlineMode;
  final ValueChanged<bool> onToggleOfflineMode;
  final VoidCallback onSyncNow;
  final VoidCallback onRefreshCoordinates;

  const OfflineSync({
    super.key,
    required this.offlineMode,
    required this.onToggleOfflineMode,
    required this.onSyncNow,
    required this.onRefreshCoordinates,
  });

  @override
  Widget build(BuildContext context) {
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
                    activeThumbColor: const Color(0xFFE88B00),
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
                    decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.cloud_sync_outlined, color: Color(0xFFD97706), size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sinkronisasi Manual & Cache', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('14 berkas foto KPM dan 3 tanda tangan digital tersimpan di memori aman perangkat.', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), height: 1.25)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                    child: const Text('34.2 MB', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE88B00),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onSyncNow,
                  icon: const Icon(Icons.cloud_upload_outlined, size: 16),
                  label: const Text('Sinkronkan Sekarang', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
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
                  const Text('🎯 Akurasi 3m', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                child: const Text('Lat: -8.109613, Long: 115.0914146', style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B))),
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
