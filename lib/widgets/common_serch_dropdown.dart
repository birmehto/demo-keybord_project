import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import '../utility/sales_focus_manager.dart';

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

  // Enhanced focus management parameters
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final bool autoFocus;
  final Function(T)? onSelectionComplete;
  final Function(String)? onNotFound;
  final bool enableKeyboardNavigation;

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
    // Enhanced focus management parameters
    this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
    this.autoFocus = false,
    this.onSelectionComplete,
    this.onNotFound,
    this.enableKeyboardNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget searchField = SearchField<T>(
      controller: controller,
      focusNode: focusNode,
      suggestions: const [], // initially empty
      onSearchTextChanged: (query) async {
        if (suggestionsCallback != null) {
          final items = await suggestionsCallback!(query);

          // Handle "not found" scenario
          if (items.isEmpty && query.isNotEmpty) {
            onNotFound?.call(query);
          }

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

        // Handle selection completion with auto-focus
        if (onSelectionComplete != null && suggestion.item != null) {
          onSelectionComplete!(suggestion.item as T);
        }

        // Auto-focus to next field after selection
        if (nextFocusNode != null) {
          SalesFocusManager.moveToNextField(focusNode, nextFocusNode);
        }
      },
      maxSuggestionsInViewPort: maxSuggestions,
      searchInputDecoration: SearchInputDecoration(
        labelText: isMandatory ? "$labelText *" : labelText,
        hintText: hintText ?? "Type to search...",
        border:
            showOutlineBorder
                ? const OutlineInputBorder() // Full outline border
                : const UnderlineInputBorder(), // Bottom border only
        enabledBorder:
            showOutlineBorder
                ? const OutlineInputBorder()
                : UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
        focusedBorder:
            showOutlineBorder
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                )
                : UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            controller.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _handleClear();
                  },
                )
                : null,
      ),
    );

    // Wrap with keyboard listener for enhanced navigation
    if (enableKeyboardNavigation) {
      searchField = RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            _handleKeyboardEvent(event);
          }
        },
        child: searchField,
      );
    }

    return searchField;
  }

  /// Handles keyboard events for enhanced navigation
  void _handleKeyboardEvent(RawKeyDownEvent event) {
    final isShiftPressed = event.isShiftPressed;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.tab:
        if (isShiftPressed && previousFocusNode != null) {
          // Shift+Tab: Move to previous field
          SalesFocusManager.moveToPreviousField(focusNode, previousFocusNode);
        } else if (!isShiftPressed && nextFocusNode != null) {
          // Tab: Move to next field
          SalesFocusManager.moveToNextField(focusNode, nextFocusNode);
        }
        break;

      case LogicalKeyboardKey.enter:
        // Enter: Move to next field if available
        if (nextFocusNode != null) {
          SalesFocusManager.moveToNextField(focusNode, nextFocusNode);
        }
        break;

      case LogicalKeyboardKey.escape:
        // Escape: Clear field and move to previous
        _handleClear();
        if (previousFocusNode != null) {
          SalesFocusManager.moveToPreviousField(focusNode, previousFocusNode);
        }
        break;

      default:
        break;
    }
  }

  /// Handles clearing the field with proper focus management
  void _handleClear() {
    controller.clear();
    onClear?.call();

    // Move focus to previous field after clearing
    if (previousFocusNode != null) {
      SalesFocusManager.moveToPreviousField(
        focusNode,
        previousFocusNode,
        shouldClear: false, // Already cleared above
      );
    }
  }
}
