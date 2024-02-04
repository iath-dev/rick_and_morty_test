import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_test/src/models/models.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  Chip(
                      label: Text(arg.value.status),
                      shape: LinearBorder.none,
                      avatar: Icon(Icons.circle,
                          color: statusColor[arg.value.status], size: 8.0),
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
            ),
            const Divider(),
            ListTile(
              dense: true,
              title: const Text('Location'),
              trailing: Text(arg.value.location.name),
            ),
            // ...arg.value.episode.map((e) => _EpisodeTile(uri: e)).toList()
          ]),
          SliverToBoxAdapter(
            child: ListTile(
              title: const Text('Episodes'),
              trailing: Text(arg.value.episode.length.toString()),
            ),
          ),
          _EpisodeList(urls: arg.value.episode)
        ],
      ),
    );
  }
}

class _EpisodeList extends StatefulWidget {
  const _EpisodeList({Key? key, required this.urls}) : super(key: key);

  final List<String> urls;

  @override
  State<_EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<_EpisodeList> {
  Map<String, RickMortyEpisode> cachedData = {};

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: widget.urls.length,
        itemBuilder: (context, index) => FutureBuilder(
            future: _fetchData(widget.urls[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(
                    dense: true,
                    trailing: CircularProgressIndicator.adaptive(),
                    title: Text('Loading'));
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
            }));
  }

  Future<RickMortyEpisode> _fetchData(String uri) async {
    if (cachedData.containsKey(uri)) {
      return cachedData[uri]!;
    }

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      cachedData[uri] = RickMortyEpisode.fromRawJson(response.body);

      return RickMortyEpisode.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}
