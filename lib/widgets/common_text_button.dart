import 'package:demo_project/widgets/common_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CommonTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(0, 25),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: CommonText(
        text: title,
        // textAlign: TextAlign.center,
        // fontSize: AppDimensions.fontSizeMedium,
        // fontWeight: FontWeight.w400
      ),
    );
  }
}
