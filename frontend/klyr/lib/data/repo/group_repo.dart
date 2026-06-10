import 'package:dio/dio.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/group.dart';
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

  Future<Group> getGroupByID({required String id}) async {
    try {
      final res = await Authclient.instance.get('/expense/group/get-one/$id');
      final data = res.data['group'];
      final group = Group.fromJson(data);
      return group;
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
