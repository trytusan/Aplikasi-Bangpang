import 'package:flutter/material.dart';

class HistoryFilter extends StatelessWidget {
  final int selectedFilter;
  final ValueChanged<int> onSelectFilter;

  const HistoryFilter({
    super.key,
    required this.selectedFilter,
    required this.onSelectFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterTab(
              label: 'Semua',
              count: '45',
              isSelected: selectedFilter == 0,
              onTap: () => onSelectFilter(0),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: '✓ Diterima',
              count: '38',
              countColor: const Color(0xFF34D399),
              isSelected: selectedFilter == 1,
              onTap: () => onSelectFilter(1),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: 'Belum Verifikasi',
              isSelected: selectedFilter == 2,
              onTap: () => onSelectFilter(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterTab({
    required String label,
    String? count,
    Color? countColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected ? (countColor ?? Colors.white24) : const Color(0xFFEEF2F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isSelected ? Colors.black : const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
