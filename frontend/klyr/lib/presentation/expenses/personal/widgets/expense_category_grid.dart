import 'package:flutter/material.dart';
import 'package:klyr/data/model/expense_category.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_category_tile.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpenseCategoryGrid extends StatelessWidget {
  const ExpenseCategoryGrid({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.isDark,
    required this.onSelected,
    this.loading = false,
    this.loadingItemCount = 8,
  });

  final List<ExpenseCategory> categories;
  final int selectedIndex;
  final bool isDark;
  final ValueChanged<int> onSelected;
  final bool loading;
  final int loadingItemCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 10.0;
        const columns = 4;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(loading ? loadingItemCount : categories.length, (i) {
            final cat = loading ? null : categories[i];
            final selected = !loading && selectedIndex == i;
            return SizedBox(
              width: itemWidth,
              child:
                  loading
                      ? _CategorySkeletonTile(isDark: isDark)
                      : ExpenseCategoryTile(
                        category: cat!,
                        selected: selected,
                        isDark: isDark,
                        onTap: () => onSelected(i),
                      ),
            );
          }),
        );
      },
    );
  }
}

class _CategorySkeletonTile extends StatelessWidget {
  const _CategorySkeletonTile({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE5E5E5);
    final tileBg = isDark ? AppColors.darkCard : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 10,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
