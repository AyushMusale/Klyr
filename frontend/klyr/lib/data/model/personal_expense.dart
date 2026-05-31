import 'package:klyr/data/model/expense.dart';

class PersonalExpense {
  List<Expense>? personalExpenselist;

  PersonalExpense({this.personalExpenselist = const []});

  factory PersonalExpense.fromJson(Map<String, dynamic> json) {
    return PersonalExpense(
      personalExpenselist:
          (json['personalExpenses'] as List).map((e) => Expense.fromJson(e)).toList(),
    );
  }
}
