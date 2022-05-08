import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/models/user_info_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  final List<UploadModel> model = [];

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

  void getUserProfile(String uid) async {
    if(uid.isNotEmpty) {
      await FirebaseRepo.instance.getUserProfile(uid).get().then((value) async {
      emit(UserProfileSuccessState(
          userInfoModel: UserInfoModel.fromMap(
              value.data() as Map<String, dynamic>,
              await FirebaseRepo.instance.getUserProfilePic(uid)),
          uploadModel: model));
    });
    }
  }

  void getCurrentUserProfile() async {
    try {
      emit(EditProfileLoading());

      await FirebaseRepo.instance
          .getCurrentUserFixedHomes()
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (var e in value.docs) {
            final String url = await FirebaseRepo.instance
                .downloadAllUserURLs(e.get('uid'), e.get('pickedFilesName')[0]);
            model.add(UploadModel.fromMap(
                e.data() as Map<String, dynamic>, url, e.id));
          }
        }
      });

      String? id = FirebaseRepo.instance.getCurrentUser()?.uid;

      await FirebaseRepo.instance
          .getUserProfile(id.toString())
          .get()
          .then((value) async {
        emit(UserProfileSuccessState(
            userInfoModel: UserInfoModel.fromMap(
                value.data() as Map<String, dynamic>,
                await FirebaseRepo.instance.getUserProfilePic(id.toString())),
            uploadModel: model));
      });
    } on PlatformException catch (e) {
      emit(EditProfileUnSuccess(e.message.toString()));
    } on FirebaseException catch (e) {
      emit(EditProfileUnSuccess(e.message.toString()));
    } catch (e) {
      emit(EditProfileUnSuccess(e.toString()));
    }
  }
}
