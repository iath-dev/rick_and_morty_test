import 'package:flutter/material.dart';
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
            backgroundColor: theme.primaryColor,
            floating: false,
            pinned: true,
            iconTheme: theme.iconTheme,
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
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.list(children: [
              Text(arg.value.name, style: theme.textTheme.headlineLarge),
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
                dense: true,
                title: const Text('No. Episodes'),
                trailing: Text(arg.value.episode.length.toString()),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
