import 'package:klyr/data/model/group.dart';

class GroupViewState {}

class GroupViewInitialState extends GroupViewState {}

class GroupViewLoadingState extends GroupViewState {}

class GroupViewLoadedState extends GroupViewState {
  final GroupList groupList;
  GroupViewLoadedState({required this.groupList});
}

class GroupViewFailureState extends GroupViewState {
  final String message;
  GroupViewFailureState({required this.message});
}

class GroupViewUnauthState extends GroupViewState {
  final String message;
  GroupViewUnauthState({required this.message});
}
