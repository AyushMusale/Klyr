import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/domain/usecase/home_usecase.dart';
import 'package:klyr/presentation/home/bloc/home_event.dart';
import 'package:klyr/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;
  HomeBloc({required this.homeUsecase}) : super(HomeInitialState()) {
    on<GetHomeEvent>(_onGet);
  }
  Future<void> _onGet(GetHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final personalExpense = await homeUsecase.getPersonalExpense();
      final personalActivities =
          personalExpense.personalExpenselist
              ?.map(
                (e) => ActivityItem(
                  id: e.id!,
                  title: e.title,
                  date:
                      '${e.date.day.toString().padLeft(2, '0')}-${e.date.month.toString().padLeft(2, '0')}-${e.date.year}',
                  amount: e.amount,
                ),
              )
              .toList();
      emit(HomeSuccessState(activityItems: personalActivities!));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(HomeUnauthState(message: 'Session Expired! Please LogIn again'));
      } else if (e is GenPurposeException) {
        emit(HomeFailureState(message: e.message));
      } else {
        emit(HomeFailureState(message: 'Something went wrong'));
      }
    }
  }
}
