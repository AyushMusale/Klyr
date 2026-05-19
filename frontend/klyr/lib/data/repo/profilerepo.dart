
import 'package:dio/dio.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/model/profile.dart';
import 'package:klyr/network/authclient.dart';

class Profilerepo {
  Future<ProfileModel> saveProfile(ProfileModel profile) async {
    try {
      final response = await Authclient.instance.post(
        '/profile',
        data: profile.toJson(),
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw GenPurposeException(data['message']);
      } else {
        return ProfileModel.fromJson(data['profile']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel> getProfile() async {
    try {
      final res = await Authclient.instance.get('/profile');
      final data = res.data;
      return  ProfileModel.fromJson(data['profile']);
    } on DioException catch (e) {
      print(e);
      if(e.response?.statusCode == 404){
        throw GenPurposeException('empty');
      }
      else{
        throw GenPurposeException(e.response?.data['message']);
      }
    }
  }
}
