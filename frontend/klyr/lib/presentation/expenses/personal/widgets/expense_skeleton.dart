import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_category_grid.dart';
import 'package:klyr/data/model/expense_category.dart';
import 'package:shimmer/shimmer.dart';

class ShowPersonalExpSkeleton extends StatelessWidget {
  const ShowPersonalExpSkeleton({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _amountCard(),
          const SizedBox(height: 20),
          _labelLine(widthFactor: 0.18),
          const SizedBox(height: 8),
          _field(height: 48),
          const SizedBox(height: 20),
          _labelLine(widthFactor: 0.24),
          const SizedBox(height: 10),
          ExpenseCategoryGrid(
            categories: const <ExpenseCategory>[],
            selectedIndex: 0,
            isDark: isDark,
            onSelected: (_) {},
            loading: true,
            loadingItemCount: 8,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _labelLine(widthFactor: 0.22),
                    const SizedBox(height: 8),
                    _field(height: 48),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _labelLine(widthFactor: 0.30),
                    const SizedBox(height: 8),
                    _field(height: 48),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _labelLine(widthFactor: 0.28),
          const SizedBox(height: 8),
          _field(height: 92),
        ],
      ),
    );
  }

  Widget _amountCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _labelLine(widthFactor: 0.30, height: 14),
          const SizedBox(height: 10),
          Row(
            children: [
              _box(height: 48, width: 48, radius: 12),
              const SizedBox(width: 10),
              Expanded(child: _box(height: 48, width: double.infinity)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labelLine({required double widthFactor, double height = 12}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: _box(height: height, width: double.infinity, radius: 8),
      ),
    );
  }

  Widget _field({required double height}) {
    return _box(height: height, width: double.infinity, radius: 14);
  }

  Widget _box({
    required double height,
    required double width,
    double radius = 14,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}