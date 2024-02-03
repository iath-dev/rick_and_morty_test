import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/bloc/bloc.dart';
import 'package:rick_and_morty_test/src/helpers/helpers.dart';
import 'package:rick_and_morty_test/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rick & Morty',
                            style: theme.textTheme.displaySmall),
                        Text('Characters list',
                            style: theme.textTheme.titleSmall),
                      ],
                    ),
                  ),
                  IconButton.outlined(
                      onPressed: () => showSearch(
                          context: context,
                          delegate: CharacterSearchDelegate()),
                      icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: BlocBuilder<CharactersCubit, CharactersState>(
                  builder: (context, state) {
                    if (state is CharactersLoaded) {
                      return CharacterGrid(
                        tag: 'home',
                        characters: state.characters,
                        onLoad: () =>
                            context.read<CharactersCubit>().loadCharacters(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
