import 'package:dio/dio.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/personal_expense.dart';
import 'package:klyr/network/authclient.dart';

class HomeRepo {
  Future<PersonalExpense> getPersonalExpense() async {
    try {
      final res = await Authclient.instance.get('/expense/personal');

      if (res.statusCode != 200) {
        throw GenPurposeException(res.data['message']);
      } else {
        final data = res.data;
        return PersonalExpense.fromJson(data);
      }
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
