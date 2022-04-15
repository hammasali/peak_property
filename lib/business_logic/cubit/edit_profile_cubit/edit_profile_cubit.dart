import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/user_info_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  void updateProfile(XFile? image, String name, String username, String phoneNo,
      String email, String about) async {
    try {
      emit(EditProfileLoading());
      UserInfoModel model = UserInfoModel(
          name: name,
          username: username,
          phoneNo: phoneNo,
          email: email,
          aboutUser: about,
          profilePhoto: image);
      await FirebaseRepo.instance.updateProfile(model);
      emit(EditProfileSuccess(model));
    } on PlatformException catch (e) {
      emit(EditProfileUnSuccess(e.message.toString()));
    } on FirebaseException catch (e) {
      emit(EditProfileUnSuccess(e.message.toString()));
    } catch (e) {
      emit(EditProfileUnSuccess(e.toString()));
    }
  }
}
