import 'package:klyr/data/model/group.dart';
import 'package:klyr/data/model/group_expense.dart';
import 'package:klyr/data/model/summary_row.dart';

class GroupMangmentState {}

class GroupMangmentLoadedState extends GroupMangmentState {
  final Group group;
  final GroupSummary summary;
  final List<GroupExpense> groupExpense;
  GroupMangmentLoadedState({
    required this.group,
    required this.summary,
    required this.groupExpense,
  });
}

class GroupMangmentInitialState extends GroupMangmentState {}

class GroupMangmentCreatedState extends GroupMangmentState {
  final String message;
  GroupMangmentCreatedState({required this.message});
}

class GroupMangmentLoadingState extends GroupMangmentState {}

class GroupMangmentUnauthState extends GroupMangmentState {
  final String message;
  GroupMangmentUnauthState({required this.message});
}

class GroupMangmentFailureState extends GroupMangmentState {
  final String message;
  GroupMangmentFailureState({required this.message});
}
