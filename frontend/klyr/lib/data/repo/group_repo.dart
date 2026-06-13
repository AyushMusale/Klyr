import 'package:dio/dio.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/group.dart';
import 'package:klyr/data/model/group_expense.dart';
import 'package:klyr/data/model/summary_row.dart';
import 'package:klyr/network/authclient.dart';

class GroupRepo {
  Future<String> createGroup({required Group group}) async {
    try {
      final res = await Authclient.instance.post(
        '/expense/group/create',
        data: {'group_name': group.groupName, 'emails': group.members},
      );
      final data = res.data;
      return data['message'];
    } catch (e) {
      if (e is DioException && e.error is UnauthorizedException) {
        throw UnauthorizedException();
      } else if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'];

        if (statusCode == 400) {
          throw GenPurposeException(message ?? 'Validation error');
        } else if (statusCode == 404) {
          throw GenPurposeException(message ?? 'Not found');
        } else if (statusCode == 409) {
          throw GenPurposeException(message ?? 'Conflict');
        } else {
          throw GenPurposeException(message ?? 'Something went wrong');
        }
      }
      rethrow;
    }
  }

  Future<GroupList> getALlGroups() async {
    try {
      final res = await Authclient.instance.get('/expense/group/get');

      final list = GroupList.fromJson(res.data);
      return list;
    } catch (e) {
      if (e is DioException && e.error is UnauthorizedException) {
        throw UnauthorizedException();
      } else if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'];

        if (statusCode == 400) {
          throw GenPurposeException(message ?? 'Validation error');
        } else if (statusCode == 404) {
          throw GenPurposeException(message ?? 'Not found');
        } else if (statusCode == 409) {
          throw GenPurposeException(message ?? 'Conflict');
        } else {
          throw GenPurposeException(message ?? 'Something went wrong');
        }
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroupByID({required String id}) async {
    try {
      final res = await Authclient.instance.get('/expense/group/get-one/$id');
      final Group group = Group.fromJson(res.data['group']);
      final GroupSummary summary = GroupSummary.fromJson(res.data['summary']);
      final List<GroupExpense> expense =
          (res.data['expenses'] as List<dynamic>)
              .map((e) => GroupExpense.fromJson(e as Map<String, dynamic>))
              .toList();

      final groupData = {
        "group": group,
        "summary": summary,
        "expenses": expense,
      };
      return groupData;
    } catch (e) {
      if (e is DioException && e.error is UnauthorizedException) {
        throw UnauthorizedException();
      } else if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'];
        if (statusCode == 400) {
          throw GenPurposeException(message ?? 'Validation error');
        } else if (statusCode == 404) {
          throw GenPurposeException(message ?? 'Not found');
        } else if (statusCode == 409) {
          throw GenPurposeException(message ?? 'Conflict');
        } else {
          throw GenPurposeException(message ?? 'Something went wrong');
        }
      }
      rethrow;
    }
  }

  Future<String> createExpense({
    required GroupExpense groupExpense,
    required int groupId,
  }) async {
    try {
      final res = await Authclient.instance.post(
        "/expense/group/$groupId/create-expense",
        data: {
          "title": groupExpense.expense.title,
          "amount": groupExpense.expense.amount,
          "category": groupExpense.expense.category,
          "currency": "INR",
          "split_type": groupExpense.expense.splitType?.trim(),
          "paid_by": groupExpense.paidBy,
          "participants":
              groupExpense.members
                  .map((m) => {'email': m.email, "share_amount": m.shareAmount})
                  .toList(),
        },
      );

      return res.data['message'];
    } catch (e) {
      if (e is DioException && e.error is UnauthorizedException) {
        throw UnauthorizedException();
      } else if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'];

        if (statusCode == 400) {
          throw GenPurposeException(message ?? 'Validation error');
        } else if (statusCode == 404) {
          throw GenPurposeException(message ?? 'Not found');
        } else if (statusCode == 409) {
          throw GenPurposeException(message ?? 'Conflict');
        } else {
          throw GenPurposeException(message ?? 'Something went wrong');
        }
      }
      rethrow;
    }
  }
}
