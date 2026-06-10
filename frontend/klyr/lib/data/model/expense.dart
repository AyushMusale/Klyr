class Expense {
  final String amount;
  final String title;
  final String category;
  final String currency;
  final DateTime date;
  final String? splitType;
  final int? id;
  final int? groupId;

  Expense({
    this.id,
    this.groupId,
    this.splitType,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.currency,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['expense_id'],
      title: json['title'],
      amount: json['amount'].toString(),
      category: json['category'],
      currency: json['currency'] ?? 'INR',
      date: DateTime.parse(json['created_at']),
      splitType: json['split_type'] as String?,
      groupId: json['group_id'] as int?,
    );
  }
}
