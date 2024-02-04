import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:rick_and_morty_test/src/widgets/widgets.dart';

class CharacterGrid extends StatefulWidget {
  const CharacterGrid(
      {Key? key, required this.characters, this.onLoad, required this.tag})
      : super(key: key);

  final List<CharacterData> characters;
  final String tag;
  final Function? onLoad;

  @override
  State<CharacterGrid> createState() => _CharacterGridState();
}

class _CharacterGridState extends State<CharacterGrid> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 0.0)
      ..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: false,
      radius: const Radius.circular(4.0),
      thickness: .5,
      child: GridView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.characters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .9,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0),
        itemBuilder: (context, index) => CharacterAvatar(
          tag: widget.tag,
          data: widget.characters[index],
        ),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        widget.onLoad != null) {
      widget.onLoad!();
    }
  }
}
