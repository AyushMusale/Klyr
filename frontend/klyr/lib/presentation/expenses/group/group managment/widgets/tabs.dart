import 'package:flutter/material.dart';
import 'package:klyr/data/model/group_expense.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpensesTab extends StatelessWidget {
  final List<GroupExpense> expenses;
  const ExpensesTab({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          "No expenses yet",
          style: TextStyle(color: AppColors.darkSubText, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpenseTile(expense: expenses[index]);
      },
    );
  }
}

class ExpenseTile extends StatelessWidget {
  final GroupExpense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subtextColor =
        isDark ? AppColors.darkSubText : AppColors.lightSubText;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Category icon
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(_categoryIcon(expense.expense.category))),
          ),
          const SizedBox(width: 12),

          // Title + paid by
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.expense.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Paid by ${expense.paidBy}",
                  style: TextStyle(color: subtextColor, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Amount
          Text(
            "₹${expense.expense.amount}",
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  IconData _categoryIcon(String category) {
    const map = {
      'SUBSCRIPTIONS': Icons.live_tv_outlined,
      'UTILITIES': Icons.build_outlined,
      'SHOPPING': Icons.shopping_bag_outlined,
      'HEALTH': Icons.monitor_heart_outlined,
      'TRANSPORT': Icons.directions_car_outlined,
      'EDUCATION': Icons.menu_book_outlined,
      'FOOD': Icons.local_pizza_outlined,
      'RENT': Icons.home_outlined,
      'ENTERTAINMENT': Icons.movie_outlined,
      'TRAVEL': Icons.flight_outlined,
      'OTHER': Icons.more_horiz,
    };
    return map[category] ?? Icons.more_horiz;
  }
}

class BalancesTab extends StatelessWidget {
  const BalancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
