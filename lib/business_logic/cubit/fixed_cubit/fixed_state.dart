part of 'fixed_cubit.dart';

@immutable
abstract class FixedState {}

class FixedInitial extends FixedState {}

class FixedLoading extends FixedState {}

class FixedSuccess extends FixedState {
  final List<UploadModel> uploadModel;

  FixedSuccess(this.uploadModel);
}

class FixedUnSuccess extends FixedState {
  final String? msg;

  FixedUnSuccess({this.msg});
}
