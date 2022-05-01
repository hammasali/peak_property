import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'bookmark_event.dart';

part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  var newVal = false;
  final List<UploadModel> bookmark = [];

  BookmarkBloc() : super(BookmarkInitial()) {
    // on<FetchAllBookmarks>((event, emit) async {
    //   try {
    //     emit(BookmarkLoading());
    //     bookmark.clear();
    //     final QuerySnapshot data =
    //         await FirebaseRepo.instance.fetchBookmark().get();
    //
    //
    //     for (var e in data.docs) {
    //       final String url = await FirebaseRepo.instance
    //           .downloadAllUserURLs(e.get('uid'), e.get('pickedFilesName')[0]);
    //
    //       bookmark.add(
    //           UploadModel.fromMap(e.data() as Map<String, dynamic>, url, e.id));
    //     }
    //     emit(BookmarkSuccessState(model: bookmark, isBookmarked: newVal));
    //   } on FirebaseException catch (e) {
    //     emit(BookmarkUnSuccessState('Unexpected Error ${e.code}'));
    //   } catch (e) {
    //     emit(BookmarkUnSuccessState('Unexpected Error ${e.toString()}'));
    //   }
    // });

    on<IsBookmarked>((event, emit) async {
      newVal = !event.value;
      newVal
          ? await FirebaseRepo.instance.addBookmark(event.model)
          : await FirebaseRepo.instance.removeBookmark(event.model.docId);

      emit(BookmarkSuccessState(isBookmarked: newVal, model: bookmark));
    });
  }
}
