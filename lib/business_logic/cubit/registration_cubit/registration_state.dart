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

class ValidateNameState extends RegistrationState {
  final bool isValid;

  ValidateNameState(this.isValid);
}

class ValidateEmailState extends RegistrationState {
  final bool isValid;

  ValidateEmailState(this.isValid);
}
class ValidatePasswordState extends RegistrationState {
  final bool isValid;

  ValidatePasswordState(this.isValid);
}
class ValidatePhoneNoState extends RegistrationState {
  final bool isValid;

  ValidatePhoneNoState(this.isValid);
}

class AgreeRulesState extends RegistrationState {
  final bool isValid;

  AgreeRulesState(this.isValid);
}

class UpdateState extends RegistrationState {
  final bool isValid;

  UpdateState(this.isValid);
}
