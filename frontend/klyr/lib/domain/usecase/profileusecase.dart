import 'package:klyr/data/localdb/profiledb.dart';
import 'package:klyr/data/model/profile.dart';
import 'package:klyr/data/repo/profilerepo.dart';

class Profileusecase {
  final Profilerepo _profilerepo = Profilerepo();
  Future<ProfileModel> saveProfile(ProfileModel data) async {
    try {
      final profile = await _profilerepo.saveProfile(data);
      await ProfileStorage.saveProfile(profile.toMap());
      return profile;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel> getProfile()async{
    try{
      final profile = await ProfileStorage.getProfile();
      if(profile == null){
        final profile = await _profilerepo.getProfile();
        await ProfileStorage.saveProfile(profile.toMap());
        return profile;
      }
      else{
        return ProfileModel.fromMap(profile);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<String> clearProfile()async{
    try{
      await ProfileStorage.clearProfile();
      return 'success';
    }
    catch(e){
      rethrow;
    }
  }
}
