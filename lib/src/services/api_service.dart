import 'package:rick_and_morty_test/src/config/config.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _api = Environment.apiUri;

  Future<RickMortyCharactersQuery?> getCharacters([int page = 1]) async {
    final Map<String, dynamic> params = {"page": page.toString()};

    final url = Uri.https(_api, 'api/character', params);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return RickMortyCharactersQuery.fromRawJson(res.body);
    }

    return null;
  }

  Future<RickMortyCharactersQuery?> searchCharacter(String name,
      [int page = 1]) async {
    final Map<String, dynamic> params = {"name": name, "page": page.toString()};

    final url = Uri.https(_api, 'api/character', params);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return RickMortyCharactersQuery.fromRawJson(res.body);
    }

    return null;
  }

  Future<CharacterData?> getCharacter(int id) async {
    final url = Uri.https(_api, 'api/character,$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return CharacterData.fromRawJson(res.body);
    }

    return null;
  }
}
