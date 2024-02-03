import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/services/api_service.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final ApiService service;
  int page = 1;

  CharactersCubit(this.service) : super(CharactersLoading()) {
    loadCharacters();
  }

  void loadCharacters() async {
    final data = await service.getCharacters(page);

    if (data != null) {
      emit(
          CharactersLoaded(characters: [...state.characters, ...data.results]));

      if (data.info.next.isEmpty) {
        page++;
      }
    }
  }
}
