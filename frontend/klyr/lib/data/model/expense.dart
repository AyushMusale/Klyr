class Expense {
  final String amount;
  final String title;
  final String category;
  final String currency;
  final DateTime date;
  final int? id;

  Expense({
    this.id,
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
    );
  }
}
