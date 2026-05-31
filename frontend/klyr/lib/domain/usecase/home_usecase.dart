import 'package:klyr/data/model/personal_expense.dart';
import 'package:klyr/data/repo/home_repo.dart';

class HomeUsecase {
  final HomeRepo homeRepo;

  HomeUsecase({required this.homeRepo});

  Future<PersonalExpense> getPersonalExpense() async {
    try {
      return await homeRepo.getPersonalExpense();
    } catch (e) {
      rethrow;
    }
  }
}
