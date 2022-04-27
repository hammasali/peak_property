import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  void isBookmarked(bool value, UploadModel model) async {
    var newVal = !value;
    newVal
        ? await FirebaseRepo.instance.addBookmark(model)
        : await FirebaseRepo.instance.removeBookmark(model.docId);

    emit(BookmarkSuccessState(isBookmarked: newVal));
  }
}
