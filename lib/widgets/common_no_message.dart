import 'package:demo_project/app/app_images.dart';
import 'package:demo_project/widgets/common_app_image.dart';
import 'package:demo_project/widgets/common_app_image_svg.dart';
import 'package:demo_project/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonNoMessage extends StatelessWidget {
  final String searchQuery;
  final String errorMessage;

  const CommonNoMessage({
    super.key,
    required this.searchQuery,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchQuery.isNotEmpty
                ? const CommonAppImage(
                  imagePath: AppImages.icNoSearchFound,
                  height: 100,
                  width: 100,
                )
                : const CommonAppImageSvg(
                  imagePath: AppImages.svgNoData,
                  height: 100,
                  width: double.infinity,
                ),
            CommonText(
              text:
                  searchQuery.isNotEmpty
                      ? "No search records found."
                      : errorMessage,
            ).paddingOnly(top: 10),
          ],
        ),
      ),
    );
  }
}
