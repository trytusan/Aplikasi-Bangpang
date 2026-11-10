import 'package:flutter/material.dart';

class ServerStatus extends StatelessWidget {
  final String location;
  final String ping;

  const ServerStatus({
    super.key,
    this.location = 'Desa Banjar Bali, Buleleng',
    this.ping = '22ms',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, size: 15, color: Color(0xFFE11D48)),
              const SizedBox(width: 5),
              Text(
                'Titik Bagi: $location',
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: Color(0xFF059669)),
                    SizedBox(width: 5),
                    Text(
                      'Server BULOG Terhubung (Online)',
                      style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                    ),
                  ],
                ),
              ),
              Text(
                'Ping: $ping',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
