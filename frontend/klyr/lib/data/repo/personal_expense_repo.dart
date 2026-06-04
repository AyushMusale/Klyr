import 'package:dio/dio.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/expense.dart';
import 'package:klyr/data/model/personal_expense.dart';
import 'package:klyr/network/authclient.dart';

class PersonalExpenseRepo {
  Future<String> createPersonalExpense({required Expense expense}) async {
    try {
      final res = await Authclient.instance.post(
        '/expense/personal/create',
        data: {
          'amount': expense.amount,
          'title': expense.title,
          'category': expense.category,
          'currency': expense.currency,
          'created_at': expense.date.toString(),
        },
      );

      if (res.statusCode == 201) {
        final data = res.data;
        return data['message'];
      } else {
        throw GenPurposeException('failure');
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

  Future<Expense> getExpensebyId(int id) async {
    try {
      final res = await Authclient.instance.get('/expense/personal/$id');
      final data = res.data;
      final expense = Expense.fromJson(data['expense']);
      return expense;
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
      } else {
        throw GenPurposeException('Something went wrong');
      }
    }
  }

  Future<String> editExpense(Expense expense) async {
    try {
      final res = await Authclient.instance.put(
        '/expense/personal/${expense.id!}',
        data: {
          "amount": expense.amount,
          "title": expense.title,
          "category": expense.category,
          "currency": expense.currency,
          "created_at": expense.date.toString(),
        },
      );

      final data = res.data['message'];

      return data;
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
      } else {
        throw GenPurposeException('Something went wrong');
      }
    }
  }
}
