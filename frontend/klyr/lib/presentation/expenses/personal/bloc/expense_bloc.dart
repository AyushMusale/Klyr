import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/expense.dart';
import 'package:klyr/domain/usecase/personal_expense_usecase.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_event.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_state.dart';
import 'package:klyr/data/model/expense_category.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final PersonalExpenseUsecase personalExpenseUsecase;
  ExpenseBloc({required this.personalExpenseUsecase})
    : super(ExpenseInitialState()) {
    on<CreateExpenseEvent>(_onCreate);
    on<GetExpenseByIDEvent>(_onGetbyID);
    on<EditExpenseEvent>(_onEdit);
    on<GetExpenseEvent>(_onGet);
  }

  Future<void> _onCreate(
    CreateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoadingState());
    try {
      final category = expenseCategories[event.categoryIndex].apiValue;

      final expense = Expense(
        title: event.title,
        amount: event.amount,
        date: event.date,
        category: category,
        currency: event.currency,
      );

      await personalExpenseUsecase.createPersonalExpense(expense);

      emit(ExpenseCreatedState(message: "Expense Added"));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          ExpenseUnauthState(message: 'Session Expired! Please LogIn again'),
        );
      } else if (e is GenPurposeException) {
        emit(ExpenseFailureState(message: e.message));
      } else {
        emit(ExpenseFailureState(message: 'Something went wrong'));
      }
    }
  }

  Future<void> _onGetbyID(
    GetExpenseByIDEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoadingState());
    try {
      final id = event.id;

      final expense = await personalExpenseUsecase.getExpensebyId(id);
      emit(ExpenseLoadedState(expense: expense));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          ExpenseUnauthState(message: 'Session Expired! Please LogIn again'),
        );
      } else if (e is GenPurposeException) {
        emit(ExpenseFailureState(message: e.message));
      } else {
        emit(ExpenseFailureState(message: 'Something went wrong'));
      }
    }
  }

  Future<void> _onEdit(
    EditExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoadingState());
    try {
      final category = expenseCategories[event.categoryIndex].apiValue;
      final data = await personalExpenseUsecase.editExpense(
        Expense(
          id: event.id,
          title: event.title,
          amount: event.amount,
          date: event.date,
          category: category,
          currency: event.currency,
        ),
      );

      emit(ExpenseCreatedState(message: data));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          ExpenseUnauthState(message: 'Session Expired! Please LogIn again'),
        );
      } else if (e is GenPurposeException) {
        emit(ExpenseFailureState(message: e.message));
      } else {
        emit(ExpenseFailureState(message: 'Something went wrong'));
      }
    }
  }

  Future<void> _onGet(ExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoadingState());
    try {
      final personalExpense = await personalExpenseUsecase.getPersonalExpense();
      emit(ExpenseLoadedState(personalExpense: personalExpense));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(
          ExpenseUnauthState(message: 'Session Expired! Please LogIn again'),
        );
      } else if (e is GenPurposeException) {
        emit(ExpenseFailureState(message: e.message));
      } else {
        emit(ExpenseFailureState(message: 'Something went wrong'));
      }
    }
  }
}
