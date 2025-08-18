import 'package:demo/widgets/common_app_image.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_dimensions.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_strings.dart';
import 'splash_controller.dart';

// ignore: must_be_immutable
class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonAppImage(
                imagePath: AppImages.icArhamLogo,
                // height: 80,
                // width: 80,
                fit: BoxFit.fill,
              ).paddingOnly(left: 30, right: 30, top: 30),
              CommonText(
                text: AppString.arhamCorp,
                fontSize: AppDimensions.fontSizeExtraLarge,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 20),
              CommonText(
                text: AppString.pos,
                fontSize: AppDimensions.fontSizeLarge,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: AppString.poweredBy,
                fontSize: AppDimensions.fontSizeMedium,
                fontWeight: AppFontWeight.w400,
              ),
              CommonText(
                text: AppString.copyRights,
                maxLine: 2,
                fontSize: AppDimensions.fontSizeMedium,
                fontWeight: AppFontWeight.w400,
              ).paddingOnly(top: 4),
            ],
          ),
        ),
      ),
    );
  }
}
