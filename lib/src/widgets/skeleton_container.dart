import 'package:flutter/material.dart';

class SkeletonContainer extends StatefulWidget {
  const SkeletonContainer(
      {Key? key,
      required this.width,
      required this.height,
      this.radius = BorderRadius.zero})
      : super(key: key);

  final double width, height;
  final BorderRadius radius;

  @override
  State<SkeletonContainer> createState() => _SkeletonContainerState();
}

class _SkeletonContainerState extends State<SkeletonContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Durations.medium2)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.radius,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: const [
                0.0,
                .5,
                1.0
              ]),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: const Offset(1.0, 0.0),
          ).animate(_controller),
          child: Container(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
