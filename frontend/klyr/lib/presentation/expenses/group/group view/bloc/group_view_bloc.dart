import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/domain/usecase/group_usecase.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_event.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_state.dart';

class GroupViewBloc extends Bloc<GroupViewEvent, GroupViewState> {
  final GroupUsecase groupUsecase;
  GroupViewBloc({required this.groupUsecase}) : super(GroupViewInitialState()) {
    on<GetGroupsViewEvent>(_onGetAll);
  }

  Future<void> _onGetAll(
    GetGroupsViewEvent event,
    Emitter<GroupViewState> emit,
  ) async {
    emit(GroupViewLoadingState());
    try {
      final list = await groupUsecase.getALlGroups();
      emit(GroupViewLoadedState(groupList: list));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          GroupViewUnauthState(message: 'Session Expired! Please LogIn again'),
        );
      } else if (e is GenPurposeException) {
        emit(GroupViewFailureState(message: e.message));
      } else {
        emit(GroupViewFailureState(message: 'Something went wrong'));
      }
    }
  }
}
