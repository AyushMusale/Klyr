import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/data/model/summary_row.dart';

class HomeState {}

class HomeSuccessState extends HomeState {
  List<ActivityItem> activityItems;
  // List<SummaryRow> summaryRow;
  // final String firstLetter;
  HomeSuccessState({
    required this.activityItems,
    // required this.summaryRow,
    // required this.firstLetter,
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
