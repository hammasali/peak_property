import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/user_info_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  void signUpButtonPressedEvent(
      String email, String password, String name) async {
    try {
      emit(RegistrationLoadingState());

      var user = await FirebaseRepo.instance.createUser(email, password);

      if (user != null) {
        String _createdAt =
            DateFormat('EEE, MMM d, ' 'yyyy h:mm a').format(DateTime.now());

        UserInfoModel _userInfoModel = UserInfoModel(
            name: name.trim(), email: email.trim(), createdAt: _createdAt);

        await FirebaseRepo.instance.addNewUserData(_userInfoModel.toMap());
        emit(RegistrationSuccessfulState(user: user));
      }
    }

    //==================Errors=======================
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegistrationUnsuccessfulState(
            message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegistrationUnsuccessfulState(
            message: 'The account already exists for that email.'));
      } else if (e.code == 'user-not-found') {
        emit(RegistrationUnsuccessfulState(
            message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(RegistrationUnsuccessfulState(
            message: 'Wrong password provided for that user.'));
      } else if (e.message == 'Given String is empty or null') {
        emit(RegistrationUnsuccessfulState(
            message: 'Please provide credentials'));
      } else {
        emit(RegistrationUnsuccessfulState(message: e.code));
      }
    } on PlatformException catch (e) {
      emit(RegistrationUnsuccessfulState(message: e.code));
    } on String catch (e) {
      emit(RegistrationUnsuccessfulState(message: e));
    }
  }

  void googleSignInEvent() async {
    emit(RegistrationGoogleLoadingState());

    var userCredential = await FirebaseRepo.instance.signInWithGoogle();

    if (userCredential.user != null) {
      emit(RegistrationSuccessfulState(user: userCredential.user));
    }
  }

}
