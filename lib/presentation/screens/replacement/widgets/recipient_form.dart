import 'package:flutter/material.dart';

class RecipientForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController nikController;
  final TextEditingController noKkController;
  final String address;

  const RecipientForm({
    super.key,
    required this.nameController,
    required this.nikController,
    required this.noKkController,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person_add_alt_1_outlined, size: 20, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Text(
                    'Data Penerima\nPengganti',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.15),
                  ),
                ],
              ),
              Text(
                'VALIDASI\nDUKCAPIL',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 0.5),
              ),
            ],
          ),
          const Divider(height: 20),

          const Text('Nama Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: nameController,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.check_circle_outline, color: Color(0xFF059669), size: 18),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('NIK Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
              Text('✓ 16 / 16 Karakter', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: nikController,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF0F172A)),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.check_circle_outline, color: Color(0xFF059669), size: 18),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text('No. KK Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: noKkController,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Color(0xFF0F172A)),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.badge_outlined, color: Color(0xFF64748B), size: 18),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text('Alamat Penerima Pengganti *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              address,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFECDD3)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: Color(0xFFE11D48), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aturan Validasi Lapangan:',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFBE123C)),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'NIK tidak boleh kosong dan harus 16 digit angka valid yang telah terdaftar di database DKB Kemendagri.',
                        style: TextStyle(fontSize: 9.5, color: Color(0xFFBE123C), height: 1.3),
                      ),
                    ],
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
