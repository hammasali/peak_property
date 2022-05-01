part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccessState extends BookmarkState {
  final bool isBookmarked;
   List<UploadModel> model;


  BookmarkSuccessState({required this.isBookmarked,required this.model});
}

class BookmarkUnSuccessState extends BookmarkState {
  final String msg;

  BookmarkUnSuccessState(this.msg);
}

// class BookmarkFetchState extends BookmarkState {
//   final List<UploadModel> model;
//
//   BookmarkFetchState(this.model);
// }

