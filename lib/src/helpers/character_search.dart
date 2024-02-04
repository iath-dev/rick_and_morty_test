import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/bloc/bloc.dart';
import 'package:rick_and_morty_test/src/services/services.dart';
import 'package:rick_and_morty_test/src/widgets/widgets.dart';

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

    final provider = BlocProvider.of<SearchBloc>(context);

    provider.add(LoadCharacters(query: query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const _EmptyContainer(
              label: 'Loading...', child: CircularProgressIndicator());
        } else if (state is SearchError) {
          return _EmptyContainer(
              label: 'Error: ${state.msg}',
              child: const Icon(Icons.error, color: Colors.red));
        } else if (state is SearchLoaded && state.characters.isEmpty) {
          return _EmptyContainer(
              label: 'Not result found for $query',
              child: const Icon(Icons.search_off));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CharacterGrid(
              tag: 'search',
              characters: state.characters,
              onLoad: () => provider.add(LoadMore()),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyContainer();
    }

    return FutureBuilder(
        future: service.searchCharacter(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _EmptyContainer(
                label: 'Loading...', child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _EmptyContainer(
                label: 'Error: ${snapshot.error}',
                child: const Icon(Icons.error, color: Colors.red));
          } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
            return _EmptyContainer(
                label: 'Not result found for $query',
                child: const Icon(Icons.search_off));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.results.length,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                onTap: () => query = snapshot.data!.results[index].name,
                title: Text(snapshot.data!.results[index].name),
                subtitle: Text(snapshot.data!.results[index].location.name),
              ),
            );
          }
        });
  }
}

class _EmptyContainer extends StatelessWidget {
  const _EmptyContainer(
      {this.child = const Icon(Icons.live_tv_rounded, size: 100),
      this.label = ""});

  final Widget child;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(height: 16.0),
          Text(label, style: Theme.of(context).textTheme.titleSmall)
        ],
      ),
    );
  }
}
