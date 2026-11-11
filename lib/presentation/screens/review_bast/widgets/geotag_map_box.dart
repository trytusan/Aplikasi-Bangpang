import 'package:flutter/material.dart';

class GeotagMapBox extends StatelessWidget {
  final String locationCode;
  final String subdistrict;
  final String coordinates;
  final String accuracy;

  const GeotagMapBox({
    super.key,
    this.locationCode = 'V3FG+8JP',
    this.subdistrict = 'Baktiseraga, Kab. Buleleng',
    this.coordinates = 'Lat: -8.109613, Long: 115.0914146',
    this.accuracy = 'Akurasi ±3.2m',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Judul & Status Radius
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.my_location_rounded, size: 18, color: Color(0xFF059669)),
                  SizedBox(width: 8),
                  Text(
                    'Verifikasi Titik Koordinat',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Text(
                  '🎯 Radius Valid (< 50m)',
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

          // Peta Visual Geotag Box
          Container(
            height: 105,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 12,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: Color(0xFFE11D48), size: 17),
                      const SizedBox(width: 4),
                      Text(
                        'Plus Code: $locationCode',
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.82),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(subdistrict, style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 1),
                              Text(coordinates, style: const TextStyle(color: Colors.white70, fontSize: 8.5, fontFamily: 'monospace')),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(accuracy, style: const TextStyle(color: Color(0xFF34D399), fontSize: 9.5, fontWeight: FontWeight.w900)),
                            const Text('Satelit GPS RTK', style: TextStyle(color: Colors.white70, fontSize: 8)),
                          ],
                        ),
                      ],
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
}
