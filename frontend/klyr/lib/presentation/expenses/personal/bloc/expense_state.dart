import 'package:klyr/data/model/expense.dart';
import 'package:klyr/data/model/personal_expense.dart';

class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseCreatedState extends ExpenseState {
  final String message;

  ExpenseCreatedState({required this.message});
}

class ExpenseLoadedState extends ExpenseState {
  PersonalExpense? personalExpense;
  Expense? expense;

  ExpenseLoadedState({this.personalExpense, this.expense});
}

class ExpenseFailureState extends ExpenseState {
  final String message;

  ExpenseFailureState({required this.message});
}

class ExpenseUnauthState extends ExpenseState {
  final String message;
  ExpenseUnauthState({required this.message});
}
