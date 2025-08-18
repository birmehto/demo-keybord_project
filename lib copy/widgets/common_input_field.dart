import 'package:demo/app/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/app_colors.dart';

class CommonInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool? isPasswordCap;
  final bool? isPassword;
  final double borderRadius;
  final String? lableText;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final IconData? suffixIcon;
  final IconData? prifixIcon;
  final Color? prifixColor;
  final Color? suffixColor;
  final VoidCallback? onSuffixClick;
  final VoidCallback? onPrifixClick;
  final TextInputAction textInputAction;
  final Function(String text)? onSubmitted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChanged;
  final Color borderColor;
  final Color? hintColor;
  final bool? isEnable;
  final bool isDateField;
  final EdgeInsets? padding;
  final EdgeInsets? prifixPadding;
  final int? maxLength;
  final int? maxLines;
  final String? suFixImage;
  final String? prifixImage;
  final double? inputHeight;
  final double? inputWidth;
  final TextCapitalization textCapitalization;

  // NEW FIELDS
  final Color? cursorColor;
  final double? cursorWidth;
  //final bool removeCursorBubble;

  const CommonInputField({
    super.key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textAlignVertical,
    this.textAlign,
    this.isPasswordCap = false,
    this.isPassword = false,
    this.borderRadius = 10,
    this.lableText,
    this.hintText,
    this.hintStyle,
    this.hintColor,
    this.labelStyle,
    this.suffixIcon,
    this.prifixIcon,
    this.onSuffixClick,
    this.onPrifixClick,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.inputFormatters,
    this.onChanged,
    this.isEnable,
    this.isDateField = false,
    this.borderColor = AppColors.indigoSwatch,
    this.padding,
    this.maxLength,
    this.maxLines = 1,
    this.suFixImage,
    this.prifixImage,
    this.inputHeight,
    this.inputWidth,
    this.prifixPadding,
    this.prifixColor,
    this.suffixColor,
    this.textCapitalization = TextCapitalization.none,
    //this.textCapitalization = TextCapitalization.words,

    // Cursor customization
    this.cursorColor,
    this.cursorWidth,
    //this.removeCursorBubble = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: inputHeight,
      width: inputWidth ?? double.infinity,
      child: TextFormField(
        textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        onChanged: onChanged,

        //onChanged: onChanged,
        // onChanged: (text) {
        //   if (text.isNotEmpty) {
        //     final updatedText = text[0].toUpperCase() + text.substring(1);
        //     if (text != updatedText) {
        //       textEditingController.value = textEditingController.value.copyWith(
        //         text: updatedText,
        //         selection: TextSelection.collapsed(offset: updatedText.length),
        //       );
        //     }
        //   }
        //   onChanged?.call(text);
        // },

        // onChanged: (text) {
        //   if (text.isNotEmpty) {
        //     final updatedText = text
        //         .split(' ')
        //         .map((word) => word.isNotEmpty
        //         ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        //         : '')
        //         .join(' ');
        //
        //     if (text != updatedText) {
        //       textEditingController.value = textEditingController.value.copyWith(
        //         text: updatedText,
        //         selection: TextSelection.collapsed(offset: updatedText.length),
        //       );
        //     }
        //   }
        //   onChanged?.call(text);
        // },

        // onChanged: (text) {
        //   if (isPasswordCap == true) {
        //     onChanged?.call(text); // Do not modify password
        //     return;
        //   }
        //
        //   if (text.isNotEmpty) {
        //     final updatedText = text
        //         .split(' ')
        //         .map((word) => word.isNotEmpty
        //         ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        //         : '')
        //         .join(' ');
        //
        //     if (text != updatedText) {
        //       textEditingController.value = textEditingController.value.copyWith(
        //         text: updatedText,
        //         selection: TextSelection.collapsed(offset: updatedText.length),
        //       );
        //     }
        //   }
        //   onChanged?.call(text);
        // },
        textAlign: textAlign ?? TextAlign.start,
        focusNode: focusNode,
        controller: textEditingController,
        keyboardType: isDateField ? TextInputType.none : textInputType,
        obscureText: isPassword ?? false,
        textInputAction: textInputAction,
        cursorColor: cursorColor ?? Theme.of(context).colorScheme.primary,
        cursorWidth: cursorWidth ?? 1.0,
        //enableInteractiveSelection: !removeCursorBubble,
        onFieldSubmitted: (String text) {
          onSubmitted?.call(text);
          nextFocusNode?.requestFocus();
        },
        style: labelStyle,
        inputFormatters: inputFormatters,
        enabled: isEnable,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: isDateField,
        onTap: isDateField ? onSuffixClick : null,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          counter: const Offstage(),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 39,
          ),
          suffixIcon:
              suffixIcon != null
                  ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkResponse(
                      radius: 12,
                      onTap: onSuffixClick,
                      child: Icon(suffixIcon, size: 20, color: suffixColor),
                    ),
                  )
                  : suFixImage != null
                  ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkResponse(
                      radius: 12,
                      onTap: onSuffixClick,
                      child: Image.asset(
                        suFixImage!,
                        height: 20,
                        width: 20,
                        color: suffixColor,
                      ),
                    ),
                  )
                  : null,
          prefixIcon:
              prifixIcon != null
                  ? Padding(
                    padding: prifixPadding ?? const EdgeInsets.only(left: 10),
                    child: InkResponse(
                      radius: 15,
                      onTap: onPrifixClick,
                      child: Icon(prifixIcon, size: 18),
                    ),
                  )
                  : prifixImage != null
                  ? Padding(
                    padding: prifixPadding ?? const EdgeInsets.only(left: 10),
                    child: InkResponse(
                      radius: 15,
                      onTap: onPrifixClick,
                      child: Image.asset(
                        prifixImage!,
                        height: 20,
                        width: 20,
                        color: prifixColor,
                      ),
                    ),
                  )
                  : null,
          labelText: lableText,
          hintText: hintText,
          labelStyle: labelStyle ?? AppFonts.textStyle().copyWith(fontSize: 16),
          hintStyle: hintStyle ?? AppFonts.textStyle().copyWith(fontSize: 16),
          isDense: true,
          contentPadding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
        ),
      ),
    );
  }
}
