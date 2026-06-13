import 'package:klyr/data/model/expense.dart';
import 'package:klyr/data/model/group.dart';

class GroupExpense {
  final Expense expense;
  final String? paidBy;
  final List<GroupMembers> members;

  GroupExpense({required this.expense, required this.members, this.paidBy});
  factory GroupExpense.fromJson(Map<String, dynamic> json) {
    return GroupExpense(
      paidBy: json['paid_by'] as String?,
      expense: Expense.fromJson(json),
      members:
          (json['Expense_participants'] as List<dynamic>)
              .map((e) => GroupMembers.fromJson(e as Map<String, dynamic>))
              .toList(),  
    );
  }
}
