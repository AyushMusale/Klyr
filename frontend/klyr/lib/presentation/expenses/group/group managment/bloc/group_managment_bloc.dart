import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/domain/usecase/group_usecase.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_event.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_mangment_state.dart';

class GroupManagmentBloc extends Bloc<GroupManagmentEvent, GroupMangmentState> {
  final GroupUsecase groupUsecase;
  GroupManagmentBloc({required this.groupUsecase})
    : super(GroupMangmentInitialState()) {
    on<GetGroupEvent>(_onGet);
  }

  Future<void> _onGet(
    GetGroupEvent event,
    Emitter<GroupMangmentState> emit,
  ) async {
    emit(GroupMangmentLoadingState());
    try {
      final group = await groupUsecase.getGroupByID(id: event.id);

      emit(GroupMangmentLoadedState(group: group));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          GroupMangmentUnauthState(
            message: 'Session Expired! Please LogIn again',
          ),
        );
      } else if (e is GenPurposeException) {
        emit(GroupMangmentFailureState(message: e.message));
      } else {
        emit(GroupMangmentFailureState(message: 'Something went wrong'));
      }
    }
  }
}
