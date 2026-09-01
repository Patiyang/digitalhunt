import 'dart:math' as math;

import 'package:flutter/material.dart';

class FlipPage extends StatelessWidget {
  final ScrollController controller;
  final int index;
  final double pageHeight;
  final Widget child;

  const FlipPage({
    super.key,
    required this.controller,
    required this.index,
    required this.pageHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,

      builder: (context, child) {
        final currentPosition =
            controller.hasClients
                ? controller.position.pixels
                : 0.0;

        final pageOffset =
            (index * pageHeight -
                    currentPosition) /
                pageHeight;

        final rotation =
            pageOffset.clamp(-1.0, 1.0);

        final scale =
            1.0 -
                (rotation.abs() * 0.08);

        final opacity =
            1.0 -
                (rotation.abs() * 0.15);

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),

          child: Transform(
            alignment: rotation > 0
                ? Alignment.topCenter
                : Alignment.bottomCenter,

            transform: Matrix4.identity()
              ..setEntry(
                3,
                2,
                0.0015,
              )
              ..rotateX(
                rotation * math.pi / 6,
              )
              ..scale(scale),

            child: child,
          ),
        );
      },

      child: child,
    );
  }
}

class CustomPageScrollPhysics extends ScrollPhysics {
  final double pageHeight;

  const CustomPageScrollPhysics({
    super.parent,
    required this.pageHeight,
  });

  @override
  CustomPageScrollPhysics applyTo(
    ScrollPhysics? ancestor,
  ) {
    return CustomPageScrollPhysics(
      parent: buildParent(ancestor),
      pageHeight: pageHeight,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (position.outOfRange) {
      return super.createBallisticSimulation(
        position,
        velocity,
      );
    }

    final double page =
        position.pixels / pageHeight;

    double targetPage;

    // Determine direction
    if (velocity.abs() > 100) {
      targetPage = velocity > 0
          ? page.ceilToDouble()
          : page.floorToDouble();
    } else {
      targetPage = page.roundToDouble();
    }

    targetPage = targetPage.clamp(
      0,
      position.maxScrollExtent / pageHeight,
    );

    final targetPixels =
        targetPage * pageHeight;

    return ScrollSpringSimulation(
      spring,
      position.pixels,
      targetPixels,
      velocity,
      tolerance: tolerance,
    );
  }
}