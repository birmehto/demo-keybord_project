# Design Document

## Overview

This design document outlines the enhancement of focus node management and field functionality in the web general sales form. The solution will implement a comprehensive focus management system that provides smooth keyboard navigation, auto-focus capabilities, and improved user experience for sales data entry.

## Architecture

### Focus Management System
The focus management will be implemented using a centralized approach with the following components:

1. **FocusManager Class**: A dedicated class to handle focus transitions and validation
2. **Enhanced Controller**: Extended WebGeneralSalesController with improved focus node management
3. **Field Sequence Definition**: A predefined sequence of fields for logical navigation
4. **Auto-Focus Triggers**: Event-based focus transitions based on user actions

### Focus Flow Sequence
```
Date Field → Party Dropdown → Sales Grid (Product) → Sales Grid (Batch) → 
Sales Grid (Qty) → Sales Grid (Rate) → Sales Grid (Discount) → 
Discount % → Discount Amount → Payment Method → Cash Received (if Cash) → Remarks
```

## Components and Interfaces

### 1. FocusManager Class

```dart
class SalesFocusManager {
  static void moveToNextField(FocusNode currentNode, FocusNode? nextNode);
  static void moveToPreviousField(FocusNode currentNode, FocusNode? previousNode);
  static void handleFieldCompletion(String fieldType, dynamic value);
  static void autoFocusOnLoad();
  static void validateAndFocus(String fieldType, String value, FocusNode errorNode);
}
```

### 2. Enhanced Controller Methods

```dart
class WebGeneralSalesController {
  // Focus management
  void initializeFocusNodes();
  void setupFocusListeners();
  void handleAutoFocus(String triggerField);
  void disposeFocusNodes();
  
  // Field validation with focus
  bool validateFieldWithFocus(String fieldType, String value);
  void showFieldError(String message, FocusNode errorField);
  
  // Navigation helpers
  void moveToNextSalesGridRow();
  void focusFirstEmptyField();
}
```

### 3. Enhanced Input Field Components

#### CommonInputField Enhancements
- Add `autoFocus` parameter
- Implement `onFieldComplete` callback
- Add `previousFocusNode` for backward navigation
- Enhanced keyboard handling (Tab, Shift+Tab, Enter, Escape)

#### SearchableDropdown Enhancements
- Auto-focus after selection
- Keyboard navigation support
- Clear field with Escape key
- Focus management for "not found" scenarios

## Data Models

### Focus Configuration Model
```dart
class FocusConfig {
  final String fieldId;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final bool autoFocus;
  final Function(String)? onComplete;
  final Function(String)? validator;
}
```

### Field Sequence Model
```dart
class FieldSequence {
  final List<String> headerFields;
  final List<String> gridFields;
  final List<String> footerFields;
  final Map<String, FocusConfig> focusMap;
}
```

## Error Handling

### Focus-Related Error Handling
1. **Validation Errors**: Focus remains on invalid field with error message
2. **Network Errors**: Focus returns to trigger field after error display
3. **Missing Data**: Auto-focus on first required empty field
4. **Calculation Errors**: Focus on problematic input field

### Error Recovery
- Escape key clears current field and moves to previous
- Double-tap on field clears and refocuses
- Validation errors show inline with field highlighting

## Testing Strategy

### Unit Tests
1. **Focus Transition Tests**
   - Test forward navigation (Tab/Enter)
   - Test backward navigation (Shift+Tab)
   - Test auto-focus triggers
   - Test focus on validation errors

2. **Field Validation Tests**
   - Test numeric field validation with focus retention
   - Test required field validation
   - Test dropdown selection with auto-focus

3. **Calculation Tests**
   - Test discount calculation with focus transitions
   - Test total calculation updates
   - Test payment method changes with conditional focus

### Integration Tests
1. **Complete Flow Tests**
   - Test full sales entry workflow with keyboard only
   - Test form submission with validation
   - Test error scenarios with proper focus handling

2. **User Experience Tests**
   - Test focus visibility and highlighting
   - Test keyboard shortcuts functionality
   - Test responsive focus behavior

### Widget Tests
1. **Enhanced Input Field Tests**
   - Test auto-focus behavior
   - Test keyboard event handling
   - Test focus transition callbacks

2. **Dropdown Enhancement Tests**
   - Test keyboard navigation in suggestions
   - Test auto-focus after selection
   - Test "not found" scenario handling

## Implementation Details

### Phase 1: Core Focus Management
1. Create FocusManager utility class
2. Enhance CommonInputField with focus management
3. Update WebGeneralSalesController with focus nodes
4. Implement basic field sequence navigation

### Phase 2: Advanced Features
1. Add auto-focus triggers for specific events
2. Implement conditional focus (payment method changes)
3. Add keyboard shortcuts support
4. Enhance dropdown components with keyboard navigation

### Phase 3: Validation Integration
1. Integrate validation with focus management
2. Add error handling with focus retention
3. Implement field completion detection
4. Add visual focus indicators

### Phase 4: Sales Grid Enhancement
1. Implement dynamic row focus management
2. Add auto-row creation with focus
3. Handle row deletion with focus adjustment
4. Optimize grid navigation performance

## Performance Considerations

### Focus Node Management
- Lazy initialization of focus nodes
- Proper disposal to prevent memory leaks
- Efficient focus transition algorithms
- Minimal rebuild triggers

### Calculation Optimization
- Debounced calculation updates
- Efficient focus transition during calculations
- Optimized listener management

## Accessibility Considerations

### Keyboard Navigation
- Full keyboard accessibility
- Screen reader compatibility
- Focus indicators for visually impaired users
- Logical tab order maintenance

### Visual Indicators
- Clear focus highlighting
- Error state visual feedback
- Loading state focus management
- Consistent focus behavior across themes

## Browser Compatibility

### Web-Specific Considerations
- Handle browser-specific keyboard events
- Optimize for different screen sizes
- Ensure consistent behavior across browsers
- Handle browser back/forward navigation

## Security Considerations

### Input Validation
- Client-side validation with server verification
- Sanitize input before processing
- Prevent injection attacks through input fields
- Secure handling of sensitive payment information