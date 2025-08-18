import 'package:demo/app/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/app_colors.dart';

class CommonInputField extends StatefulWidget {
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
  final FocusNode? previousFocusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChanged;
  final Function(String text)? onFieldComplete;
  final String? Function(String?)? validator;
  final Function(String)? onValidationError;
  final Color borderColor;
  final Color? hintColor;
  final bool? isEnable;
  final bool autoFocus;
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
    this.previousFocusNode,
    this.inputFormatters,
    this.onChanged,
    this.onFieldComplete,
    this.validator,
    this.onValidationError,
    this.isEnable,
    this.isDateField = false,
    this.autoFocus = false,
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
  State<CommonInputField> createState() => _CommonInputFieldState();
}

class _CommonInputFieldState extends State<CommonInputField> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // Handle Escape key - clear field and move to previous
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        widget.textEditingController.clear();
        widget.onChanged?.call('');
        if (widget.previousFocusNode != null) {
          widget.previousFocusNode!.requestFocus();
        }
        return;
      }

      // Handle Shift+Tab for backward navigation
      if (event.logicalKey == LogicalKeyboardKey.tab &&
          HardwareKeyboard.instance.isShiftPressed) {
        if (widget.previousFocusNode != null) {
          widget.previousFocusNode!.requestFocus();
        }
        return;
      }

      // Handle Tab for forward navigation
      if (event.logicalKey == LogicalKeyboardKey.tab &&
          !HardwareKeyboard.instance.isShiftPressed) {
        _handleFieldSubmission();
        return;
      }

      // Handle Enter key
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        _handleFieldSubmission();
        return;
      }
    }
  }

  void _handleFieldSubmission() {
    final text = widget.textEditingController.text;

    // Validate field if validator is provided
    if (widget.validator != null) {
      final errorMessage = widget.validator!(text);
      if (errorMessage != null) {
        // Validation failed - show error and retain focus
        widget.onValidationError?.call(errorMessage);
        _internalFocusNode.requestFocus();
        return;
      }
    }

    // Validation passed or no validator - proceed with field completion
    widget.onSubmitted?.call(text);
    widget.onFieldComplete?.call(text);

    // Move to next field if appropriate
    if (widget.textInputAction == TextInputAction.next &&
        widget.nextFocusNode != null) {
      widget.nextFocusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.inputHeight,
      width: widget.inputWidth ?? double.infinity,
      child: Focus(
        onKeyEvent: (node, event) {
          _handleKeyEvent(event);
          return KeyEventResult.ignored;
        },
        child: Container(
          decoration:
              _isFocused
                  ? BoxDecoration(
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  )
                  : null,
          child: TextFormField(
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,
            onChanged: widget.onChanged,
            textAlign: widget.textAlign ?? TextAlign.start,
            focusNode: _internalFocusNode,
            autofocus: widget.autoFocus,
            controller: widget.textEditingController,
            keyboardType:
                widget.isDateField ? TextInputType.none : widget.textInputType,
            obscureText: widget.isPassword ?? false,
            textInputAction: widget.textInputAction,
            cursorColor:
                widget.cursorColor ?? Theme.of(context).colorScheme.primary,
            cursorWidth: widget.cursorWidth ?? 1.0,
            onFieldSubmitted: (String text) {
              _handleFieldSubmission();
            },
            style: widget.labelStyle,
            inputFormatters: widget.inputFormatters,
            enabled: widget.isEnable,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            readOnly: widget.isDateField,
            onTap: widget.isDateField ? widget.onSuffixClick : null,
            textCapitalization: widget.textCapitalization,
            decoration: InputDecoration(
              counter: const Offstage(),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 39,
              ),
              suffixIcon:
                  widget.suffixIcon != null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkResponse(
                          radius: 12,
                          onTap: widget.onSuffixClick,
                          child: Icon(
                            widget.suffixIcon,
                            size: 20,
                            color: widget.suffixColor,
                          ),
                        ),
                      )
                      : widget.suFixImage != null
                      ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkResponse(
                          radius: 12,
                          onTap: widget.onSuffixClick,
                          child: Image.asset(
                            widget.suFixImage!,
                            height: 20,
                            width: 20,
                            color: widget.suffixColor,
                          ),
                        ),
                      )
                      : null,
              prefixIcon:
                  widget.prifixIcon != null
                      ? Padding(
                        padding:
                            widget.prifixPadding ??
                            const EdgeInsets.only(left: 10),
                        child: InkResponse(
                          radius: 15,
                          onTap: widget.onPrifixClick,
                          child: Icon(widget.prifixIcon, size: 18),
                        ),
                      )
                      : widget.prifixImage != null
                      ? Padding(
                        padding:
                            widget.prifixPadding ??
                            const EdgeInsets.only(left: 10),
                        child: InkResponse(
                          radius: 15,
                          onTap: widget.onPrifixClick,
                          child: Image.asset(
                            widget.prifixImage!,
                            height: 20,
                            width: 20,
                            color: widget.prifixColor,
                          ),
                        ),
                      )
                      : null,
              labelText: widget.lableText,
              hintText: widget.hintText,
              labelStyle:
                  widget.labelStyle ??
                  AppFonts.textStyle().copyWith(fontSize: 16),
              hintStyle:
                  widget.hintStyle ??
                  AppFonts.textStyle().copyWith(fontSize: 16),
              isDense: true,
              contentPadding:
                  widget.padding ??
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
        ),
      ),
    );
  }
}
