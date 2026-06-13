import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/data/model/summary_row.dart';

class HomeState {}

class HomeSuccessState extends HomeState {
  List<ActivityItem> activityItems;
  List<ActivityItem> groupactivityItems;
  HomeSummary summary;
  HomeSuccessState({
    required this.activityItems,
    required this.groupactivityItems,
    required this.summary,
  });
}

class HomeFailureState extends HomeState {
  final String message;
  HomeFailureState({required this.message});
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeUnauthState extends HomeState {
  final String message;
  HomeUnauthState({required this.message});
}
