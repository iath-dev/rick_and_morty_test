import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_test/src/widgets/widgets.dart';

class GridViewSkeleton extends StatelessWidget {
  const GridViewSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 15,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8.0, mainAxisSpacing: 8.0, crossAxisCount: 3),
      itemBuilder: (context, index) => SkeletonContainer(
        width: 50,
        height: 50,
        radius: BorderRadius.circular(75.0),
      ),
    );
  }
}
