import 'package:flutter/material.dart';

class DistributionTimeCard extends StatelessWidget {
  final String distributionTime;
  final String subjectStatus;
  final String note;

  const DistributionTimeCard({
    super.key,
    this.distributionTime = '23 Juli 2025, 09:44 WITA',
    this.subjectStatus = 'Pengganti SPTJM',
    this.note = 'Diubah → Pengganti (Sesuai SPTJM Kelurahan/Desa)',
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
          // Baris 1: Waktu Distribusi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.event_available_rounded, size: 16, color: Color(0xFF1E3A8A)),
                  SizedBox(width: 8),
                  Text(
                    'Waktu Distribusi',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                distributionTime,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Baris 2: Status Subjek Penyerahan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.assignment_ind_rounded, size: 16, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Text(
                    'Status Subjek',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  subjectStatus,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: Color(0xFFB45309)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Baris 3: Catatan Otorisasi SPTJM
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFEF3C7)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_rounded, size: 14, color: Color(0xFFD97706)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    note,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF92400E),
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
