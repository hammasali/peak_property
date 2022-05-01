part of 'delete_property_cubit.dart';

@immutable
abstract class DeletePropertyState {}

class DeletePropertyInitial extends DeletePropertyState {}

class DeletePropertyLoading extends DeletePropertyState {}

class DeletePropertySuccess extends DeletePropertyState {}

class DeletePropertyUnSuccess extends DeletePropertyState {
  final String msg;

  DeletePropertyUnSuccess(this.msg);
}

