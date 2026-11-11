import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              countColor: const Color(0xFF10B981),
              isSelected: selectedFilter == 1,
              onTap: () => onSelectFilter(1),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: 'Belum Verifikasi',
              count: '7',
              countColor: const Color(0xFFF59E0B),
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
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                letterSpacing: -0.2,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withValues(alpha: 0.22) : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
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
