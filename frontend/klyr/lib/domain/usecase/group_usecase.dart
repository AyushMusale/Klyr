import 'package:klyr/data/model/group.dart';
import 'package:klyr/data/model/group_expense.dart';
import 'package:klyr/data/repo/group_repo.dart';

class GroupUsecase {
  final GroupRepo groupRepo;

  GroupUsecase({required this.groupRepo});

  Future<String> createGroup({required Group group}) async {
    try {
      return await groupRepo.createGroup(group: group);
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupList> getALlGroups() async {
    try {
      return await groupRepo.getALlGroups();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroupByID({required String id}) async {
    try {
      return await groupRepo.getGroupByID(id: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createExpense({
    required GroupExpense groupExpense,
    required int groupId,
  }) async {
    try {
      return await groupRepo.createExpense(
        groupExpense: groupExpense,
        groupId: groupId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
