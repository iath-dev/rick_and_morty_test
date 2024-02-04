import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:rick_and_morty_test/src/services/services.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final ApiService service;
  int page = 1;
  bool isMore = true;

  CharactersCubit(this.service) : super(CharactersLoading()) {
    loadCharacters();
  }

  void loadCharacters() async {
    if (!isMore) return;

    final data = await service.getCharacters(page);

    if (data != null) {
      emit(CharactersLoaded(characters: state.characters + data.results));

      page = data.info.next.isNotEmpty ? page + 1 : page;
      isMore = data.info.next.isNotEmpty;
    }
  }
}
