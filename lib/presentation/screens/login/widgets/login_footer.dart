import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BULOG
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E40AF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PERUM BULOG',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Logistik Pangan',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 8.5),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 20),
            Container(width: 1, height: 24, color: Colors.white24),
            const SizedBox(width: 20),
            // BAPANAS
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF047857),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.grain, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BAPANAS',
                      style: TextStyle(color: Color(0xFF34D399), fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Badan Pangan RI',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 8.5),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),

        const Text(
          '© Divisi Teknologi Informasi Perum BULOG 2025',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2638).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Versi Aplikasi  v1.3.3 (2025072507)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
