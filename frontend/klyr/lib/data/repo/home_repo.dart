import 'package:dio/dio.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/group.dart';
import 'package:klyr/data/model/personal_expense.dart';
import 'package:klyr/data/model/summary_row.dart';
import 'package:klyr/network/authclient.dart';

class HomeRepo {
  Future<PersonalExpense> getPersonalExpense() async {
    try {
      final res = await Authclient.instance.get('/expense/personal');

      final data = res.data;
      return PersonalExpense.fromJson(data);
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

  Future<GroupList> getGroups() async {
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

  Future<HomeSummary> getSummary() async {
    try {
      final res = await Authclient.instance.get('/home');

      final HomeSummary hs = HomeSummary.fromJson(res.data);
      return hs;
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
