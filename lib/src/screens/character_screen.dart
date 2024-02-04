import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:http/http.dart' as http;

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final arg = (ModalRoute.of(context)!.settings.arguments
            as Map<String, CharacterData>)
        .entries
        .single;

    final Map<String, Color> statusColor = {
      "Alive": Colors.green,
      "Dead": Colors.red,
      "unknown": theme.colorScheme.onBackground.withOpacity(.75)
    };

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 300,
            backgroundColor: theme.colorScheme.background,
            floating: false,
            pinned: true,
            iconTheme: theme.iconTheme,
            title: Text(arg.value.name),
            leading: IconButton.outlined(
                onPressed: () => Navigator.pop(context),
                color: theme.colorScheme.onBackground,
                highlightColor: theme.colorScheme.background,
                icon: const Icon(Icons.arrow_back)),
            flexibleSpace: FlexibleSpaceBar(
                background: Hero(
              tag: '${arg.key}-${arg.value.id}',
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/rick_and_morty.png',
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                  image: arg.value.image),
            )),
          ),
          SliverList.list(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(arg.value.name, style: theme.textTheme.headlineLarge),
            ),
            Wrap(
              spacing: 8.0,
              children: [
                Chip(
                    label: Text(arg.value.status),
                    shape: LinearBorder.none,
                    labelStyle: theme.textTheme.labelSmall!
                        .copyWith(color: statusColor[arg.value.status])),
                Chip(
                    label: Text(arg.value.gender),
                    shape: LinearBorder.none,
                    labelStyle: theme.textTheme.labelSmall),
                Chip(
                    label: Text(arg.value.species),
                    shape: LinearBorder.none,
                    labelStyle: theme.textTheme.labelSmall),
              ],
            ),
            const Divider(),
            ListTile(
              dense: true,
              title: const Text('Location'),
              trailing: Text(arg.value.location.name),
            ),
            ListTile(
              title: const Text('Episodes'),
              trailing: Text(arg.value.episode.length.toString()),
            ),
            ...arg.value.episode.map((e) => _EpisodeTile(uri: e)).toList()
          ]),
        ],
      ),
    );
  }
}

class _EpisodeTile extends StatelessWidget {
  const _EpisodeTile({
    required this.uri,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTile(
                dense: true, trailing: Icon(Icons.tv), title: Text('Loading'));
          } else if (snapshot.hasError) {
            return ListTile(
                dense: true,
                trailing: const Icon(Icons.error, color: Colors.red),
                title: Text('Error: ${snapshot.error}'));
          } else {
            return FadeIn(
              child: ListTile(
                  dense: true,
                  title: Text(snapshot.data!.name),
                  subtitle: Text(snapshot.data!.airDate),
                  trailing: Text(snapshot.data!.episode)),
            );
          }
        });
  }

  Future<RickMortyEpisode> _getData() async {
    final url = Uri.parse(uri);
    final req = await http.get(url);

    return RickMortyEpisode.fromRawJson(req.body);
  }
}
