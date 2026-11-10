import 'package:flutter/material.dart';

class ReasonPicker extends StatelessWidget {
  final bool useMusdesData;
  final ValueChanged<bool> onToggleMusdes;
  final String selectedReason;
  final ValueChanged<String> onSelectReason;

  const ReasonPicker({
    super.key,
    required this.useMusdesData,
    required this.onToggleMusdes,
    required this.selectedReason,
    required this.onSelectReason,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.check_box_outlined, color: Color(0xFFD97706), size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gunakan penerima pengganti dari data cadangan resmi SPTJM Desa',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.25),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Daftar terdaftar pada Musdes Penetapan Tambahan',
                      style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Switch(
                value: useMusdesData,
                activeColor: const Color(0xFFE88B00),
                activeTrackColor: const Color(0xFFFDE68A),
                onChanged: onToggleMusdes,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        RichText(
          text: const TextSpan(
            text: 'Alasan Penggantian PBP ',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            children: [
              TextSpan(text: '* ', style: TextStyle(color: Color(0xFFE11D48))),
              TextSpan(text: '(Wajib Sesuai Juknis)', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.person_pin_outlined, size: 18, color: Color(0xFFD97706)),
                  const SizedBox(width: 8),
                  Text(
                    selectedReason == 'Meninggal' ? 'Meninggal Dunia' : selectedReason,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
            ],
          ),
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: Color(0xFF2563EB)),
              SizedBox(width: 8),
              Text(
                'Memerlukan surat keterangan kematian atau SPTJM resmi.',
                style: TextStyle(fontSize: 9.5, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        const Text('Pilihan Alasan Cepat:', style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _chip('Alamat Tidak Ditemukan'),
            _chip('Sudah Mampu'),
            _chip('ASN'),
            _chip('TNI'),
            _chip('Polri'),
            _chip('Meninggal'),
          ],
        ),
      ],
    );
  }

  Widget _chip(String label) {
    final bool isSelected = selectedReason == label;
    return GestureDetector(
      onTap: () => onSelectReason(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE88B00) : const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.black : const Color(0xFF1E3A8A),
          ),
        ),
      ),
    );
  }
}
