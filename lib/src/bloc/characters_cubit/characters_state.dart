part of 'characters_cubit.dart';

abstract class CharactersState {
  final List<CharacterData> characters = [];
}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterData> characters;

  CharactersLoaded({required this.characters});
}
