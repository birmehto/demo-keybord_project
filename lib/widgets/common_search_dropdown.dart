import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CommonSearchableDropdown2<T> extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool isMandatory;
  final bool enabled;
  final bool showOutlineBorder;
  final int maxSuggestions;
  final Duration debounceDuration;
  final Future<List<T>> Function(String)? suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T)? onSuggestionSelected;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const CommonSearchableDropdown2({
    super.key,
    required this.controller,
    required this.labelText,
    required this.itemBuilder,
    this.suggestionsCallback,
    this.onSuggestionSelected,
    this.showOutlineBorder = false,
    this.hintText,
    this.isMandatory = false,
    this.enabled = true,
    this.maxSuggestions = 11,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SearchField<T>(
      controller: controller,
      focusNode: focusNode,
      suggestions: const [], // initially empty
      onSearchTextChanged: (query) async {
        if (suggestionsCallback != null) {
          final items = await suggestionsCallback!(query);
          return items
              .map(
                (item) => SearchFieldListItem<T>(
                  item.toString(),
                  item: item,
                  child: itemBuilder(context, item),
                ),
              )
              .toList();
        }
        return [];
      },
      onSuggestionTap: (suggestion) {
        controller.text = suggestion.searchKey;
        if (onSuggestionSelected != null && suggestion.item != null) {
          onSuggestionSelected!(suggestion.item as T);
        }
      },
      maxSuggestionsInViewPort: maxSuggestions,
      searchInputDecoration: SearchInputDecoration(
        labelText: isMandatory ? "$labelText *" : labelText,
        hintText: hintText ?? "Type to search...",
        border: showOutlineBorder
            ? const OutlineInputBorder() // Full outline border
            : const UnderlineInputBorder(), // Bottom border only
        enabledBorder: showOutlineBorder
            ? const OutlineInputBorder()
            : UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary),
              ),
        focusedBorder: showOutlineBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary),
              ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  onClear?.call();
                },
              )
            : null,
      ),
    );
  }
}
