part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final List<CharacterData> characters = [];
  final int page = 1;
}

class SearchInitial extends SearchState {
  final List<CharacterData> characters = [];
  final int page = 1;

  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  final String msg;

  SearchError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class SearchLoaded extends SearchState {
  final List<CharacterData> characters;
  final int page;

  SearchLoaded(this.page, this.characters);

  @override
  List<Object?> get props => [page, characters];
}
