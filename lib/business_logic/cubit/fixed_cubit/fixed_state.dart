part of 'fixed_cubit.dart';

@immutable
abstract class FixedState {}

class FixedInitial extends FixedState {}

class FixedLoading extends FixedState {}

class FixedSuccess extends FixedState {
  final List<UploadModel> homes, plot, commercial;

  FixedSuccess(this.homes, this.plot, this.commercial);
}

class FixedUnSuccess extends FixedState {
  final String? msg;

  FixedUnSuccess({this.msg});
}

