import 'package:flutter/material.dart';
import 'package:klyr/presentation/expenses/navigation/widgets/navigation_selection_card.dart';

class ExpenseNavigationPage extends StatelessWidget {
  const ExpenseNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg =
        isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : const Color(0xFFF4F4F4);
    return Scaffold(
      backgroundColor: pageBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SelectionCard(
                isDark: isDark,
                icon: Icons.groups_outlined,
                label: "Group",
              ),
              SelectionCard(
                isDark: isDark,
                icon: Icons.person,
                label: "Personal",
              ),
            ],
          ),
          SelectionCard(
            isDark: isDark,
            icon: Icons.group_outlined,
            label: "Individual",
          ),
        ],
      ),
    );
  }
}
