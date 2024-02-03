import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/src/services/api_service.dart';
import 'package:rick_and_morty_test/src/widgets/characters_grid.dart';

class CharacterSearchDelegate extends SearchDelegate {
  ApiService service = ApiService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.cancel))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyContainer();
    }

    return FutureBuilder(
        future: service.searchCharacter(query),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: CharacterGrid(
                tag: 'search',
                characters: snapshot.data!.results,
              ),
            );
          } else {
            return const _EmptyContainer();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const _EmptyContainer();
  }
}

class _EmptyContainer extends StatelessWidget {
  const _EmptyContainer();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.live_tv_rounded,
        // color: Colors.black38,
        size: 100,
      ),
    );
  }
}
