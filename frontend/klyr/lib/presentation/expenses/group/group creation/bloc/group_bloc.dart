import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/domain/usecase/group_usecase.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/bloc/group_event.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/bloc/group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupUsecase groupUsecase;
  GroupBloc({required this.groupUsecase}) : super(GroupInitialState()) {
    on<GroupCreationEvent>(_onCreate);
  }

  Future<void> _onCreate(
    GroupCreationEvent event,
    Emitter<GroupState> emit,
  ) async {
    emit(GroupLoadingState());
    try {
      final res = await groupUsecase.createGroup(group: event.group);

      emit(GroupCreatedState(message: res));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(GroupUnauthState(message: 'Session Expired! Please LogIn again'));
      } else if (e is GenPurposeException) {
        emit(GroupFailureState(message: e.message));
      } else {
        emit(GroupFailureState(message: 'Something went wrong'));
      }
    }
  }
}
