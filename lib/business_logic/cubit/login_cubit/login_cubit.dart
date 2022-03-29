import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void signInButtonPressedEvent(String email, String password) async {
    try {
      emit(LoginLoadingState());
      var user =
          await FirebaseRepo.instance.signInUser(email.trim(), password.trim());
      emit(LoginSuccessState(user));
    }

    //==================Errors=======================
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
            LoginUnSuccessState(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(LoginUnSuccessState(
            message: 'The account already exists for that email.'));
      } else if (e.code == 'user-not-found') {
        emit(LoginUnSuccessState(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginUnSuccessState(
            message: 'Wrong password provided for that user.'));
      } else if (e.message == 'Given String is empty or null') {
        emit(LoginUnSuccessState(message: 'Please provide credentials'));
      } else {
        emit(LoginUnSuccessState(message: e.code));
      }
    } on PlatformException catch (e) {
      emit(LoginUnSuccessState(message: e.code));
    } on String catch (e) {
      emit(LoginUnSuccessState(message: e));
    } catch (e) {
      emit(LoginUnSuccessState(message: e.toString()));
    }
  }

  void forgetPasswordButtonPressedEvent(String email) async {
    try {
      emit(LoginLoadingState());
      await FirebaseRepo.instance
          .resetPassword(email.trim())
          .whenComplete(() => throw 'Check your email to reset the password');
    } on FirebaseAuthException catch (e) {
      emit(LoginUnSuccessState(message: e.code));
    } on String catch (e) {
      emit(LoginUnSuccessState(message: e));
    } catch (e) {
      emit(LoginUnSuccessState(message: e.toString()));
    }
  }
}
