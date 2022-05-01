part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {}

class IsBookmarked extends BookmarkEvent {
  bool value;
  final UploadModel model;

  IsBookmarked(this.value, this.model);
}

class FetchAllBookmarks extends BookmarkEvent{}
