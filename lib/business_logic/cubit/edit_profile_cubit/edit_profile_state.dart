part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}


class EditProfileSuccess extends EditProfileState {
  final UserInfoModel userInfoModel;

  EditProfileSuccess(this.userInfoModel);
}

class EditProfileUnSuccess extends EditProfileState {
  final String message;

  EditProfileUnSuccess(this.message);
}

class UserProfileSuccessState extends EditProfileState {
  final UserInfoModel model ;

  UserProfileSuccessState(this.model);
}
