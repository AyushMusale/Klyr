import 'package:klyr/data/model/group.dart';
import 'package:klyr/data/model/personal_expense.dart';
import 'package:klyr/data/model/summary_row.dart';
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

  Future<GroupList> getGroups() async {
    try {
      return await homeRepo.getGroups();
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeSummary> getSummary() async {
    try {
      return await homeRepo.getSummary();
    } catch (e) {
      rethrow;
    }
  }
}
