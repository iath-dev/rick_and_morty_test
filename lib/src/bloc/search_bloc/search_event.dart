part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class LoadCharacters extends SearchEvent {
  final String query;

  LoadCharacters({required this.query});
}

class LoadMore extends SearchEvent {}
