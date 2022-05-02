part of 'bid_bloc.dart';

@immutable
abstract class BidState {}

class BidInitial extends BidState {}

class BidLoading extends BidState {}

class BidSuccess extends BidState {
  final List<UploadModel> model;
  final List<String> url;
  final BidersModel? bidModel;

  BidSuccess({required this.model, required this.url,  this.bidModel});
}

class BidUnSuccess extends BidState {
  final String msg;

  BidUnSuccess(this.msg);
}
