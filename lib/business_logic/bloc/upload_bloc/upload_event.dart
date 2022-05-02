part of 'upload_bloc.dart';

@immutable
abstract class UploadEvent {}

class PriceRangeEvent extends UploadEvent {
  final double start, end;

  PriceRangeEvent(this.start, this.end);
}

class TimeFrameEvent extends UploadEvent {
  final int val;

  TimeFrameEvent(this.val);
}

class AreaRangeEvent extends UploadEvent {
  final double val;

  AreaRangeEvent(this.val);
}

class AreaRangeUnitEvent extends UploadEvent {
  final String val;

  AreaRangeUnitEvent(this.val);
}

class BedroomEvent extends UploadEvent {
  final int val;

  BedroomEvent(this.val);
}

class BathroomEvent extends UploadEvent {
  final int val;

  BathroomEvent(this.val);
}

class UploadButtonEvent extends UploadEvent {
  final String? state,
      city,
      address,
      title,
      description,
      category,
      type,
      startPrice,
      endPrice,
      areaRange,
      areaType,
      bedrooms,
      bathrooms,
      bidTime;
  final int? preference;
  final double? timeRange;

  final List<XFile>? pickedFile;

  UploadButtonEvent(
      {this.state,
      this.city,
      this.address,
      this.title,
      this.description,
      this.category,
      this.type,
      this.startPrice,
      this.endPrice,
      this.timeRange,
      this.bidTime,
      this.areaRange,
      this.areaType,
      this.bedrooms,
      this.bathrooms,
      this.preference,
      this.pickedFile});
}
