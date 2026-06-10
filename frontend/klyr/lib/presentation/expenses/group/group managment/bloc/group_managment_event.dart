import 'package:klyr/data/model/group_expense.dart';

class GroupManagmentEvent {}

class GetGroupEvent extends GroupManagmentEvent {
  final String id;
  GetGroupEvent({required this.id});
}

class AddGroupExpenseEvent extends GroupManagmentEvent {
  final GroupExpense groupExpense;
  AddGroupExpenseEvent({required this.groupExpense});
}
