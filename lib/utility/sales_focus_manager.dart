import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Configuration class for field validation
class FieldValidation {
  final String? value;
  final String? Function(String?) validator;
  final FocusNode focusNode;
  final String fieldType;

  const FieldValidation({
    required this.value,
    required this.validator,
    required this.focusNode,
    required this.fieldType,
  });
}

/// Utility class for managing focus transitions and field navigation
/// in the sales form interface
class SalesFocusManager {
  /// Map to store field validation rules
  static final Map<String, String? Function(String?)> _validators = {};

  /// Map to store field completion callbacks
  static final Map<String, VoidCallback> _completionCallbacks = {};

  /// Moves focus to the next field in the sequence
  ///
  /// [currentNode] - The currently focused node
  /// [nextNode] - The next node to focus on
  /// [onComplete] - Optional callback to execute before moving focus
  static void moveToNextField(
    FocusNode? currentNode,
    FocusNode? nextNode, {
    VoidCallback? onComplete,
  }) {
    if (currentNode == null || nextNode == null) return;

    // Execute completion callback if provided
    onComplete?.call();

    // Unfocus current node and focus next node
    currentNode.unfocus();

    // Use a slight delay to ensure proper focus transition
    Future.delayed(const Duration(milliseconds: 50), () {
      if (nextNode.canRequestFocus) {
        nextNode.requestFocus();
      }
    });
  }

  /// Moves focus to the previous field in the sequence
  ///
  /// [currentNode] - The currently focused node
  /// [previousNode] - The previous node to focus on
  /// [shouldClear] - Whether to clear the current field before moving
  static void moveToPreviousField(
    FocusNode? currentNode,
    FocusNode? previousNode, {
    bool shouldClear = false,
    TextEditingController? controller,
  }) {
    if (currentNode == null || previousNode == null) return;

    // Clear current field if requested
    if (shouldClear && controller != null) {
      controller.clear();
    }

    // Unfocus current node and focus previous node
    currentNode.unfocus();

    // Use a slight delay to ensure proper focus transition
    Future.delayed(const Duration(milliseconds: 50), () {
      if (previousNode.canRequestFocus) {
        previousNode.requestFocus();
      }
    });
  }

  /// Handles field completion and triggers auto-focus to next field
  ///
  /// [fieldType] - Type identifier for the field
  /// [value] - Current value of the field
  /// [currentNode] - Current focus node
  /// [nextNode] - Next focus node to move to
  /// [onFieldComplete] - Optional callback for field completion
  static void handleFieldCompletion(
    String fieldType,
    dynamic value,
    FocusNode? currentNode,
    FocusNode? nextNode, {
    Function(String, dynamic)? onFieldComplete,
  }) {
    // Execute field completion callback
    onFieldComplete?.call(fieldType, value);

    // Execute registered completion callback for this field type
    _completionCallbacks[fieldType]?.call();

    // Move to next field if both nodes are available
    if (currentNode != null && nextNode != null) {
      moveToNextField(currentNode, nextNode);
    }
  }

  /// Triggers auto-focus on form load
  ///
  /// [initialFocusNode] - The first field to focus on
  static void autoFocusOnLoad(FocusNode? initialFocusNode) {
    if (initialFocusNode == null) return;

    // Delay to ensure widget is fully built
    Future.delayed(const Duration(milliseconds: 100), () {
      if (initialFocusNode.canRequestFocus) {
        initialFocusNode.requestFocus();
      }
    });
  }

  /// Validates field value and manages focus based on validation result
  ///
  /// [fieldType] - Type identifier for the field
  /// [value] - Value to validate
  /// [currentNode] - Current focus node
  /// [nextNode] - Next focus node (if validation passes)
  /// [onError] - Callback for validation errors
  /// Returns true if validation passes, false otherwise
  static bool validateAndFocus(
    String fieldType,
    String? value,
    FocusNode? currentNode,
    FocusNode? nextNode, {
    Function(String)? onError,
  }) {
    // Get validator for this field type
    final validator = _validators[fieldType];
    if (validator == null) {
      // No validator registered, consider valid and move to next field
      if (currentNode != null && nextNode != null) {
        moveToNextField(currentNode, nextNode);
      }
      return true;
    }

    // Validate the field
    final errorMessage = validator(value);
    if (errorMessage != null) {
      // Validation failed - keep focus on current field and show error
      onError?.call(errorMessage);
      retainFocusOnError(currentNode);
      return false;
    }

    // Validation passed - move to next field
    if (currentNode != null && nextNode != null) {
      moveToNextField(currentNode, nextNode);
    }
    return true;
  }

