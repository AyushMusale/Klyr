import 'package:klyr/data/model/expense.dart';

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    this.isHighlighted = false,
  });
  final int id;
  final String title;
  final String date;
  final String amount;
  final bool isHighlighted;

  factory ActivityItem.fromExpense(Expense expense) {
    return ActivityItem(
      id: expense.id!,
      title: expense.title,
      date:
          '${expense.date.day.toString().padLeft(2, '0')}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.year}',
      amount: expense.amount,
    );
  }
}
