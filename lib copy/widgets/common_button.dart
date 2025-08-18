import 'package:demo/app/app_dimensions.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/material.dart';

import '../app/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisable;

  const CommonButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AbsorbPointer(
      absorbing: isDisable,
      child: Opacity(
        opacity: isDisable ? 0.5 : 1.0,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                theme.primaryColor,
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            child:
                isLoading
                    ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.colorWhite,
                        ),
                        strokeWidth: 3,
                      ),
                    )
                    : CommonText(
                      text: buttonText,
                      textAlign: TextAlign.center,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: AppDimensions.fontSizeMedium,
                      fontWeight: FontWeight.w400,
                    ),
          ),
        ),
      ),
    );
  }
}
