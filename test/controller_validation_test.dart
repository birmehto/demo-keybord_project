import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:demo/screens/transaction_management/web_sales/web_general_sales/web_general_sales_controller.dart';

void main() {
  group('WebGeneralSalesController Validation Tests', () {
    late WebGeneralSalesController controller;

    setUp(() {
      // Initialize GetX
      Get.testMode = true;
      controller = WebGeneralSalesController();
    });

    tearDown(() {
      controller.dispose();
      Get.reset();
    });

    test('should validate date field correctly', () {
      // Test empty date
      String? error = controller.getFieldValidator('date')?.call('');
      expect(error, 'Date is required');

      // Test valid date
      error = controller.getFieldValidator('date')?.call('2024-01-01');
      expect(error, null);
    });

    test('should validate discount percentage correctly', () {
      final validator = controller.getFieldValidator('discountPercent');

      // Test valid percentage
      String? error = validator?.call('10');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid discount percentage format');

      // Test negative percentage
      error = validator?.call('-5');
      expect(error, 'Discount percentage must be between 0 and 100');

      // Test percentage over 100
      error = validator?.call('150');
      expect(error, 'Discount percentage must be between 0 and 100');

      // Test empty value (should be valid as it's optional)
      error = validator?.call('');
      expect(error, null);
    });

    test('should validate discount amount correctly', () {
      // Set a subtotal to allow discount validation
      controller.subtotal.value = 1000.0;

      final validator = controller.getFieldValidator('discountAmount');

      // Test valid amount
      String? error = validator?.call('100');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid discount amount format');

      // Test negative amount
      error = validator?.call('-50');
      expect(error, 'Discount amount cannot be negative');

      // Test amount exceeding subtotal
      error = validator?.call('1500');
      expect(error, 'Discount amount cannot exceed subtotal');

      // Test empty value (should be valid as it's optional)
      error = validator?.call('');
      expect(error, null);
    });

    test('should validate cash received correctly', () {
      // Set payment method to Cash
      controller.selectedPaymentMethod.value = 'Cash';

      final validator = controller.getFieldValidator('cashReceived');

      // Test valid amount
      String? error = validator?.call('500');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid cash received amount format');

      // Test negative amount
      error = validator?.call('-100');
      expect(error, 'Cash received cannot be negative');

      // Test empty value (should be valid for non-cash payments)
      controller.selectedPaymentMethod.value = 'Credit';
      error = validator?.call('');
      expect(error, null);
    });

    test('should validate quantity correctly', () {
      final validator = controller.getFieldValidator('quantity');

      // Test valid quantity
      String? error = validator?.call('5');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid quantity format');

      // Test zero quantity
      error = validator?.call('0');
      expect(error, 'Quantity must be greater than 0');

      // Test negative quantity
      error = validator?.call('-2');
      expect(error, 'Quantity must be greater than 0');

      // Test empty value (should be valid as it's optional)
      error = validator?.call('');
      expect(error, null);
    });

    test('should validate rate correctly', () {
      final validator = controller.getFieldValidator('rate');

      // Test valid rate
      String? error = validator?.call('25.50');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid rate format');

      // Test negative rate
      error = validator?.call('-10');
      expect(error, 'Rate cannot be negative');

      // Test zero rate (should be valid)
      error = validator?.call('0');
      expect(error, null);

      // Test empty value (should be valid as it's optional)
      error = validator?.call('');
      expect(error, null);
    });

    test('should validate item discount correctly', () {
      final validator = controller.getFieldValidator('itemDiscount');

      // Test valid discount
      String? error = validator?.call('15');
      expect(error, null);

      // Test invalid format
      error = validator?.call('abc');
      expect(error, 'Invalid discount format');

      // Test negative discount
      error = validator?.call('-5');
      expect(error, 'Item discount must be between 0 and 100');

      // Test discount over 100
      error = validator?.call('120');
      expect(error, 'Item discount must be between 0 and 100');

      // Test empty value (should be valid as it's optional)
      error = validator?.call('');
      expect(error, null);
    });

    test('should detect field completion correctly', () {
      // Test date field completion
      expect(controller.isFieldCompleted('date', '2024-01-01'), true);
      expect(controller.isFieldCompleted('date', ''), false);

      // Test quantity field completion
      expect(controller.isFieldCompleted('quantity', '5'), true);
      expect(controller.isFieldCompleted('quantity', '0'), false);
      expect(controller.isFieldCompleted('quantity', 'abc'), false);

      // Test optional fields (should always be completed)
      expect(controller.isFieldCompleted('narration', ''), true);
      expect(controller.isFieldCompleted('discountPercent', ''), true);
    });
  });
}
