import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ExpenseSkeletonList extends StatelessWidget {
  const ExpenseSkeletonList({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final base =
        isDark ? AppColors.darkCard : const Color.fromARGB(255, 226, 223, 223);
    final highlight =
        isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.85);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (_, __) => const _ExpenseListItemSkeleton(),
      ),
    );
  }
}

class _ExpenseListItemSkeleton extends StatelessWidget {
  const _ExpenseListItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(height: 16, widthFactor: 0.55),
                const SizedBox(height: 4),
                _line(height: 12, widthFactor: 0.35),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _box(height: 16, width: 56),
        ],
      ),
    );
  }

  Widget _line({required double height, required double widthFactor}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: _box(height: height, width: double.infinity),
      ),
    );
  }

  Widget _box({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
