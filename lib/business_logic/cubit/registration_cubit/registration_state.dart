part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}

class RegistrationGoogleLoadingState extends RegistrationState {}


class RegistrationSuccessfulState extends RegistrationState {
  final User? user;

  RegistrationSuccessfulState({this.user});
}

class RegistrationUnsuccessfulState extends RegistrationState {
  final String? message;

  RegistrationUnsuccessfulState({this.message});
}