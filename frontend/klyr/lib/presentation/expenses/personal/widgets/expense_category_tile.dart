import 'package:flutter/material.dart';
import 'package:klyr/data/model/expense_category.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpenseCategoryTile extends StatelessWidget {
  const ExpenseCategoryTile({
    super.key,
    required this.category,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  final ExpenseCategory category;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected
            ? AppColors.primary
            : (isDark ? AppColors.darkBorder : const Color(0xFFE5E5E5));
    final iconColor =
        selected
            ? AppColors.primary
            : (isDark ? AppColors.darkSubText : const Color(0xFF9A9A9A));
    final labelColor =
        selected
            ? AppColors.primary
            : (isDark ? AppColors.darkSubText : const Color(0xFF7A7A7A));
    final tileBg = isDark ? AppColors.darkCard : Colors.white;

    return Material(
      color: tileBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, color: iconColor, size: 22),
              const SizedBox(height: 6),
              Text(
                category.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
