part of 'fixed_detail_cubit.dart';

@immutable
abstract class FixedDetailState {}

class FixedDetailInitial extends FixedDetailState {}

class FixedDetailLoading extends FixedDetailState {}

class FixedDetailSuccess extends FixedDetailState {
  final List<String> url;

  FixedDetailSuccess(this.url);
}

class FixedDetailUnSuccess extends FixedDetailState {
  final String msg;

  FixedDetailUnSuccess(this.msg);
}



