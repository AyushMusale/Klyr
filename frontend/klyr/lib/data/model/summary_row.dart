import 'dart:ui';

class SummaryRow {
  const SummaryRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;
}

class GroupSummary {
  final String totalSpent;
  final String totalOwes;
  final String totalOwed;

  GroupSummary({
    required this.totalSpent,
    required this.totalOwes,
    required this.totalOwed,
  });

  factory GroupSummary.fromJson(Map<String, dynamic> json) {
    return GroupSummary(
      totalSpent: json['total_spent'].toString(),
      totalOwes: json['total_owes'].toString(),
      totalOwed: json['total_owed'].toString(),
    );
  }
}

class HomeSummary {
  final String totalExpense;
  final String totalOwes;
  final String totalOwed;

  HomeSummary({
    required this.totalExpense,
    required this.totalOwes,
    required this.totalOwed,
  });

  factory HomeSummary.fromJson(Map<String, dynamic> json) {
    return HomeSummary(
      totalExpense: json['total_expense'].toString(),
      totalOwes: json['total_owes'].toString(),
      totalOwed: json['total_owed'].toString(),
    );
  }
}
