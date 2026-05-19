import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/exception/authexception.dart';
import 'package:klyr/data/exception/generalpurposeexception.dart';
import 'package:klyr/data/localdb/authdb.dart';
import 'package:klyr/data/localdb/profiledb.dart';
import 'package:klyr/domain/usecase/profileusecase.dart';
import 'package:klyr/presentation/profile/bloc/profileevents.dart';
import 'package:klyr/presentation/profile/bloc/profilestate.dart';

class Profilebloc extends Bloc<Profileevents, Profilestate>{
  final Profileusecase _profileusecase = Profileusecase();
  Profilebloc():super(ProfileInitialstate()){
    on<SaveProfileEvent>(_saveProfiel);
    on<GetProfileEvent>(_getProfiel);
  }


  //save Profile
  Future<void> _saveProfiel(SaveProfileEvent event, Emitter emit)async{
    emit(Profilestate(isLoading: true, isError: false, isSuccess: false, message: 'loading..'));
    try{
      final data = await _profileusecase.saveProfile(event.profileModel);
      emit(Profilestate(isLoading: false, isError: false, isSuccess: true, message: 'Profile Saved', profile: data));
    }catch(e){
      if(e is UnauthorizedException){
        await ProfileStorage.clearProfile();
        await TokenStorage.clearTokens();
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: 'unauthorized'));
      }
      else if(e is GenPurposeException){
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: e.message));
      }
      else{
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: 'unknown error occured'));
      }
    }
  }

  //Get Profile 
  Future<void> _getProfiel(GetProfileEvent event, Emitter emit)async{
    emit(Profilestate(isLoading: true, isError: false, isSuccess: false, message: 'loading..'));
    try{
      final data = await _profileusecase.getProfile();
      emit(Profilestate(isLoading: false, isError: false, isSuccess: true, message: 'Profile Loaded', profile: data));
    }catch(e){
      if(e is UnauthorizedException){
        await ProfileStorage.clearProfile();
        await TokenStorage.clearTokens();
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: 'unauthorized'));
      }
      else if(e is GenPurposeException && e.message !='empty'){
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: e.message));
      }
      else if(e is GenPurposeException && e.message =='empty'){
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: "Create Profile"));
      }
      else{
        emit(Profilestate(isLoading: false, isError: true, isSuccess: false, message: 'unknown error occured'));
      }
    }
  }
}