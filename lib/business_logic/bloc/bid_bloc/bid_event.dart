part of 'bid_bloc.dart';

@immutable
abstract class BidEvent {}

class FetchBids extends BidEvent {}

class GetBidUrls extends BidEvent {
  final UploadModel model;

  GetBidUrls(this.model);
}

class PlaceBid extends BidEvent {
  final String price,image,docId;

  PlaceBid(this.price,this.image,this.docId);
}