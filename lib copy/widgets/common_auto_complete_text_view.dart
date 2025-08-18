import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommonAutoCompleteTextView<T extends Object> extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final String? hintText;
  final bool enabled;
  final bool showClearButton;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final TextCapitalization textCapitalization;

  final Future<List<T>> Function(String)? suggestionsCallback;
  final String Function(T)? displayString;
  final Widget Function(BuildContext, T)? itemBuilder;
  final void Function(T)? onSelected;
  final void Function()? onClear;
  final void Function(String)? onChanged;
  final FutureOr<Iterable<T>> Function(TextEditingValue)? optionsBuilder;

  const CommonAutoCompleteTextView({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.showClearButton = true,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.suggestionsCallback,
    this.displayString,
    this.itemBuilder,
    this.onSelected,
    this.onClear,
    this.onChanged,
    this.optionsBuilder,
  });

  @override
  State<CommonAutoCompleteTextView<T>> createState() =>
      _CommonAutoCompleteTextViewState<T>();
}

class _CommonAutoCompleteTextViewState<T extends Object>
    extends State<CommonAutoCompleteTextView<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSuggestions =
        widget.suggestionsCallback != null && widget.displayString != null;

    if (!hasSuggestions) {
      return TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done,
        onSubmitted: (_) {
          if (widget.nextFocusNode != null) {
            FocusScope.of(context).requestFocus(widget.nextFocusNode!);
          }
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          counterText: '',
          suffixIcon:
              widget.showClearButton && widget.controller.text.trim().isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        widget.controller.clear();
                        widget.onClear?.call();
                        setState(() {});
                      },
                    )
                  : null,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      );
    }

    return RawAutocomplete<T>(
      textEditingController: widget.controller,
      focusNode: widget.focusNode,
      optionsBuilder: widget.optionsBuilder ??
          (TextEditingValue value) {
            final callback = widget.suggestionsCallback;
            if (callback == null) return Iterable<T>.empty();
            return callback(value.text.trim());
          },
      displayStringForOption: widget.displayString ?? (_) => '',
      onSelected: (T selection) {
        widget.onSelected?.call(selection);
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode!);
        }
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          onSubmitted: (_) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode!);
            }
          },
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            counterText: '',
            suffixIcon: widget.showClearButton &&
                    widget.controller.text.trim().isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      widget.controller.clear();
                      widget.onClear?.call();
                      setState(() {});
                    },
                  )
                : const Icon(Icons.keyboard_arrow_down),
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  minWidth: 400),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: widget.itemBuilder?.call(context, option) ??
                        ListTile(
                          title: Text(widget.displayString?.call(option) ?? ''),
                        ),
                  );
                },
              ),
            ),
          ),
        ).paddingOnly(top: 5);
      },
    );
  }
}
