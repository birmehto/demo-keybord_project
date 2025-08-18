import 'package:demo/widgets/common_app_image.dart';
import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonListTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const CommonListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      visualDensity: const VisualDensity(vertical: -4),
      leading: CommonAppImage(
        imagePath: imagePath,
        width: 24,
        height: 24,
        color: AppColors.colorDarkGray,
      ),
      title: CommonText(
        text: text,
        color: AppColors.colorDarkGray,
        fontWeight: AppFontWeight.w400,
      ),
      onTap: onTap,
    );
  }
}
