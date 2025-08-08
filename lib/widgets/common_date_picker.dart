import 'package:demo_project/app/app_font_style.dart';
import 'package:flutter/material.dart';

class CommonDatePickerInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final String? labelText; // Fixed spelling
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData suffixIcon; // Made required
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? enabledBorderColor;
  final Color? disabledBorderColor;
  final String? Function(String?)? validator; // Added validation
  final String? semanticLabel; // Added accessibility

  const CommonDatePickerInput({
    super.key,
    required this.controller,
    required this.isEnabled,
    this.labelText,
    this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.suffixIcon = Icons.calendar_month, // Default value
    this.onTap,
    this.textStyle,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.validator,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          readOnly: true,
          enabled: isEnabled,
          validator: validator,
          style: textStyle ?? AppFonts.textStyle().copyWith(fontSize: 16),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: AppFonts.textStyle().copyWith(fontSize: 16),
            suffixIcon: Icon(
              suffixIcon,
              color:
                  isEnabled
                      ? (enabledBorderColor ?? theme.primaryColor)
                      : (disabledBorderColor ?? theme.disabledColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: enabledBorderColor ?? theme.primaryColor,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: disabledBorderColor ?? theme.disabledColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: enabledBorderColor ?? theme.primaryColor,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            errorMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