  /// Retains focus on a field that has validation errors
  ///
  /// [errorNode] - The focus node that should retain focus
  static void retainFocusOnError(FocusNode? errorNode) {
    if (errorNode == null) return;

    // Ensure focus stays on the error field
    Future.delayed(const Duration(milliseconds: 100), () {
      if (errorNode.canRequestFocus) {
        errorNode.requestFocus();
      }
    });
  }

  /// Validates a field with custom validation logic and manages focus
  ///
  /// [value] - Value to validate
  /// [validator] - Custom validation function
  /// [currentNode] - Current focus node
  /// [nextNode] - Next focus node (if validation passes)
  /// [onError] - Callback for validation errors
  /// Returns true if validation passes, false otherwise
  static bool validateFieldWithCustomLogic(
    String? value,
    String? Function(String?) validator,
    FocusNode? currentNode,
    FocusNode? nextNode, {
    Function(String)? onError,
  }) {
    final errorMessage = validator(value);

    if (errorMessage != null) {
      // Validation failed - keep focus on current field and show error
      onError?.call(errorMessage);
      retainFocusOnError(currentNode);
      return false;
    }

    // Validation passed - move to next field
    if (currentNode != null && nextNode != null) {
      moveToNextField(currentNode, nextNode);
    }
    return true;
  }

  /// Validates multiple fields and focuses on the first error field
  ///
  /// [validations] - List of validation configurations
  /// Returns true if all validations pass, false otherwise
  static bool validateMultipleFields(
    List<FieldValidation> validations, {
    Function(String, FocusNode)? onError,
  }) {
    for (final validation in validations) {
      final errorMessage = validation.validator(validation.value);

      if (errorMessage != null) {
        // First validation error found - show error and focus on field
        onError?.call(errorMessage, validation.focusNode);
        retainFocusOnError(validation.focusNode);
        return false;
      }
    }

    return true; // All validations passed
  }

  /// Handles field completion with validation and focus management
  ///
  /// [fieldType] - Type identifier for the field
  /// [value] - Current value of the field
  /// [currentNode] - Current focus node
  /// [nextNode] - Next focus node to move to
  /// [validator] - Optional validation function
  /// [onFieldComplete] - Optional callback for field completion
  /// [onError] - Optional callback for validation errors
  static void handleFieldCompletionWithValidation(
    String fieldType,
    dynamic value,
    FocusNode? currentNode,
    FocusNode? nextNode, {
    String? Function(String?)? validator,
    Function(String, dynamic)? onFieldComplete,
    Function(String)? onError,
  }) {
    // Validate field if validator is provided
    if (validator != null) {
      final errorMessage = validator(value?.toString());
      if (errorMessage != null) {
        // Validation failed - show error and retain focus
        onError?.call(errorMessage);
        retainFocusOnError(currentNode);
        return;
      }
    }

    // Execute field completion callback
    onFieldComplete?.call(fieldType, value);

    // Execute registered completion callback for this field type
    _completionCallbacks[fieldType]?.call();

    // Move to next field if both nodes are available
    if (currentNode != null && nextNode != null) {
      moveToNextField(currentNode, nextNode);
    }
  }

  /// Registers a validator for a specific field type
  ///
  /// [fieldType] - Type identifier for the field
  /// [validator] - Validation function that returns error message or null
  static void registerValidator(
    String fieldType,
    String? Function(String?) validator,
  ) {
    _validators[fieldType] = validator;
  }

  /// Registers a completion callback for a specific field type
  ///
  /// [fieldType] - Type identifier for the field
  /// [callback] - Callback to execute when field is completed
  static void registerCompletionCallback(
    String fieldType,
    VoidCallback callback,
  ) {
    _completionCallbacks[fieldType] = callback;
  }

