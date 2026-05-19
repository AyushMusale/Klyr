import 'package:klyr/data/model/profile.dart';

class Profilestate {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String message;
  ProfileModel? profile;

  Profilestate({
    required this.isLoading,
    required this.isError,
    required this.isSuccess,
    required this.message,
    this.profile,
  });
}

class ProfileInitialstate extends Profilestate {
  ProfileInitialstate()
    : super(
        isLoading: false,
        isError: false,
        isSuccess: false,
        message: 'processing',
      );
}
