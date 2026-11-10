import 'package:flutter/material.dart';

class SptjmCard extends StatelessWidget {
  final String fileName;
  final VoidCallback? onTapUpload;

  const SptjmCard({
    super.key,
    this.fileName = 'SPTJM-510806-2024-008.PDF',
    this.onTapUpload,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapUpload,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.qr_code_2, color: Color(0xFF4F46E5), size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SPTJM Pengganti Terlampir',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFD1FAE5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Color(0xFF059669), size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
