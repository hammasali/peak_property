part of 'bookmark_cubit.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkSuccessState extends BookmarkState {
  final bool isBookmarked;

  BookmarkSuccessState({required this.isBookmarked});
}