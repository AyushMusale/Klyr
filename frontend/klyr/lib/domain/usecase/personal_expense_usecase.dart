import 'package:klyr/data/model/expense.dart';
import 'package:klyr/data/repo/personal_expense_repo.dart';

class PersonalExpenseUsecase {
  PersonalExpenseRepo personalExpenseRepo;

  PersonalExpenseUsecase({required this.personalExpenseRepo});

  Future<String> createPersonalExpense(Expense expense) async {
    try {
      return await personalExpenseRepo.createPersonalExpense(expense: expense);
    } catch (e) {
      rethrow;
    }
  }

  Future<Expense> getExpensebyId(int id) async {
    try {
      return await personalExpenseRepo.getExpensebyId(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> editExpense(Expense expense) async {
    try {
      return await personalExpenseRepo.editExpense(expense);
    } catch (e) {
      rethrow;
    }
  }
}