  /// Handles keyboard events for enhanced navigation
  ///
  /// [event] - The keyboard event
  /// [currentNode] - Current focus node
  /// [nextNode] - Next focus node
  /// [previousNode] - Previous focus node
  /// [controller] - Text controller for the current field
  /// Returns true if the event was handled
  static bool handleKeyboardEvent(
    KeyEvent event,
    FocusNode? currentNode,
    FocusNode? nextNode,
    FocusNode? previousNode,
    TextEditingController? controller,
  ) {
    if (event is! KeyDownEvent) return false;

    final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.tab:
        if (isShiftPressed) {
          // Shift+Tab: Move to previous field
          moveToPreviousField(currentNode, previousNode);
        } else {
          // Tab: Move to next field
          moveToNextField(currentNode, nextNode);
        }
        return true;

      case LogicalKeyboardKey.enter:
        // Enter: Move to next field
        moveToNextField(currentNode, nextNode);
        return true;

      case LogicalKeyboardKey.escape:
        // Escape: Clear field and move to previous
        moveToPreviousField(
          currentNode,
          previousNode,
          shouldClear: true,
          controller: controller,
        );
        return true;

      default:
        return false;
    }
  }

  /// Clears all registered validators and callbacks
  static void clearRegistrations() {
    _validators.clear();
    _completionCallbacks.clear();
  }

  /// Gets the next focusable node from a list of nodes
  ///
  /// [nodes] - List of focus nodes
  /// [currentNode] - Current focus node
  /// Returns the next focusable node or null
  static FocusNode? getNextFocusableNode(
    List<FocusNode> nodes,
    FocusNode currentNode,
  ) {
    final currentIndex = nodes.indexOf(currentNode);
    if (currentIndex == -1 || currentIndex >= nodes.length - 1) {
      return null;
    }

    // Find next focusable node
    for (int i = currentIndex + 1; i < nodes.length; i++) {
      if (nodes[i].canRequestFocus) {
        return nodes[i];
      }
    }

    return null;
  }

  /// Gets the previous focusable node from a list of nodes
  ///
  /// [nodes] - List of focus nodes
  /// [currentNode] - Current focus node
  /// Returns the previous focusable node or null
  static FocusNode? getPreviousFocusableNode(
    List<FocusNode> nodes,
    FocusNode currentNode,
  ) {
    final currentIndex = nodes.indexOf(currentNode);
    if (currentIndex <= 0) {
      return null;
    }

    // Find previous focusable node
    for (int i = currentIndex - 1; i >= 0; i--) {
      if (nodes[i].canRequestFocus) {
        return nodes[i];
      }
    }

    return null;
  }

  /// Creates a focus sequence configuration for a form
  ///
  /// [nodes] - List of focus nodes in order
  /// Returns a map of node to next/previous node relationships
  static Map<FocusNode, Map<String, FocusNode?>> createFocusSequence(
    List<FocusNode> nodes,
  ) {
    final Map<FocusNode, Map<String, FocusNode?>> sequence = {};

    for (int i = 0; i < nodes.length; i++) {
      sequence[nodes[i]] = {
        'next': i < nodes.length - 1 ? nodes[i + 1] : null,
        'previous': i > 0 ? nodes[i - 1] : null,
      };
    }

    return sequence;
  }

  /// Disposes focus nodes safely
  ///
  /// [nodes] - List of focus nodes to dispose
  static void disposeFocusNodes(List<FocusNode> nodes) {
    for (final node in nodes) {
      try {
        node.dispose();
      } catch (e) {
        // Ignore disposal errors for already disposed nodes
        debugPrint('Focus node disposal error: $e');
      }
    }
  }
}

/// Extension on FocusNode for additional utility methods
extension FocusNodeExtensions on FocusNode {
  /// Checks if this node can safely request focus
  bool get canSafelyRequestFocus {
    return canRequestFocus;
  }

  /// Requests focus with error handling
  void safeRequestFocus() {
    if (canSafelyRequestFocus) {
      try {
        requestFocus();
      } catch (e) {
        debugPrint('Focus request error: $e');
      }
    }
  }
}
