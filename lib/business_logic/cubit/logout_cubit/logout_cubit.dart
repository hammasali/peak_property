import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  void logOut() async {
    try {
      emit(LogoutLoadingState());
      await FirebaseRepo.instance.signOutUser();
      emit(LogoutSuccessState());
    } on PlatformException catch (e) {
      emit(LogoutUnSuccessState(message: e.message));
    } on FirebaseAuthException catch (e) {
      emit(LogoutUnSuccessState(message: e.message));
    }
  }
}
