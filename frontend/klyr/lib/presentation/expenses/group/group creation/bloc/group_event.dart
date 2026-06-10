import 'package:klyr/data/model/group.dart';

class GroupEvent {}

class GroupCreationEvent extends GroupEvent {
  final Group group;

  GroupCreationEvent({required this.group});
}
