# Implementation Plan

- [x] 1. Create Focus Management Utility Class
  - Create `lib/utility/sales_focus_manager.dart` with focus transition logic
  - Implement methods for next/previous field navigation
  - Add auto-focus trigger handling
  - Include field validation with focus management
  - _Requirements: 1.1, 1.2, 1.3, 2.3_

- [x] 2. Enhance CommonInputField Widget
  - [x] 2.1 Add auto-focus and navigation parameters to CommonInputField
    - Add `autoFocus`, `previousFocusNode`, `onFieldComplete` parameters
    - Implement keyboard event handling (Tab, Shift+Tab, Enter, Escape)
    - Add focus transition logic in `onFieldSubmitted`
    - _Requirements: 1.1, 1.2, 2.3_

  - [x] 2.2 Implement enhanced keyboard handling in CommonInputField
    - Add `RawKeyboardListener` for advanced keyboard events
    - Handle Escape key to clear field and move to previous
    - Implement Shift+Tab for backward navigation
    - Add visual focus indicators and highlighting
    - _Requirements: 1.2, 2.3, 2.4_

- [-] 3. Update WebGeneralSalesController Focus Management
  - [x] 3.1 Initialize comprehensive focus node system
    - Add all missing focus nodes for header, grid, and footer fields
    - Create focus node disposal method in `onClose()`
    - Implement focus sequence mapping for logical navigation
    - _Requirements: 1.1, 1.2_

  - [x] 3.2 Implement auto-focus triggers and field completion handlers
    - Add auto-focus on controller initialization (date field)
    - Implement party selection auto-focus to next field
    - Add discount calculation with auto-focus transitions
    - Handle payment method changes with conditional focus
    - _Requirements: 1.3, 1.4, 1.5, 3.3, 3.4_

  - [x] 3.3 Add field validation with focus retention
    - Implement validation methods that maintain focus on error fields
    - Add error display with focus management
    - Create field completion detection logic
    - Handle form submission validation with focus on first error
    - _Requirements: 2.1, 2.2, 5.3_

- [x] 4. Enhance Sales Grid Focus Management
  - [x] 4.1 Implement dynamic row focus management in ItemRowModel
    - Add focus transition methods between grid columns
    - Implement auto-row creation when last row is completed
    - Handle row deletion with proper focus adjustment
    - Add grid navigation helpers (next row, previous row)
    - _Requirements: 1.2, 1.3, 5.1_

  - [x] 4.2 Update sales grid widget with enhanced focus handling
    - Modify `buildSalesGrid` method to use enhanced focus management
    - Add keyboard navigation between grid cells
    - Implement auto-focus after product/batch selection
    - Handle grid calculations with focus transitions
    - _Requirements: 1.2, 1.3, 5.1, 5.2_

- [x] 5. Enhance Dropdown Components
  - [x] 5.1 Update party dropdown with keyboard navigation
    - Add keyboard navigation support in `CommonSearchableDropdown2`
    - Implement auto-focus after party selection
    - Handle "not found" scenario with proper focus management
    - Add clear functionality with focus transitions
    - _Requirements: 1.3, 4.1, 4.2, 4.3, 4.4, 4.5_

  - [x] 5.2 Enhance product search dropdown in sales grid
    - Update `SearchField` implementation with focus management
    - Add auto-focus after product selection to batch field
    - Implement keyboard navigation in product suggestions
    - Handle search completion with proper focus transitions
    - _Requirements: 1.3, 4.1, 4.5_

- [x] 6. Implement Discount and Payment Field Enhancements
  - [x] 6.1 Update discount calculation with focus management
    - Modify `updateDiscountFromPercent` to include focus transitions
    - Update `updateDiscountFromAmount` with auto-focus logic
    - Add validation with focus retention for discount fields
    - Implement cross-field calculation updates with focus handling
    - _Requirements: 1.4, 3.1, 3.2_

  - [x] 6.2 Enhance payment method and cash received field handling
    - Update payment method dropdown with focus transitions
    - Implement conditional focus for cash received field
    - Add auto-population of cash received with focus management
    - Handle payment method changes with proper field visibility and focus
    - _Requirements: 1.5, 3.3, 3.4_

- [ ] 7. Update WebGeneralSalesView with Enhanced Focus Integration
  - [ ] 7.1 Integrate focus management in header section
    - Update `_buildHeaderSection` with enhanced focus parameters
    - Add auto-focus to date field on form load
    - Implement focus transitions between date and party fields
    - _Requirements: 1.1, 1.2_

  - [ ] 7.2 Update bottom navigation bar with focus management
    - Modify `buildSummaryAndActionsRow` to include focus handling
    - Add focus management to discount and payment fields
    - Implement form submission with validation and focus handling
    - Add keyboard shortcut support (Ctrl+S for submit)
    - _Requirements: 1.4, 1.5, 5.4, 5.5_

- [ ] 8. Add Keyboard Shortcuts and Global Handlers
  - [ ] 8.1 Implement GlobalShortcutManager enhancements
    - Add additional keyboard shortcuts for common actions
    - Implement focus-aware shortcut handling
    - Add escape key global handler for field clearing
    - Create shortcut help system
    - _Requirements: 5.5_

  - [ ] 8.2 Add form-level focus management
    - Implement form reset with focus management
    - Add focus restoration after dialogs/modals
    - Handle browser navigation with focus preservation
    - Create focus debugging utilities for development
    - _Requirements: 5.4_

- [ ] 9. Testing and Validation
  - [ ] 9.1 Create unit tests for focus management
    - Write tests for SalesFocusManager utility methods
    - Test focus transitions in enhanced CommonInputField
    - Create tests for controller focus management methods
    - Test validation with focus retention scenarios
    - _Requirements: All requirements validation_

  - [ ] 9.2 Create integration tests for complete workflow
    - Test full sales entry workflow using only keyboard navigation
    - Validate form submission with proper error handling and focus
    - Test sales grid operations with focus management
    - Create performance tests for focus transition efficiency
    - _Requirements: All requirements validation_

- [ ] 10. Documentation and Cleanup
  - [ ] 10.1 Add code documentation and comments
    - Document all new focus management methods
    - Add inline comments for complex focus transition logic
    - Create developer guide for focus management system
    - _Requirements: Maintainability_

  - [ ] 10.2 Performance optimization and cleanup
    - Optimize focus node creation and disposal
    - Remove any unused focus nodes or methods
    - Ensure proper memory management
    - Add performance monitoring for focus transitions
    - _Requirements: Performance and maintainability_