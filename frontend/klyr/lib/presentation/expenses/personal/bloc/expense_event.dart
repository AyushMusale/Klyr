class ExpenseEvent {}

class CreateExpenseEvent extends ExpenseEvent {
  final String amount;
  final String title;
  final int categoryIndex;
  final String currency;
  final DateTime date;
  

  CreateExpenseEvent({
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryIndex,
    required this.currency,
  });
}

class GetExpenseEvent extends ExpenseEvent {}

class GetExpenseByIDEvent extends ExpenseEvent {
  final int id;
  GetExpenseByIDEvent({required this.id});
}

class EditExpenseEvent extends ExpenseEvent {
  final String amount;
  final String title;
  final int categoryIndex;
  final String currency;
  final DateTime date;
  final int id;

  EditExpenseEvent({
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryIndex,
    required this.currency,
    required this.id,
  });
}

class DeleteExpenseEvent extends ExpenseEvent{
  final int id;
  DeleteExpenseEvent({
    required this.id
  });
}