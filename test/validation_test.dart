import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:demo/utility/sales_focus_manager.dart';

void main() {
  group('Sales Focus Manager Validation Tests', () {
    setUp(() {
      // Clear any existing registrations before each test
      SalesFocusManager.clearRegistrations();
    });

    test('should validate field with custom validator', () {
      // Arrange
      String? testValidator(String? value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      }

      final currentNode = FocusNode();
      final nextNode = FocusNode();
      String? capturedError;

      // Act & Assert - Test with empty value
      final result1 = SalesFocusManager.validateFieldWithCustomLogic(
        '',
        testValidator,
        currentNode,
        nextNode,
        onError: (error) => capturedError = error,
      );

      expect(result1, false);
      expect(capturedError, 'Field is required');

      // Act & Assert - Test with valid value
      capturedError = null;
      final result2 = SalesFocusManager.validateFieldWithCustomLogic(
        'valid value',
        testValidator,
        currentNode,
        nextNode,
        onError: (error) => capturedError = error,
      );

      expect(result2, true);
      expect(capturedError, null);

      // Cleanup
      currentNode.dispose();
      nextNode.dispose();
    });

    test('should handle multiple field validations', () {
      // Arrange
      final focusNode1 = FocusNode();
      final focusNode2 = FocusNode();

      final validations = [
        FieldValidation(
          value: '',
          validator:
              (value) => value?.isEmpty == true ? 'Field 1 required' : null,
          focusNode: focusNode1,
          fieldType: 'field1',
        ),
        FieldValidation(
          value: 'valid',
          validator:
              (value) => value?.isEmpty == true ? 'Field 2 required' : null,
          focusNode: focusNode2,
          fieldType: 'field2',
        ),
      ];

      String? capturedError;
      FocusNode? capturedFocusNode;

      // Act
      final result = SalesFocusManager.validateMultipleFields(
        validations,
        onError: (error, focusNode) {
          capturedError = error;
          capturedFocusNode = focusNode;
        },
      );

      // Assert
      expect(result, false);
      expect(capturedError, 'Field 1 required');
      expect(capturedFocusNode, focusNode1);

      // Cleanup
      focusNode1.dispose();
      focusNode2.dispose();
    });

    test('should register and use field validators', () {
      // Arrange
      SalesFocusManager.registerValidator(
        'testField',
        (value) => value?.isEmpty == true ? 'Test field is required' : null,
      );

      final currentNode = FocusNode();
      final nextNode = FocusNode();
      String? capturedError;

      // Act
      final result = SalesFocusManager.validateAndFocus(
        'testField',
        '',
        currentNode,
        nextNode,
        onError: (error) => capturedError = error,
      );

      // Assert
      expect(result, false);
      expect(capturedError, 'Test field is required');

      // Cleanup
      currentNode.dispose();
      nextNode.dispose();
    });

    test('should handle field completion with validation', () {
      // Arrange
      final currentNode = FocusNode();
      final nextNode = FocusNode();
      String? capturedError;
      String? completedFieldType;
      dynamic completedValue;

      // Act - Test with invalid value
      SalesFocusManager.handleFieldCompletionWithValidation(
        'testField',
        '',
        currentNode,
        nextNode,
        validator: (value) => value?.isEmpty == true ? 'Field required' : null,
        onFieldComplete: (fieldType, value) {
          completedFieldType = fieldType;
          completedValue = value;
        },
        onError: (error) => capturedError = error,
      );

      // Assert - Should not complete due to validation error
      expect(capturedError, 'Field required');
      expect(completedFieldType, null);

      // Act - Test with valid value
      capturedError = null;
      SalesFocusManager.handleFieldCompletionWithValidation(
        'testField',
        'valid value',
        currentNode,
        nextNode,
        validator: (value) => value?.isEmpty == true ? 'Field required' : null,
        onFieldComplete: (fieldType, value) {
          completedFieldType = fieldType;
          completedValue = value;
        },
        onError: (error) => capturedError = error,
      );

      // Assert - Should complete successfully
      expect(capturedError, null);
      expect(completedFieldType, 'testField');
      expect(completedValue, 'valid value');

      // Cleanup
      currentNode.dispose();
      nextNode.dispose();
    });
  });
}
