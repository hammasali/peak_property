import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;

  ImageCubit() : super(ImageInitial());

  Future<void> onImageButtonPressed(ImageSource source,
      {bool isMultiImage = false, bool isProfileImage = false}) async {
    if (isMultiImage) {
      try {
        _imageFileList = await _picker.pickMultiImage();

        emit(ImageSuccess(imageFileList: _imageFileList));
      } catch (e) {
        emit(ImageUnSuccess(message: e.toString()));
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        _imageFileList = pickedFile == null ? null : <XFile>[pickedFile];
        isProfileImage
            ? emit(ProfileImageSuccess(imageFileList: _imageFileList?[0]))
            : emit(ImageSuccess(imageFileList: _imageFileList));

      } catch (e) {
        emit(ImageUnSuccess(message: e.toString()));
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      final XFile? pickedFile = response.file;
      _imageFileList =
          pickedFile == null ? response.files : <XFile>[pickedFile];

      emit(ImageSuccess(imageFileList: _imageFileList));
    } else {
      emit(ImageUnSuccess(message: response.exception!.code));
    }
  }

  removePhoto(int index) {
    _imageFileList!.removeAt(index);
    emit(ImageSuccess(imageFileList: _imageFileList));
  }
}
