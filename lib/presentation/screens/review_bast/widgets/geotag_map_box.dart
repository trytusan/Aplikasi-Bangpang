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
    this.accuracy = 'Akurasi 3.2m',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.my_location, size: 18, color: Color(0xFF059669)),
                  SizedBox(width: 8),
                  Text('Verifikasi Titik\nKoordinat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                child: const Text('🎯 Radius Valid (< 50m)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Container(
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFE11D48), size: 16),
                      const SizedBox(width: 4),
                      Text(locationCode, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: Colors.black.withValues(alpha: 0.75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subdistrict, style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w700)),
                            Text(coordinates, style: const TextStyle(color: Colors.white70, fontSize: 7.5, fontFamily: 'monospace')),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(accuracy, style: const TextStyle(color: Color(0xFF34D399), fontSize: 8.5, fontWeight: FontWeight.w900)),
                            const Text('Tinggi (GPS Satelit)', style: TextStyle(color: Colors.white70, fontSize: 7.5)),
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
