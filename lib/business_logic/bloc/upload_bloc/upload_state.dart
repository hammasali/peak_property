part of 'upload_bloc.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class PriceRangeState extends UploadState {
  final double start,end;

  PriceRangeState(this.start,this.end);
}

class TimeframeState extends UploadState {
  final int value;

  TimeframeState(this.value);
}

class AreaRangeState extends UploadState {
  final double val;

  AreaRangeState(this.val);
}

class AreaRangeUnitState extends UploadState {
  final String unit;

  AreaRangeUnitState(this.unit);
}

class BedroomState extends UploadState {
  final int value;

  BedroomState(this.value);
}

class BathroomState extends UploadState {
  final int value;

  BathroomState(this.value);
}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final UploadModel uploadModel;

  UploadSuccess(this.uploadModel);
}

class UploadUnSuccess extends UploadState {
  final String message;

  UploadUnSuccess(this.message);
}
