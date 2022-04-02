part of 'image_cubit.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageSuccess extends ImageState {
  final List<XFile>? imageFileList;

  ImageSuccess({this.imageFileList});
}

class ImageUnSuccess extends ImageState {
  String? message;

  ImageUnSuccess({this.message});
}

