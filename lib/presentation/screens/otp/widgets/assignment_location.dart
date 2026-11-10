import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AssignmentLocation extends StatelessWidget {
  const AssignmentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TITIK PENUGASAN RESMI',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textMain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.successGreenLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'VALID',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successGreen,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            const Text(
              'WILAYAH PENYALURAN',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSubtle),
            ),
            const SizedBox(height: 2),
            const Text(
              'Desa Banjar Bali, Kec. Buleleng',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textMain),
            ),
            const Text(
              'Kabupaten Buleleng, Bali (81113)',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lokasi Fisik', style: TextStyle(fontSize: 9, color: AppColors.textSubtle)),
                        SizedBox(height: 2),
                        Text('Kantor Desa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alokasi Kuota', style: TextStyle(fontSize: 9, color: AppColors.textSubtle)),
                        SizedBox(height: 2),
                        Text(
                          '48 KPM (480 Kg)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryAmberDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gudang Asal: GBB Buleleng (Kancab Singaraja)',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.navyPrimary),
                  ),
                  SizedBox(height: 2),
                  Text('Surat Tugas: ST-042/BPN-BLG/VII/2026', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
