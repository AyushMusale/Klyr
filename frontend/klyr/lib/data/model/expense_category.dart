import 'package:flutter/material.dart';

class ExpenseCategory {
  const ExpenseCategory({
    required this.label,
    required this.icon,
    required this.apiValue,
  });

  final String label;
  final IconData icon;
  final String apiValue;
}

const expenseCategories = [
  ExpenseCategory(
    label: 'subscriptions',
    icon: Icons.live_tv_outlined,
    apiValue: 'SUBSCRIPTIONS',
  ),
  ExpenseCategory(
    label: 'utilities',
    icon: Icons.build_outlined,
    apiValue: 'UTILITIES',
  ),
  ExpenseCategory(
    label: 'shopping',
    icon: Icons.shopping_bag_outlined,
    apiValue: 'SHOPPING',
  ),
  ExpenseCategory(
    label: 'health',
    icon: Icons.monitor_heart_outlined,
    apiValue: 'HEALTH',
  ),
  ExpenseCategory(
    label: 'transport',
    icon: Icons.directions_car_outlined,
    apiValue: 'TRANSPORT',
  ),
  ExpenseCategory(
    label: 'education',
    icon: Icons.menu_book_outlined,
    apiValue: 'EDUCATION',
  ),
  ExpenseCategory(
    label: 'food',
    icon: Icons.local_pizza_outlined,
    apiValue: 'FOOD',
  ),
  ExpenseCategory(
    label: 'other',
    icon: Icons.more_horiz,
    apiValue: 'OTHER',
  ),
];
