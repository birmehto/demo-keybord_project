import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CommonSearchableDropdown<T> extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? labelText;
  final String? hintText;
  final Future<List<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSelected;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final int maxLength;
  final bool isMandatory;
  final bool showSuffixIcons;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Duration debounceDuration;
  final WidgetBuilder? emptyBuilder; // Corrected type
  final WidgetBuilder? loadingBuilder; // Corrected type
  final Widget Function(BuildContext, Object)? errorBuilder; // Corrected type

  const CommonSearchableDropdown({
    super.key,
    required this.controller,
    required this.focusNode,
    this.labelText,
    this.hintText,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSelected,
    this.onChanged,
    this.onTap,
    this.onClear,
    this.maxLength = 100,
    this.isMandatory = false,
    this.showSuffixIcons = true,
    this.enabled = true,
    this.textCapitalization,
    this.inputFormatters,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TypeAheadField<T>(
      controller: controller,
      focusNode: focusNode,
      debounceDuration: debounceDuration,
      suggestionsCallback: suggestionsCallback,
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      emptyBuilder:
          emptyBuilder ??
          (context) => const ListTile(title: Text('No data found')),
      loadingBuilder:
          loadingBuilder ??
          (context) => const Center(child: CircularProgressIndicator()),
      errorBuilder:
          errorBuilder ??
          (context, error) => ListTile(title: Text('Error: $error')),
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
      // ),
      builder: (context, fieldController, node) {
        return TextField(
          enabled: enabled,
          controller: fieldController,
          focusNode: node,
          maxLength: maxLength,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          inputFormatters: inputFormatters ?? [],
          textInputAction: TextInputAction.done,
          onChanged: (val) {
            onChanged?.call(val);
            if (val.isEmpty) {
              node.unfocus();
              FocusScope.of(context).unfocus();
            }
          },
          onTap: onTap,
          decoration: InputDecoration(
            counter: const Offstage(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 39,
            ),
            suffixIcon:
                showSuffixIcons
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //if (onClear != null && controller.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            //size: 24,
                          ),
                          onPressed: onClear,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            //size: 24,
                          ),
                        ),
                      ],
                    )
                    : null,
            labelText: isMandatory ? '$labelText *' : labelText,
            hintText: isMandatory ? '$hintText *' : hintText,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
              ),
            ),
          ),
        );
      },
    );
  }
}
