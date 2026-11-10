import 'package:flutter/material.dart';

class GpsSubbar extends StatelessWidget {
  final String accuracy;

  const GpsSubbar({
    super.key,
    this.accuracy = '±3.2 m',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: const Color(0xFFE8FDF3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              const Text(
                'GPS Precision Lock (RTK-Ready)',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
              ),
            ],
          ),
          Text(
            '🎯 $accuracy',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
          ),
        ],
      ),
    );
  }
}
