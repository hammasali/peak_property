part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User? user;

  LoginSuccessState(this.user);
}

class LoginUnSuccessState extends LoginState {
  final String message;

  LoginUnSuccessState({required this.message});
}
