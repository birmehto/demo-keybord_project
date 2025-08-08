import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Common shimmer view
class CommonAppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  /// Get rectangular shimmer
  const CommonAppShimmer.rectangular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder()});

  /// Get circular shimmer
  const CommonAppShimmer.circular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
    highlightColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.25),
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          //color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            shape: shapeBorder,
          ),
        ),
      );
}
