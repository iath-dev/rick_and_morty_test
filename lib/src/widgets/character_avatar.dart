import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/src/models/models.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({Key? key, required this.tag, required this.data})
      : super(key: key);

  final String tag;
  final CharacterData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'character', arguments: {tag: data}),
      borderRadius: BorderRadius.circular(8),
      child: Center(
        child: Column(children: [
          Expanded(
            child: Hero(
              tag: '$tag-${data.id}',
              child: FadeIn(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(data.image),
                  maxRadius: 48,
                  minRadius: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ]),
      ),
    );
  }
}
