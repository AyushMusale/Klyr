class GroupState {}

class GroupCreatedState extends GroupState {
  final String message;
  GroupCreatedState({required this.message});
}

class GroupFailureState extends GroupState {
  final String message;
  GroupFailureState({required this.message});
}

class GroupLoadingState extends GroupState {}

class GroupInitialState extends GroupState {}

class GroupUnauthState extends GroupState {
  final String message;
  GroupUnauthState({required this.message});
}
