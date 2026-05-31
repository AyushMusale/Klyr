import 'package:klyr/data/repo/home_repo.dart';
import 'package:klyr/data/repo/personal_expense_repo.dart';
import 'package:klyr/domain/usecase/home_usecase.dart';
import 'package:klyr/domain/usecase/personal_expense_usecase.dart';

class Injection {
  late final PersonalExpenseRepo personalExpenseRepo;
  late final PersonalExpenseUsecase personalExpenseUsecase;
  late final HomeRepo homeRepo;
  late final HomeUsecase homeUsecase;

  Future<void> init() async {
    //repo
    personalExpenseRepo = PersonalExpenseRepo();
    homeRepo = HomeRepo();

    //usecase
    personalExpenseUsecase = PersonalExpenseUsecase(
      personalExpenseRepo: personalExpenseRepo,
    );
    homeUsecase = HomeUsecase(homeRepo: homeRepo);
  }
}
