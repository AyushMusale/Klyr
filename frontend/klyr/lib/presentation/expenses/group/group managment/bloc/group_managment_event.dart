import 'package:klyr/data/model/expense.dart';
import 'package:klyr/data/model/group.dart';
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

class CreateExpenseEvent extends GroupManagmentEvent {
  final Expense expense;
  final int groupId;
  final List<GroupMembers> groupMembers;
  final String paidBy;

  CreateExpenseEvent({
    required this.expense,
    required this.groupId,
    required this.groupMembers,
    required this.paidBy,
  });
}
