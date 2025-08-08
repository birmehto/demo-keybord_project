import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/app_images.dart';
import 'common_shimmer.dart';

class CommonAppImageSvg extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? color;

  const CommonAppImageSvg({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        placeholder: (context, url) => CommonAppShimmer.rectangular(
          height: height,
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.icBackGround,
          height: height,
          width: width,
        ),
      );
    }
  }
}
