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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFE8FDF3),
        border: Border(bottom: BorderSide(color: Color(0xFFA7F3D0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              const Text(
                'GPS Precision Lock (RTK-Ready)',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Text(
              '🎯 $accuracy',
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
            ),
          ),
        ],
      ),
    );
  }
}
