import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_dimensions.dart';
import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonMaterialDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? yesButtonText;
  final String? noButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final RxBool? isLoading;

  const CommonMaterialDialog({
    super.key,
    this.title,
    this.message,
    this.yesButtonText,
    this.noButtonText,
    this.onConfirm,
    this.onCancel,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 16),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty)
              CommonText(
                textAlign: TextAlign.start,
                text: title!,
                fontSize: AppDimensions.fontSizeLarge,
                fontWeight: AppFontWeight.w500,
              ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
          ],
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message != null && message!.isNotEmpty)
              CommonText(
                textAlign: TextAlign.start,
                text: message!,
                fontSize: AppDimensions.fontSizeMedium,
                fontWeight: AppFontWeight.w400,
              ),

            const SizedBox(height: 24),

            (isLoading?.value ?? false)
                ? Center(child: Utils.commonCircularProgress())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Yes Button
                    CommonButton(
                      buttonText: yesButtonText ?? 'Yes',
                      onPressed: onConfirm ?? () {},
                      isLoading: false,
                    ),

                    const SizedBox(height: 20),

                    // No Button
                    TextButton(
                      onPressed: onCancel ?? () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                      ),
                      child: CommonText(
                        text: noButtonText ?? 'No',
                        fontSize: AppDimensions.fontSizeLarge,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
