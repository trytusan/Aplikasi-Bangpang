import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryFilter extends StatelessWidget {
  final int selectedFilter;
  final ValueChanged<int> onSelectFilter;
  final int totalCount;
  final int normalCount;
  final int replacementCount;
  final int representativeCount;

  const HistoryFilter({
    super.key,
    required this.selectedFilter,
    required this.onSelectFilter,
    this.totalCount = 0,
    this.normalCount = 0,
    this.replacementCount = 0,
    this.representativeCount = 0,
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
              count: '$totalCount',
              isSelected: selectedFilter == 0,
              onTap: () => onSelectFilter(0),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: 'PBP Normal',
              count: '$normalCount',
              countColor: const Color(0xFF10B981),
              isSelected: selectedFilter == 1,
              onTap: () => onSelectFilter(1),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: 'Pengganti SPTJM',
              count: '$replacementCount',
              countColor: const Color(0xFFE88B00),
              isSelected: selectedFilter == 2,
              onTap: () => onSelectFilter(2),
            ),
            const SizedBox(width: 8),
            _filterTab(
              label: 'Perwakilan KK',
              count: '$representativeCount',
              countColor: const Color(0xFF3B82F6),
              isSelected: selectedFilter == 3,
              onTap: () => onSelectFilter(3),
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
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
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
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : (countColor != null ? countColor.withValues(alpha: 0.12) : const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                    color: isSelected
                        ? Colors.white
                        : (countColor ?? const Color(0xFF64748B)),
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
