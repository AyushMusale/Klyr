import 'package:klyr/data/model/group.dart';

class GroupMangmentState {}

class GroupMangmentLoadedState extends GroupMangmentState {
  final Group group;
  GroupMangmentLoadedState({required this.group});
}

class GroupMangmentInitialState extends GroupMangmentState {}

class GroupMangmentLoadingState extends GroupMangmentState {}

class GroupMangmentUnauthState extends GroupMangmentState {
  final String message;
  GroupMangmentUnauthState({required this.message});
}

class GroupMangmentFailureState extends GroupMangmentState {
  final String message;
  GroupMangmentFailureState({required this.message});
}
