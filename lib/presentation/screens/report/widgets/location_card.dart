import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String village;
  final String regency;
  final VoidCallback? onTap;

  const LocationCard({
    super.key,
    this.village = 'Banjar Bali, Buleleng',
    this.regency = 'KAB. BULELENG, BALI',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Color(0xFF2563EB), size: 20),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LOKASI TITIK BAGI', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Color(0xFF2563EB))),
                    Text(village, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    Text(regency, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }
}
