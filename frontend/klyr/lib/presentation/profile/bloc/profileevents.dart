import 'package:klyr/data/model/profile.dart';

class Profileevents {}

class SaveProfileEvent extends Profileevents{
  ProfileModel profileModel;
  SaveProfileEvent({
    required this.profileModel
  });
}

class GetProfileEvent extends Profileevents{}