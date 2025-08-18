import 'package:demo/api/dio_client.dart';
import 'package:demo/app/app_date_format.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/app/app_url.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/screens/inventory_management/item/product_model.dart';
import 'package:demo/screens/inventory_management/tax/tax_response.dart';
import 'package:demo/screens/transaction_management/sales/sales_controller.dart';
import 'package:demo/utility/constants.dart';
import 'package:demo/utility/network.dart';
import 'package:demo/utility/sales_focus_manager.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_table_cell_container.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

class ItemRowModel {
  final packagingControllerHeader = TextEditingController();
  final rackControllerHeader = TextEditingController();
  final hsnCodeControllerHeader = TextEditingController();
  final gstControllerHeader = TextEditingController();
  FocusNode gstFocused = FocusNode();

  final productCDController = TextEditingController();
  final productController = TextEditingController();
  FocusNode productFocused = FocusNode();
  final batchController = TextEditingController();
  FocusNode batchFocused = FocusNode();
  final expiryDtController = TextEditingController();
  final qtyController = TextEditingController();
  FocusNode qtyFocused = FocusNode();
  final freeQtyController = TextEditingController();
  FocusNode freeQtyFocused = FocusNode();
  final rateController = TextEditingController();
  FocusNode rateFocused = FocusNode();
  final discountController = TextEditingController();
  FocusNode discountFocused = FocusNode();
  final mrpController = TextEditingController();
  final unitController = TextEditingController();
  final barcodeController = TextEditingController();
  final RxDouble total = 0.0.obs;

  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  final Rx<Itemdtls?> selectedBatch = Rx<Itemdtls?>(null);
  final RxList<Itemdtls> batchList = <Itemdtls>[].obs;

  var sizeIdxDtl = ''.obs;
  var blackListDtl = ''.obs;
  var pRateTaxDtl = ''.obs;
  var opRateDtl = ''.obs;
  var clRateDtl = ''.obs;
  var saleRate1Dtl = ''.obs;
  var saleRate2Dtl = ''.obs;
  var saleRate3Dtl = ''.obs;
  var saleRate4Dtl = ''.obs;
  var saleRate5Dtl = ''.obs;
  var saleRate6Dtl = ''.obs;
  var saleRate7Dtl = ''.obs;
  var saleRate8Dtl = ''.obs;
  var comRateDtl = ''.obs;
  var saleDiscDtl = ''.obs;
  var saleDisc1Dtl = ''.obs;
  var saleDisc2Dtl = ''.obs;
  var saleDisc3Dtl = ''.obs;
  var sioDiscDtl = ''.obs;
  var opStkDtl = ''.obs;
  var drStkDtl = ''.obs;
  var crStkDtl = ''.obs;
  var clStkDtl = ''.obs;
  var orStkDtl = ''.obs;
  var opDescDtl = ''.obs;
  var clDescDtl = ''.obs;
  var drBaseDtl = ''.obs;
  var drFrDtl = ''.obs;
  var crBaseDtl = ''.obs;
  var crFrDtl = ''.obs;
  var minStkDtl = ''.obs;
  var roStkDtl = ''.obs;
  var actualStkDtl = ''.obs;
  var mfgDtDtl = ''.obs;
  var desc1Dtl = ''.obs;
  var batchNoDtl = ''.obs;
  var desc3Dtl = ''.obs;

  ItemRowModel() {
    _addListeners();
  }

  void _addListeners() {
    void calculateTotal() {
      final qty = double.tryParse(qtyController.text) ?? 0;
      final rate = double.tryParse(rateController.text) ?? 0;
      final discount = double.tryParse(discountController.text) ?? 0;
      final gst = double.tryParse(gstControllerHeader.text) ?? 0;

      final double amount = qty * rate;
      final double disAmt = (amount * discount) / 100;
      final double gstAmt = (amount * gst) / 100;
      final double netAmt = amount + gstAmt - disAmt;

      total.value = netAmt;
    }

    qtyController.addListener(calculateTotal);
    rateController.addListener(calculateTotal);
    discountController.addListener(calculateTotal);
    gstControllerHeader.addListener(calculateTotal);
  }

  void clearProductBatchFields({bool unfocus = true}) {
    if (unfocus) Utils.closeKeyboard(Get.context!);
    selectedProduct.value = null;
    productController.clear();
    gstControllerHeader.clear();

    packagingControllerHeader.clear();
    rackControllerHeader.clear();
    hsnCodeControllerHeader.clear();

    batchList.clear();

    clearBatchFields();
  }

  void clearBatchFields({bool unfocus = true}) {
    if (unfocus) Utils.closeKeyboard(Get.context!);

    batchController.clear();
    expiryDtController.clear();
    qtyController.clear();
    freeQtyController.clear();
    rateController.clear();
    discountController.clear();
    gstControllerHeader.clear();
    total.value = 0.0;
    selectedBatch.value = null;

    sizeIdxDtl.value = '';
    blackListDtl.value = '';
    pRateTaxDtl.value = '';
    opRateDtl.value = '';
    clRateDtl.value = '';
    saleRate1Dtl.value = '';
    saleRate2Dtl.value = '';
    saleRate3Dtl.value = '';
    saleRate4Dtl.value = '';
    saleRate5Dtl.value = '';
    saleRate6Dtl.value = '';
    saleRate7Dtl.value = '';
    saleRate8Dtl.value = '';
    comRateDtl.value = '';
    saleDiscDtl.value = '';
    saleDisc1Dtl.value = '';
    saleDisc2Dtl.value = '';
    saleDisc3Dtl.value = '';
    sioDiscDtl.value = '';
    opStkDtl.value = '';
    drStkDtl.value = '';
    crStkDtl.value = '';
    clStkDtl.value = '';
    orStkDtl.value = '';
    opDescDtl.value = '';
    clDescDtl.value = '';
    drBaseDtl.value = '';
    drFrDtl.value = '';
    crBaseDtl.value = '';
    crFrDtl.value = '';
    minStkDtl.value = '';
    roStkDtl.value = '';
    actualStkDtl.value = '';
    mfgDtDtl.value = '';
    desc1Dtl.value = '';
    batchNoDtl.value = '';
    desc3Dtl.value = '';
  }

  /// Validates a field in this row and returns error message if any
  String? validateField(String fieldType, String value) {
    switch (fieldType) {
      case 'product':
        if (value.trim().isEmpty && _hasAnyData()) {
          return 'Product is required when other fields have data';
        }
        break;

      case 'quantity':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid quantity format';
          }
          if (parsed <= 0) {
            return 'Quantity must be greater than 0';
          }
        } else if (_hasAnyData()) {
          return 'Quantity is required';
        }
        break;

      case 'rate':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid rate format';
          }
          if (parsed < 0) {
            return 'Rate cannot be negative';
          }
        } else if (_hasAnyData()) {
          return 'Rate is required';
        }
        break;

      case 'discount':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid discount format';
          }
          if (parsed < 0 || parsed > 100) {
            return 'Discount must be between 0 and 100';
          }
        }
        break;

      case 'freeQty':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid free quantity format';
          }
          if (parsed < 0) {
            return 'Free quantity cannot be negative';
          }
        }
        break;
    }

    return null; // No validation error
  }

  /// Checks if this row has any data in key fields
  bool _hasAnyData() {
    return productController.text.trim().isNotEmpty ||
        qtyController.text.trim().isNotEmpty ||
        rateController.text.trim().isNotEmpty ||
        batchController.text.trim().isNotEmpty;
  }

  /// Gets validator function for a specific field type in this row
  String? Function(String?)? getFieldValidator(String fieldType) {
    return (String? value) => validateField(fieldType, value ?? '');
  }

  // Focus Management Methods for Grid Navigation

  /// Gets the focus node for a specific field type in this row
  FocusNode? getFocusNodeForField(String fieldType) {
    switch (fieldType) {
      case 'product':
        return productFocused;
      case 'batch':
        return batchFocused;
      case 'quantity':
        return qtyFocused;
      case 'freeQty':
        return freeQtyFocused;
      case 'rate':
        return rateFocused;
      case 'discount':
        return discountFocused;
      case 'gst':
        return gstFocused;
      default:
        return null;
    }
  }

  /// Gets the next focus node in the row sequence
  FocusNode? getNextFocusInRow(String currentField) {
    switch (currentField) {
      case 'product':
        return batchFocused;
      case 'batch':
        return qtyFocused;
      case 'quantity':
        return freeQtyFocused;
      case 'freeQty':
        return rateFocused;
      case 'rate':
        return discountFocused;
      case 'discount':
        return gstFocused;
      case 'gst':
        return null; // End of row, move to next row or footer
      default:
        return null;
    }
  }

  /// Gets the previous focus node in the row sequence
  FocusNode? getPreviousFocusInRow(String currentField) {
    switch (currentField) {
      case 'gst':
        return discountFocused;
      case 'discount':
        return rateFocused;
      case 'rate':
        return freeQtyFocused;
      case 'freeQty':
        return qtyFocused;
      case 'quantity':
        return batchFocused;
      case 'batch':
        return productFocused;
      case 'product':
        return null; // Beginning of row, move to previous row or header
      default:
        return null;
    }
  }

  /// Moves focus to the next field within this row
  void moveToNextFieldInRow(String currentField) {
    final nextFocus = getNextFocusInRow(currentField);
    if (nextFocus != null) {
      nextFocus.requestFocus();
    }
  }

  /// Moves focus to the previous field within this row
  void moveToPreviousFieldInRow(String currentField) {
    final previousFocus = getPreviousFocusInRow(currentField);
    if (previousFocus != null) {
      previousFocus.requestFocus();
    }
  }

  /// Checks if this row is completed (has all required fields filled)
  bool isRowCompleted() {
    return productController.text.trim().isNotEmpty &&
        qtyController.text.trim().isNotEmpty &&
        rateController.text.trim().isNotEmpty &&
        double.tryParse(qtyController.text) != null &&
        double.parse(qtyController.text) > 0 &&
        double.tryParse(rateController.text) != null &&
        double.parse(rateController.text) >= 0;
  }

  /// Checks if this row has any data in any field
  bool hasAnyData() {
    return _hasAnyData();
  }

  /// Checks if this row is empty (no data in any field)
  bool isEmpty() {
    return productController.text.trim().isEmpty &&
        batchController.text.trim().isEmpty &&
        qtyController.text.trim().isEmpty &&
        freeQtyController.text.trim().isEmpty &&
        rateController.text.trim().isEmpty &&
        discountController.text.trim().isEmpty;
  }

  /// Gets the first empty required field in this row
  FocusNode? getFirstEmptyRequiredField() {
    if (productController.text.trim().isEmpty) {
      return productFocused;
    }
    if (qtyController.text.trim().isEmpty) {
      return qtyFocused;
    }
    if (rateController.text.trim().isEmpty) {
      return rateFocused;
    }
    return null; // All required fields are filled
  }

  /// Focuses on the first empty required field in this row
  void focusFirstEmptyField() {
    final emptyField = getFirstEmptyRequiredField();
    if (emptyField != null) {
      emptyField.requestFocus();
    }
  }

  void dispose() {
    packagingControllerHeader.dispose();
    rackControllerHeader.dispose();
    hsnCodeControllerHeader.dispose();
    gstControllerHeader.dispose();
    gstFocused.dispose();

    productCDController.dispose();
    productController.dispose();
    productFocused.dispose();

    batchController.dispose();
    batchFocused.dispose();

    expiryDtController.dispose();
    qtyController.dispose();
    qtyFocused.dispose();

    freeQtyController.dispose();
    freeQtyFocused.dispose();

    rateController.dispose();
    rateFocused.dispose();

    discountController.dispose();
    discountFocused.dispose();

    mrpController.dispose();
    unitController.dispose();
    barcodeController.dispose();
  }

  @override
  String toString() {
    return '''
SalesRowModel(
  Product: ${productController.text},
  ProductCD: ${productCDController.text},
  Batch: ${batchController.text},
  Expiry: ${expiryDtController.text},
  Qty: ${qtyController.text},
  FreeQty: ${freeQtyController.text},
  Rate: ${rateController.text},
  Discount: ${discountController.text},
  GST: ${gstControllerHeader.text},
  Total: ${total.value.toStringAsFixed(2)},
  MRP: ${mrpController.text},
  Unit: ${unitController.text},
  Barcode: ${barcodeController.text}
)''';
  }
}

class WebGeneralSalesController extends GetxController {
  var moduleNo = ''.obs;
  var salesID = ''.obs;
  var salesInsertType = ''.obs;

  // Header section focus nodes
  var dtController = TextEditingController().obs;
  var dtFocus = FocusNode();

  var isDropdownPartyLoading = false.obs;
  var partyList = PartyResponse().obs;
  var selectedDropdownParty = Rx<PartyModel?>(null);
  var selectedDropdownPartyName = ''.obs;
  var selectedDropdownPartyCode = ''.obs;
  var selectedDropdownStateCD = ''.obs;
  var selectedDropdownStateName = ''.obs;
  var selectedDropdownOutState = ''.obs;
  var insertACCCd = ''.obs;
  var partyController = TextEditingController().obs;
  var partyFocus = FocusNode();

  // Focus sequence mapping for logical navigation
  late Map<String, FocusNode> focusSequence;
  late List<String> fieldOrder;

  var isLoading = false.obs;
  var mainList = ProductResponse().obs;
  var searchList = <ProductModel>[].obs;
  var errorMsg = ''.obs;

  var extractedData = [];
  var taxList = TaxResponse().obs;
  var searchTaxList = <TaxModel>[].obs;

  List<Map<String, dynamic>> cartItems = [];

  var rows = <ItemRowModel>[ItemRowModel()].obs;

  var subtotal = 0.0.obs;
  var totalDiscount = 0.0.obs;
  var totalGST = 0.0.obs;
  var netAmount = 0.0.obs;
  var roundOff = 0.0.obs;

  var selectedPaymentMethod = 'Credit'.obs;
  var discountPercent = 0.0.obs;
  var discountAmount = 0.0.obs;
  var discountAmtController = TextEditingController().obs;
  var discountAmtFocus = FocusNode();
  var discountPerController = TextEditingController().obs;
  var discountPerFocus = FocusNode();
  var cashReceivedController = TextEditingController().obs;
  var cashReceivedFocus = FocusNode();
  var narrationController = TextEditingController().obs;
  var narrationFocus = FocusNode();

  var isButtonClick = ''.obs;
  var isBottomLoading = false.obs;
  var isBottomDisable = false.obs;

  @override
  void onInit() async {
    super.onInit();
    moduleNo.value = Get.arguments?['ModuleNo'].toString() ?? '';
    salesID.value = Get.arguments?['SalesID'].toString() ?? '';
    salesInsertType.value = Get.arguments?['Type'].toString() ?? '';

    // Initialize focus management system
    initializeFocusNodes();
    setupFocusListeners();

    final isUpdate = salesID.value.isNotEmpty && salesInsertType.value == 'U';

    if (isUpdate) {
      // Handle update mode if needed
    } else {
      dtController.value.text = AppDatePicker.currentDate();
      // Auto-focus on date field after initialization
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SalesFocusManager.autoFocusOnLoad(dtFocus);
      });
    }

    await fetchParty();
    await fetchTax();
  }

  @override
  void onClose() {
    // Dispose all rows when controller is closed
    for (var row in rows) {
      row.dispose();
    }
    rows.clear();

    // Dispose all focus nodes
    disposeFocusNodes();

    super.onClose();
  }

  void recalculateTotals(List<ItemRowModel> rows, List<TaxModel> taxRates) {
    double sub = 0.0, itemLevelDisc = 0.0, gst = 0.0;

    for (final row in rows) {
      final qty = double.tryParse(row.qtyController.text.trim()) ?? 0;
      final rate = double.tryParse(row.rateController.text.trim()) ?? 0;
      final discount = double.tryParse(row.discountController.text.trim()) ?? 0;
      final gstPerc =
          double.tryParse(row.gstControllerHeader.text.trim()) ??
          (row.selectedProduct.value?.gSTPERC ?? 0);

      if (qty > 0 && rate > 0) {
        final lineTotal = qty * rate;
        final lineDiscAmt = (lineTotal * discount) / 100;
        final lineGstAmt = (lineTotal * gstPerc) / 100;

        sub += lineTotal;
        itemLevelDisc += lineDiscAmt;
        gst += lineGstAmt;
      }
    }

    final globalDiscAmt = discountAmount.value;
    final double net = sub - itemLevelDisc - globalDiscAmt + gst;
    final double roundedNet = net.roundToDouble();
    final double roundAdjustment = roundedNet - net;

    subtotal.value = sub;
    totalDiscount.value = itemLevelDisc + globalDiscAmt;
    totalGST.value = gst;
    roundOff.value = roundAdjustment;
    netAmount.value = roundedNet;

    // Update cash received field if payment method is Cash
    updateCashReceivedOnAmountChange();
  }

  // Focus Management Methods
  void initializeFocusNodes() {
    // Initialize focus sequence mapping
    focusSequence = {
      'date': dtFocus,
      'party': partyFocus,
      'discountPercent': discountPerFocus,
      'discountAmount': discountAmtFocus,
      'cashReceived': cashReceivedFocus,
      'narration': narrationFocus,
    };

    // Define field order for logical navigation
    fieldOrder = [
      'date',
      'party',
      'discountPercent',
      'discountAmount',
      'cashReceived',
      'narration',
    ];
  }

  void setupFocusListeners() {
    // Add focus listeners for auto-focus triggers with validation
    dtFocus.addListener(() {
      if (!dtFocus.hasFocus && dtController.value.text.isNotEmpty) {
        onFieldCompleteWithValidation(
          'date',
          dtController.value.text,
          dtFocus,
          partyFocus,
        );
      }
    });

    // Add listener to date controller for changes
    dtController.value.addListener(() {
      if (dtController.value.text.isNotEmpty) {
        // Small delay to ensure the date picker has finished updating
        Future.delayed(const Duration(milliseconds: 50), () {
          onFieldCompleteWithValidation(
            'date',
            dtController.value.text,
            dtFocus,
            partyFocus,
          );
        });
      }
    });

    partyFocus.addListener(() {
      if (!partyFocus.hasFocus && selectedDropdownParty.value != null) {
        onFieldCompleteWithValidation(
          'party',
          '',
          partyFocus,
          rows.isNotEmpty ? rows.first.productFocused : null,
        );
      }
    });

    discountPerFocus.addListener(() {
      if (!discountPerFocus.hasFocus &&
          discountPerController.value.text.isNotEmpty) {
        onFieldCompleteWithValidation(
          'discountPercent',
          discountPerController.value.text,
          discountPerFocus,
          discountAmtFocus,
        );
      }
    });

    discountAmtFocus.addListener(() {
      if (!discountAmtFocus.hasFocus &&
          discountAmtController.value.text.isNotEmpty) {
        final nextFocus =
            selectedPaymentMethod.value == 'Cash'
                ? cashReceivedFocus
                : narrationFocus;
        onFieldCompleteWithValidation(
          'discountAmount',
          discountAmtController.value.text,
          discountAmtFocus,
          nextFocus,
        );
      }
    });

    // Listen for payment method changes
    selectedPaymentMethod.listen((paymentMethod) {
      onPaymentMethodChanged(paymentMethod);
    });
  }

  void disposeFocusNodes() {
    // Dispose all controllers
    dtController.value.dispose();
    partyController.value.dispose();
    discountAmtController.value.dispose();
    discountPerController.value.dispose();
    cashReceivedController.value.dispose();
    narrationController.value.dispose();

    // Dispose all focus nodes
    dtFocus.dispose();
    partyFocus.dispose();
    discountAmtFocus.dispose();
    discountPerFocus.dispose();
    cashReceivedFocus.dispose();
    narrationFocus.dispose();
  }

  void handleAutoFocus(String triggerField) {
    switch (triggerField) {
      case 'date':
        // After date entry, focus on party field
        SalesFocusManager.moveToNextField(dtFocus, partyFocus);
        break;
      case 'party':
        // After party selection, focus on first sales grid row
        if (rows.isNotEmpty) {
          SalesFocusManager.moveToNextField(
            partyFocus,
            rows.first.productFocused,
          );
        }
        break;
      case 'discountPercent':
        // After discount percent, focus on discount amount
        SalesFocusManager.moveToNextField(discountPerFocus, discountAmtFocus);
        break;
      case 'discountAmount':
        // After discount amount, check payment method and focus accordingly
        if (selectedPaymentMethod.value == 'Cash') {
          SalesFocusManager.moveToNextField(
            discountAmtFocus,
            cashReceivedFocus,
          );
        } else {
          SalesFocusManager.moveToNextField(discountAmtFocus, narrationFocus);
        }
        break;
    }
  }

  /// Handles party selection and triggers auto-focus to next field
  void onPartySelected(PartyModel? party) {
    if (party == null) return;

    selectedDropdownParty.value = party;
    selectedDropdownPartyName.value = party.aCCNAME ?? '';
    selectedDropdownPartyCode.value = party.aCCCD ?? '';
    partyController.value.text = party.aCCNAME ?? '';
    selectedDropdownStateCD.value = party.sTATECODE?.toString() ?? '';
    selectedDropdownStateName.value = party.sTATE?.toString() ?? '';
    selectedDropdownOutState.value = party.oUTSTATE?.toString() ?? '';

    // Trigger auto-focus to next field after party selection
    handleAutoFocus('party');
  }

  /// Handles payment method changes with conditional focus management
  void onPaymentMethodChanged(String paymentMethod) {
    selectedPaymentMethod.value = paymentMethod;

    if (paymentMethod == 'Cash') {
      // Auto-populate cash received with net amount
      cashReceivedController.value.text = netAmount.value.toStringAsFixed(2);

      // Focus on cash received field after a short delay to ensure UI is updated
      Future.delayed(const Duration(milliseconds: 150), () {
        if (cashReceivedFocus.canRequestFocus) {
          SalesFocusManager.autoFocusOnLoad(cashReceivedFocus);
        }
      });
    } else {
      // Clear cash received field for non-cash payments
      cashReceivedController.value.clear();

      // Focus on narration field for non-cash payments
      Future.delayed(const Duration(milliseconds: 150), () {
        if (narrationFocus.canRequestFocus) {
          SalesFocusManager.autoFocusOnLoad(narrationFocus);
        }
      });
    }

    // Trigger field visibility updates
    update();
  }

  /// Enhanced payment method dropdown with focus transitions
  void handlePaymentMethodSelection(String paymentMethod) {
    // Validate current field state before changing payment method
    final currentDiscountAmtValue = discountAmtController.value.text;

    // If discount amount field has focus and is valid, proceed with payment method change
    if (discountAmtFocus.hasFocus && currentDiscountAmtValue.isNotEmpty) {
      if (!validateFieldWithFocus(
        'discountAmount',
        currentDiscountAmtValue,
        discountAmtFocus,
      )) {
        // Validation failed, don't change payment method yet
        return;
      }
    }

    // Change payment method and handle focus transitions
    onPaymentMethodChanged(paymentMethod);
  }

  /// Auto-populates cash received field when net amount changes
  void updateCashReceivedOnAmountChange() {
    if (selectedPaymentMethod.value == 'Cash') {
      // Only auto-update if the field is empty or contains the previous net amount
      final currentValue =
          double.tryParse(cashReceivedController.value.text) ?? 0.0;
      final netValue = netAmount.value;

      // Auto-update if field is empty or if it matches a calculated amount
      if (cashReceivedController.value.text.isEmpty ||
          (currentValue > 0 && (currentValue - netValue).abs() < 0.01)) {
        cashReceivedController.value.text = netValue.toStringAsFixed(2);
      }
    }
  }

  /// Handles cash received field changes with validation
  void onCashReceivedChanged(String value) {
    if (selectedPaymentMethod.value != 'Cash') return;

    if (value.trim().isNotEmpty) {
      final parsed = double.tryParse(value);
      if (parsed == null) {
        showFieldError(
          'Invalid cash received amount format',
          cashReceivedFocus,
        );
        return;
      }
      if (parsed < 0) {
        showFieldError('Cash received cannot be negative', cashReceivedFocus);
        return;
      }

      // Optional: Warn if cash received is less than net amount
      if (parsed < netAmount.value) {
        // This is just a warning, not an error - user might pay partial amount
        // Could show a subtle warning without blocking focus transition
      }
    }

    // If validation passes, allow focus to move to next field
    Future.delayed(const Duration(milliseconds: 100), () {
      if (narrationFocus.canRequestFocus) {
        SalesFocusManager.moveToNextField(cashReceivedFocus, narrationFocus);
      }
    });
  }

  /// Handles field completion for various field types
  void onFieldComplete(String fieldType, dynamic value) {
    switch (fieldType) {
      case 'date':
        if (value != null && value.toString().isNotEmpty) {
          handleAutoFocus('date');
        }
        break;
      case 'party':
        if (selectedDropdownParty.value != null) {
          handleAutoFocus('party');
        }
        break;
      case 'discountPercent':
        if (value != null && value.toString().isNotEmpty) {
          handleAutoFocus('discountPercent');
        }
        break;
      case 'discountAmount':
        if (value != null && value.toString().isNotEmpty) {
          handleAutoFocus('discountAmount');
        }
        break;
    }
  }

  FocusNode? getNextFocusNode(String currentField) {
    final currentIndex = fieldOrder.indexOf(currentField);
    if (currentIndex != -1 && currentIndex < fieldOrder.length - 1) {
      final nextField = fieldOrder[currentIndex + 1];
      return focusSequence[nextField];
    }
    return null;
  }

  FocusNode? getPreviousFocusNode(String currentField) {
    final currentIndex = fieldOrder.indexOf(currentField);
    if (currentIndex > 0) {
      final previousField = fieldOrder[currentIndex - 1];
      return focusSequence[previousField];
    }
    return null;
  }

  void moveToNextSalesGridRow() {
    // Find current focused row and move to next row's first field
    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.productFocused.hasFocus ||
          row.batchFocused.hasFocus ||
          row.qtyFocused.hasFocus ||
          row.freeQtyFocused.hasFocus ||
          row.rateFocused.hasFocus ||
          row.discountFocused.hasFocus ||
          row.gstFocused.hasFocus) {
        // If not the last row, move to next row
        if (i < rows.length - 1) {
          SalesFocusManager.moveToNextField(null, rows[i + 1].productFocused);
        } else {
          // If last row, move to discount fields
          SalesFocusManager.moveToNextField(null, discountPerFocus);
        }
        break;
      }
    }
  }

  // Enhanced Grid Focus Management Methods

  /// Moves focus to the next field in the grid (within row or to next row)
  void moveToNextGridField(int rowIndex, String currentField) {
    if (rowIndex < 0 || rowIndex >= rows.length) return;

    final currentRow = rows[rowIndex];
    final nextFocusInRow = currentRow.getNextFocusInRow(currentField);

    if (nextFocusInRow != null) {
      // Move to next field in same row
      SalesFocusManager.moveToNextField(null, nextFocusInRow);
    } else {
      // End of row, move to next row or footer
      if (rowIndex < rows.length - 1) {
        // Move to first field of next row
        SalesFocusManager.moveToNextField(
          null,
          rows[rowIndex + 1].productFocused,
        );
      } else {
        // Last row, check if we need to create a new row or move to footer
        if (currentRow.isRowCompleted()) {
          // Create new row and focus on it
          addRowAndFocus();
        } else {
          // Move to discount fields
          SalesFocusManager.moveToNextField(null, discountPerFocus);
        }
      }
    }
  }

  /// Moves focus to the previous field in the grid (within row or to previous row)
  void moveToPreviousGridField(int rowIndex, String currentField) {
    if (rowIndex < 0 || rowIndex >= rows.length) return;

    final currentRow = rows[rowIndex];
    final previousFocusInRow = currentRow.getPreviousFocusInRow(currentField);

    if (previousFocusInRow != null) {
      // Move to previous field in same row
      SalesFocusManager.moveToNextField(null, previousFocusInRow);
    } else {
      // Beginning of row, move to previous row or header
      if (rowIndex > 0) {
        // Move to last field of previous row
        SalesFocusManager.moveToNextField(null, rows[rowIndex - 1].gstFocused);
      } else {
        // First row, move to party field
        SalesFocusManager.moveToNextField(null, partyFocus);
      }
    }
  }

  /// Adds a new row and focuses on its first field
  void addRowAndFocus() {
    final newRow = ItemRowModel();
    rows.add(newRow);

    // Focus on the product field of the new row
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SalesFocusManager.autoFocusOnLoad(newRow.productFocused);
    });
  }

  /// Removes a row and adjusts focus appropriately
  void removeRowWithFocusAdjustment(int index) {
    if (index < 0 || index >= rows.length) return;

    final currentRow = rows[index];
    bool hadFocus = _rowHasFocus(currentRow);
    FocusNode? focusTarget;

    // Determine where to move focus after deletion
    if (hadFocus) {
      if (index > 0) {
        // Focus on the same field in the previous row
        final previousRow = rows[index - 1];
        focusTarget = previousRow.productFocused;
      } else if (rows.length > 1) {
        // Focus on the same field in the next row (which will become index 0)
        final nextRow = rows[index + 1];
        focusTarget = nextRow.productFocused;
      } else {
        // Only one row, focus on party field
        focusTarget = partyFocus;
      }
    }

    // Check if row is blank (all key fields empty)
    final isBlankRow = currentRow.isEmpty();

    // If it's the last row and blank, do not delete
    if (rows.length == 1 && isBlankRow) return;

    currentRow.dispose();
    rows.removeAt(index);

    // Ensure at least one blank row always remains
    if (rows.isEmpty ||
        rows.every((r) => r.productController.text.trim().isNotEmpty)) {
      addRow();
    }

    // Apply focus if needed
    if (focusTarget != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SalesFocusManager.autoFocusOnLoad(focusTarget!);
      });
    }

    recalculateTotals(rows, searchTaxList);
  }

  /// Checks if any field in the given row currently has focus
  bool _rowHasFocus(ItemRowModel row) {
    return row.productFocused.hasFocus ||
        row.batchFocused.hasFocus ||
        row.qtyFocused.hasFocus ||
        row.freeQtyFocused.hasFocus ||
        row.rateFocused.hasFocus ||
        row.discountFocused.hasFocus ||
        row.gstFocused.hasFocus;
  }

  /// Gets the index of the currently focused row
  int getCurrentFocusedRowIndex() {
    for (int i = 0; i < rows.length; i++) {
      if (_rowHasFocus(rows[i])) {
        return i;
      }
    }
    return -1; // No row has focus
  }

  /// Gets the currently focused field type in the grid
  String? getCurrentFocusedFieldType() {
    for (final row in rows) {
      if (row.productFocused.hasFocus) return 'product';
      if (row.batchFocused.hasFocus) return 'batch';
      if (row.qtyFocused.hasFocus) return 'quantity';
      if (row.freeQtyFocused.hasFocus) return 'freeQty';
      if (row.rateFocused.hasFocus) return 'rate';
      if (row.discountFocused.hasFocus) return 'discount';
      if (row.gstFocused.hasFocus) return 'gst';
    }
    return null;
  }

  /// Moves to the next row in the grid
  void moveToNextRow() {
    final currentRowIndex = getCurrentFocusedRowIndex();
    if (currentRowIndex != -1 && currentRowIndex < rows.length - 1) {
      // Move to the same field type in the next row
      final currentFieldType = getCurrentFocusedFieldType();
      if (currentFieldType != null) {
        final nextRow = rows[currentRowIndex + 1];
        final targetFocus = nextRow.getFocusNodeForField(currentFieldType);
        if (targetFocus != null) {
          SalesFocusManager.moveToNextField(null, targetFocus);
        }
      }
    }
  }

  /// Moves to the previous row in the grid
  void moveToPreviousRow() {
    final currentRowIndex = getCurrentFocusedRowIndex();
    if (currentRowIndex > 0) {
      // Move to the same field type in the previous row
      final currentFieldType = getCurrentFocusedFieldType();
      if (currentFieldType != null) {
        final previousRow = rows[currentRowIndex - 1];
        final targetFocus = previousRow.getFocusNodeForField(currentFieldType);
        if (targetFocus != null) {
          SalesFocusManager.moveToNextField(null, targetFocus);
        }
      }
    }
  }

  /// Handles auto-row creation when the last row is completed
  void handleAutoRowCreation(int rowIndex, String fieldType) {
    if (rowIndex == rows.length - 1) {
      // Last row
      final currentRow = rows[rowIndex];

      // Check if this is the last field in the row and row is completed
      if (fieldType == 'gst' && currentRow.isRowCompleted()) {
        addRowAndFocus();
      }
    }
  }

  void focusFirstEmptyField() {
    // Focus on first empty required field
    if (dtController.value.text.isEmpty) {
      dtFocus.requestFocus();
    } else if (selectedDropdownParty.value == null) {
      partyFocus.requestFocus();
    } else if (rows.isEmpty || rows.first.productController.text.isEmpty) {
      if (rows.isNotEmpty) {
        rows.first.productFocused.requestFocus();
      }
    }
  }

  // Validation Methods with Focus Retention

  /// Validates a field and maintains focus on error fields
  /// Returns true if validation passes, false otherwise
  bool validateFieldWithFocus(
    String fieldType,
    String value,
    FocusNode fieldFocus,
  ) {
    String? errorMessage = _getFieldValidationError(fieldType, value);

    if (errorMessage != null) {
      // Show error and maintain focus on problematic field
      showFieldError(errorMessage, fieldFocus);
      return false;
    }

    return true;
  }

  /// Gets validation error message for a specific field type
  /// Returns null if validation passes, error message if validation fails
  String? _getFieldValidationError(String fieldType, String value) {
    switch (fieldType) {
      case 'date':
        if (value.trim().isEmpty) {
          return 'Date is required';
        }
        // Additional date format validation can be added here
        break;

      case 'party':
        if (selectedDropdownParty.value == null) {
          return 'Party selection is required';
        }
        break;

      case 'discountPercent':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid discount percentage format';
          }
          if (parsed < 0 || parsed > 100) {
            return 'Discount percentage must be between 0 and 100';
          }
        }
        break;

      case 'discountAmount':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid discount amount format';
          }
          if (parsed < 0) {
            return 'Discount amount cannot be negative';
          }
          if (parsed > subtotal.value) {
            return 'Discount amount cannot exceed subtotal';
          }
        }
        break;

      case 'cashReceived':
        if (selectedPaymentMethod.value == 'Cash' && value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid cash received amount format';
          }
          if (parsed < 0) {
            return 'Cash received cannot be negative';
          }
        }
        break;

      case 'quantity':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid quantity format';
          }
          if (parsed <= 0) {
            return 'Quantity must be greater than 0';
          }
        }
        break;

      case 'rate':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid rate format';
          }
          if (parsed < 0) {
            return 'Rate cannot be negative';
          }
        }
        break;

      case 'itemDiscount':
        if (value.trim().isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Invalid discount format';
          }
          if (parsed < 0 || parsed > 100) {
            return 'Item discount must be between 0 and 100';
          }
        }
        break;
    }

    return null; // No validation error
  }

  /// Displays field error message and maintains focus on the error field
  void showFieldError(String message, FocusNode errorField) {
    // Show error message using snackbar
    AppSnackBar.showGetXCustomSnackBar(message: message, isError: true);

    // Maintain focus on the error field
    Future.delayed(const Duration(milliseconds: 100), () {
      if (errorField.canRequestFocus) {
        errorField.requestFocus();
      }
    });
  }

  /// Detects if a field is completed based on field type and value
  bool isFieldCompleted(String fieldType, String value) {
    switch (fieldType) {
      case 'date':
        return value.trim().isNotEmpty;

      case 'party':
        return selectedDropdownParty.value != null;

      case 'discountPercent':
      case 'discountAmount':
      case 'cashReceived':
      case 'narration':
        // These fields are optional, so they're always considered "completed"
        return true;

      case 'quantity':
      case 'rate':
        return value.trim().isNotEmpty &&
            double.tryParse(value) != null &&
            double.parse(value) > 0;

      case 'product':
        // For grid fields, check if product is selected
        return value.trim().isNotEmpty;

      case 'batch':
        // Batch might be optional depending on product
        return true;

      case 'itemDiscount':
        // Item discount is optional
        return true;

      default:
        return value.trim().isNotEmpty;
    }
  }

  /// Validates all form fields and focuses on first error field
  /// Returns true if all validations pass, false otherwise
  bool validateFormWithFocus() {
    // Validate header fields first
    if (!validateFieldWithFocus('date', dtController.value.text, dtFocus)) {
      return false;
    }

    if (!validateFieldWithFocus('party', '', partyFocus)) {
      return false;
    }

    // Validate sales grid - at least one row with product and quantity
    bool hasValidItems = false;
    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];

      // Check if row has any data
      final hasProduct = row.productController.text.trim().isNotEmpty;
      final hasQuantity = row.qtyController.text.trim().isNotEmpty;
      final hasRate = row.rateController.text.trim().isNotEmpty;

      if (hasProduct || hasQuantity || hasRate) {
        // If row has any data, validate all required fields
        if (!validateFieldWithFocus(
          'product',
          row.productController.text,
          row.productFocused,
        )) {
          return false;
        }

        if (!validateFieldWithFocus(
          'quantity',
          row.qtyController.text,
          row.qtyFocused,
        )) {
          return false;
        }

        if (!validateFieldWithFocus(
          'rate',
          row.rateController.text,
          row.rateFocused,
        )) {
          return false;
        }

        // Validate item discount if provided
        if (!validateFieldWithFocus(
          'itemDiscount',
          row.discountController.text,
          row.discountFocused,
        )) {
          return false;
        }

        hasValidItems = true;
      }
    }

    // Check if at least one valid item exists
    if (!hasValidItems) {
      showFieldError(
        'At least one item is required',
        rows.first.productFocused,
      );
      return false;
    }

    // Validate discount fields
    if (!validateFieldWithFocus(
      'discountPercent',
      discountPerController.value.text,
      discountPerFocus,
    )) {
      return false;
    }

    if (!validateFieldWithFocus(
      'discountAmount',
      discountAmtController.value.text,
      discountAmtFocus,
    )) {
      return false;
    }

    // Validate cash received if payment method is Cash
    if (selectedPaymentMethod.value == 'Cash') {
      if (!validateFieldWithFocus(
        'cashReceived',
        cashReceivedController.value.text,
        cashReceivedFocus,
      )) {
        return false;
      }
    }

    return true;
  }

  /// Enhanced field completion handler with validation
  void onFieldCompleteWithValidation(
    String fieldType,
    String value,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    // First validate the field
    if (!validateFieldWithFocus(fieldType, value, currentFocus)) {
      // Validation failed, focus remains on current field
      return;
    }

    // Check if field is completed
    if (!isFieldCompleted(fieldType, value)) {
      // Field not completed, focus remains on current field
      return;
    }

    // Field is valid and completed, trigger auto-focus
    onFieldComplete(fieldType, value);

    // Move to next field if specified
    if (nextFocus != null) {
      SalesFocusManager.moveToNextField(currentFocus, nextFocus);
    }
  }

  /// Validates and submits the form
  Future<void> validateAndSubmitForm() async {
    // Validate all form fields
    if (!validateFormWithFocus()) {
      // Validation failed, focus is already set on error field
      return;
    }

    // All validations passed, proceed with form submission
    await submitForm();
  }

  /// Placeholder for form submission logic
  Future<void> submitForm() async {
    try {
      isBottomLoading.value = true;
      isBottomDisable.value = true;

      // TODO: Implement actual form submission logic here
      // This would typically involve API calls to save the sales data

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Sales transaction saved successfully',
        isError: false,
      );

      // Optionally reset form or navigate away
      // resetForm();
    } catch (e) {
      // Handle submission error
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Failed to save sales transaction: ${e.toString()}',
        isError: true,
      );
    } finally {
      isBottomLoading.value = false;
      isBottomDisable.value = false;
    }
  }

  /// Handles validation errors from input fields
  void onFieldValidationError(String errorMessage) {
    showFieldError(
      errorMessage,
      FocusNode(),
    ); // Focus will be maintained by the field itself
  }

  /// Gets validator function for a specific field type
  String? Function(String?)? getFieldValidator(String fieldType) {
    return (String? value) => _getFieldValidationError(fieldType, value ?? '');
  }

  /// Resets the form to initial state
  void resetForm() {
    // Clear all controllers
    dtController.value.text = AppDatePicker.currentDate();
    partyController.value.clear();
    discountPerController.value.clear();
    discountAmtController.value.clear();
    cashReceivedController.value.clear();
    narrationController.value.clear();

    // Reset selected values
    selectedDropdownParty.value = null;
    selectedDropdownPartyName.value = '';
    selectedDropdownPartyCode.value = '';
    selectedPaymentMethod.value = 'Credit';

    // Clear all rows and add one empty row
    for (var row in rows) {
      row.dispose();
    }
    rows.clear();
    rows.add(ItemRowModel());

    // Reset totals
    subtotal.value = 0.0;
    totalDiscount.value = 0.0;
    totalGST.value = 0.0;
    netAmount.value = 0.0;
    roundOff.value = 0.0;
    discountPercent.value = 0.0;
    discountAmount.value = 0.0;

    // Focus on first field
    Future.delayed(const Duration(milliseconds: 100), () {
      dtFocus.requestFocus();
    });
  }

  void addRow() {
    final newRow = ItemRowModel();
    rows.add(newRow);
  }

  void removeRow1(int index) {
    if (index >= 0 && index < rows.length) {
      // Dispose the row before removing it
      rows[index].dispose();
      rows.removeAt(index);

      // If we removed the last row, add a new empty row
      if (rows.isEmpty) {
        addRow();
      }

      recalculateTotals(rows, searchTaxList);
    }
  }

  void removeRow(int index) {
    // Use the enhanced focus-aware removal method
    removeRowWithFocusAdjustment(index);
  }

  void updateDiscountFromAmount(String text) {
    // Validate input first
    if (text.trim().isNotEmpty) {
      final parsed = double.tryParse(text);
      if (parsed == null) {
        // Invalid format - show error and retain focus
        showFieldError('Invalid discount amount format', discountAmtFocus);
        return;
      }
      if (parsed < 0) {
        // Negative amount - show error and retain focus
        showFieldError('Discount amount cannot be negative', discountAmtFocus);
        return;
      }
      if (parsed > subtotal.value) {
        // Amount exceeds subtotal - show error and retain focus
        showFieldError(
          'Discount amount cannot exceed subtotal',
          discountAmtFocus,
        );
        return;
      }
    }

    if (text.trim().isEmpty) {
      discountAmount.value = 0.0;
      discountPercent.value = 0.0;
      discountPerController.value.clear();
      discountAmtController.value.clear();
      recalculateTotals(rows, searchTaxList);
      return;
    }

    final parsed = double.tryParse(text);
    if (parsed == null) {
      discountAmount.value = 0.0;
      return;
    }

    discountAmount.value = parsed;

    // Calculate and update discount percentage
    if (subtotal.value > 0) {
      final percent = (parsed / subtotal.value) * 100;
      discountPercent.value = percent;
      discountPerController.value.text = percent.toStringAsFixed(2);
    } else {
      discountPercent.value = 0.0;
      discountPerController.value.clear();
    }

    // Recalculate totals with new discount
    recalculateTotals(rows, searchTaxList);

    // Auto-focus to next field after successful calculation
    handleAutoFocus('discountAmount');
  }

  void updateDiscountFromPercent(String text) {
    // Validate input first
    if (text.trim().isNotEmpty) {
      final parsed = double.tryParse(text);
      if (parsed == null) {
        // Invalid format - show error and retain focus
        showFieldError('Invalid discount percentage format', discountPerFocus);
        return;
      }
      if (parsed < 0) {
        // Negative percentage - show error and retain focus
        showFieldError(
          'Discount percentage cannot be negative',
          discountPerFocus,
        );
        return;
      }
      if (parsed > 100) {
        // Percentage exceeds 100 - show error and retain focus
        showFieldError(
          'Discount percentage cannot be greater than 100',
          discountPerFocus,
        );
        return;
      }
    }

    if (text.trim().isEmpty) {
      discountPercent.value = 0.0;
      discountAmount.value = 0.0;
      discountPerController.value.clear();
      discountAmtController.value.clear();
      recalculateTotals(rows, searchTaxList);
      return;
    }

    final parsed = double.tryParse(text);
    if (parsed == null) {
      discountPercent.value = 0.0;
      discountAmount.value = 0.0;
      discountAmtController.value.text = '0.00';
      return;
    }

    discountPercent.value = parsed;

    // Calculate and update discount amount
    final discount = (parsed / 100) * subtotal.value;
    discountAmount.value = discount;
    discountAmtController.value.text = discount.toStringAsFixed(2);

    // Recalculate totals with new discount
    recalculateTotals(rows, searchTaxList);

    // Auto-focus to next field after successful calculation
    handleAutoFocus('discountPercent');
  }

  /// Handles cross-field calculation updates when discount values change
  void updateCrossFieldCalculations() {
    // Recalculate totals to ensure all dependent fields are updated
    recalculateTotals(rows, searchTaxList);

    // Update cash received if payment method is Cash and auto-populate is enabled
    if (selectedPaymentMethod.value == 'Cash') {
      final currentCashReceived =
          double.tryParse(cashReceivedController.value.text) ?? 0.0;

      // Only auto-update if the field is empty or matches the previous net amount
      if (cashReceivedController.value.text.isEmpty ||
          (currentCashReceived ==
              (netAmount.value -
                  discountAmount.value +
                  (discountAmount.value - discountAmount.value)))) {
        cashReceivedController.value.text = netAmount.value.toStringAsFixed(2);
      }
    }

    // Trigger UI updates for all dependent summary boxes
    subtotal.refresh();
    totalDiscount.refresh();
    totalGST.refresh();
    netAmount.refresh();
    roundOff.refresh();
  }

  /// Enhanced discount calculation with validation and focus management
  void calculateDiscountWithFocusHandling(String fieldType, String value) {
    switch (fieldType) {
      case 'discountPercent':
        updateDiscountFromPercent(value);
        break;
      case 'discountAmount':
        updateDiscountFromAmount(value);
        break;
    }

    // Update all cross-field calculations
    updateCrossFieldCalculations();
  }

  Future<void> fetchParty() async {
    if (await Network.isConnected()) {
      try {
        isDropdownPartyLoading(true);

        final response = await DioClient().get(AppURL.productsPartyURL);
        partyList.value = PartyResponse.fromJson(response);

        if (partyList.value.data!.isNotEmpty) {
          String? partyCdStr;

          if (salesID.value.isNotEmpty && insertACCCd.value.isEmpty) {
            partyCdStr = Get.arguments?['PartyCD'];
          } else if (insertACCCd.value.isNotEmpty) {
            partyCdStr = insertACCCd.value;
          }

          if (partyCdStr != null && partyCdStr.trim().isNotEmpty) {
            final selectedItem = partyList.value.data!.firstWhere(
              (state) => state.aCCCD == partyCdStr,
              orElse: () => PartyModel(),
            );

            selectedDropdownParty.value = selectedItem;
            selectedDropdownPartyName.value = selectedItem.aCCNAME ?? '';
            selectedDropdownPartyCode.value = selectedItem.aCCCD ?? '';
            partyController.value.text = selectedItem.aCCNAME ?? '';
            selectedDropdownStateCD.value =
                selectedItem.sTATECODE?.toString() ?? '';
            selectedDropdownStateName.value =
                selectedItem.sTATE?.toString() ?? '';
            selectedDropdownOutState.value =
                selectedItem.oUTSTATE?.toString() ?? '';
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'No party found.');
        }
      } catch (e) {
        Utils.handleException(e);
      } finally {
        isDropdownPartyLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchTax() async {
    if (await Network.isConnected()) {
      try {
        final response = await DioClient().get(AppURL.taxURL);
        taxList.value = TaxResponse.fromJson(response);

        if (taxList.value.data!.isNotEmpty) {
          if (taxList.value.message == 'Data fetch successfully') {
            searchTaxList.value = taxList.value.data!;
          } else {
            AppSnackBar.showGetXCustomSnackBar(
              message: response.data['message'],
            );
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'No data found.');
        }
      } catch (e) {
        Utils.handleException(e);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchProductBySearch(String val) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;
        errorMsg.value = '';

        final Map<String, dynamic> param = {
          "search": val,
          "deptCd": "",
          "items_per_page": "",
          "page": "1",
        };

        final response = await DioClient().getQueryParam(
          AppURL.productsURL,
          queryParams: param,
        );

        final newData = ProductResponse.fromJson(response);

        if (newData.data != null && newData.data!.isNotEmpty) {
          mainList.value = ProductResponse(
            message: newData.message,
            data: newData.data,
          );

          searchList.clear();
          searchList.addAll(newData.data!);
          filterData(serachVal: val);
        } else {
          mainList.value = ProductResponse(data: []);
          searchList.clear();
        }
      } catch (e) {
        mainList.value = ProductResponse(data: []);
        errorMsg.value = 'Something went wrong while searching.';
        Utils.handleException(e);
      } finally {
        isLoading.value = false;
        mainList.refresh();
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  void filterData({List<String>? multipleQueries, required String serachVal}) {
    if ((multipleQueries == null || multipleQueries.isEmpty) &&
        serachVal.isEmpty) {
      mainList.value.data = List.from(searchList);
    } else {
      final queries = multipleQueries ?? [serachVal];

      mainList.value.data =
          searchList.where((group) {
            return queries.any(
              (query) =>
                  (group.iTEMNAME?.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ??
                      false) ||
                  (group.iTEMSNAME?.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ??
                      false) ||
                  (group.iTEMLNAME?.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ??
                      false) ||
                  (group.iTEMCD2?.toString().contains(query) ?? false) ||
                  (group.iTEMCD?.toString().contains(query) ?? false),
            );
          }).toList();
    }

    mainList.refresh();
  }

  void processItemDetails(List<Itemdtls> itemdtls) {
    extractedData =
        itemdtls.map((item) {
          return {
            "sizeCd": item.sIZECD,
            "sizeIdx": item.sIZEIDX,
            "itemBarcdNo": item.iTEMBARCDNO,
            "blackList": item.bLACKLIST,
            "purRate": item.pURRATE,
            "prateTax": item.pRATETAX,
            "opRate": item.oPRATE,
            "clRate": item.cLRATE,
            "saleRate1": item.sALERATE1,
            "saleRate2": item.sALERATE2,
            "saleRate3": item.sALERATE3,
            "saleRate4": item.sALERATE4,
            "saleRate5": item.sALERATE5,
            "saleRate6": item.sALERATE6,
            "saleRate7": item.sALERATE7,
            "saleRate8": item.sALERATE8,
            "mrp": item.mRP,
            "comRate": item.cOMRATE,
            "purDisc": item.pURDISC,
            "saleDisc": item.sALEDISC,
            "saleDisc1": item.sALEDISC1,
            "saleDisc2": item.sALEDISC2,
            "saleDisc3": item.sALEDISC3,
            "sioDisc": item.sIODISC,
            "opStk": item.oPSTK,
            "drStk": item.dRSTK,
            "crStk": item.cRSTK,
            "clStk": item.cLSTK,
            "orStk": item.oRSTK,
            "opDesc": item.oPDESC,
            "clDesc": item.cLDESC,
            "drBase": item.dRBASE,
            "drFr": item.dRFR,
            "crBase": item.cRBASE,
            "crFr": item.cRFR,
            "minStk": item.mINSTK,
            "roStk": item.rOSTK,
            "actualStk": item.aCTUALSTK,
            "mfgDt": item.mFGDT,
            "desc1": item.dESC1,
            "batchNo": item.bATCHNO,
            "expDt": item.eXPDT,
            "packing": item.pACKING,
            "desc2": item.dESC2,
            "desc3": item.dESC3,
          };
        }).toList();
  }

  void updateBatchList(ItemRowModel row, List<Itemdtls> itemdtls) {
    final seen = <String>{};
    final filtered =
        itemdtls.where((e) {
          final size = e.sIZECD?.trim();
          if (size == null || size.isEmpty || seen.contains(size)) {
            return false;
          }
          seen.add(size);
          return true;
        }).toList();

    row.batchList.value = filtered;

    if (kDebugMode) {
      print("Updated Row Batch List: ${row.batchList.length}");
    }
  }

  Widget _buildTableHeader() {
    return const Row(
      spacing: 10,
      children: [
        Text("Sr"),
        CommonTableCellContainer(flex: 4, child: Text("Item")),
        CommonTableCellContainer(flex: 2, child: Text("Batch")),
        CommonTableCellContainer(flex: 1, child: Text("Qty")),
        CommonTableCellContainer(flex: 1, child: Text("Free")),
        CommonTableCellContainer(flex: 1, child: Text("Rate")),
        CommonTableCellContainer(flex: 1, child: Text("Disc.%")),
        CommonTableCellContainer(flex: 1, child: Text("GST%")),
        CommonTableCellContainer(
          flex: 1,
          child: Text("Total", textAlign: TextAlign.center),
        ),
        CommonTableCellContainer(
          flex: 1,
          child: Text("Actions", textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Widget buildSalesGrid(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(thickness: 1),
          Obx(
            () => Expanded(
              //height: 500, // or use Expanded if inside a Column
              child: ListView.builder(
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  final row = rows[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((index + 1).toString()),

                        /// --- ITEM FIELD ---
                        CommonTableCellContainer(
                          flex: 4,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Enhanced keyboard navigation for product field
                                switch (event.logicalKey) {
                                  case LogicalKeyboardKey.arrowUp:
                                    // Move to previous row's product field
                                    moveToPreviousRow();
                                    break;
                                  case LogicalKeyboardKey.arrowDown:
                                    // Move to next row's product field
                                    moveToNextRow();
                                    break;
                                  case LogicalKeyboardKey.tab:
                                    // Tab navigation between fields
                                    if (event.isShiftPressed) {
                                      moveToPreviousGridField(index, 'product');
                                    } else {
                                      moveToNextGridField(index, 'product');
                                    }
                                    break;
                                  case LogicalKeyboardKey.escape:
                                    // Clear field and move to previous
                                    row.productController.clear();
                                    row.selectedProduct.value = null;
                                    row.batchList.clear();
                                    moveToPreviousGridField(index, 'product');
                                    break;
                                  case LogicalKeyboardKey.enter:
                                    // Handle Enter key - same as onSubmit
                                    if (row.productController.text
                                        .trim()
                                        .isNotEmpty) {
                                      moveToNextGridField(index, 'product');
                                    }
                                    break;
                                  default:
                                    break;
                                }
                              }
                            },
                            child: SearchField<ProductModel>(
                              suggestions: const [],
                              itemHeight: 100,
                              maxSuggestionsInViewPort: 5,
                              suggestionsDecoration: SuggestionDecoration(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 4,
                                // color: Colors.white,
                              ),
                              controller: row.productController,
                              focusNode: row.productFocused,
                              searchInputDecoration: SearchInputDecoration(
                                hintText: 'Item (Min 3 Char For Search)',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onSearchTextChanged: (pattern) async {
                                final trimmed = pattern.trim();
                                if (trimmed.length < 3) {
                                  return <SearchFieldListItem<ProductModel>>[];
                                }
                                await fetchProductBySearch(trimmed);
                                final list = mainList.value.data ?? [];
                                return list.map((suggestion) {
                                  final stockValue =
                                      double.tryParse('${suggestion.cSTK}') ??
                                      0;
                                  final stockColor =
                                      stockValue > 0
                                          ? Colors.green
                                          : Colors.red;

                                  return SearchFieldListItem<ProductModel>(
                                    suggestion.iTEMNAME ?? '',
                                    item: suggestion,
                                    child: Container(
                                      width: double.infinity,
                                      height: 95,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Item Name
                                          Flexible(
                                            child: CommonText(
                                              text: suggestion.iTEMNAME ?? "",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              maxLine: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                          // Stock and Company Row
                                          Row(
                                            children: [
                                              // Stock Badge
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: stockColor.withOpacity(
                                                    0.15,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                child: Text(
                                                  'Stock: ${stockValue.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                    color: stockColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      "Co: ${suggestion.deptment?.dEPTNAME ?? 'N/A'}",
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Pack, Rate, MRP Row
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      "Pack: ${suggestion.uNIT ?? 'N/A'}",
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      "Rate: ₹${suggestion.sRATE1 ?? '0'}",
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      "MRP: ₹${suggestion.mRP ?? '0'}",
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onSuggestionTap: (
                                SearchFieldListItem<ProductModel> selected,
                              ) async {
                                final selectedItem = selected.item!;
                                row.selectedProduct.value = selectedItem;
                                row.productController.text =
                                    selectedItem.iTEMNAME ?? '';
                                row.productCDController.text =
                                    selectedItem.iTEMCD ?? '';
                                row.gstControllerHeader.text =
                                    selectedItem.gSTPERC?.toString() ?? '';
                                row.packagingControllerHeader.text =
                                    selectedItem.uNIT?.toString() ?? '';
                                row.rackControllerHeader.text =
                                    selectedItem.rACKNO?.toString() ?? '';
                                row.hsnCodeControllerHeader.text =
                                    selectedItem.hSNNO?.toString() ?? '';

                                updateBatchList(
                                  row,
                                  selectedItem.itemdtls ?? [],
                                );

                                // Auto-populate batch if only one batch available
                                if (row.batchList.length == 1) {
                                  final singleBatch = row.batchList.first;
                                  row.selectedBatch.value = singleBatch;
                                  row.batchController.text =
                                      singleBatch.sIZECD ?? '';
                                  row.expiryDtController.text =
                                      singleBatch.eXPDT?.isNotEmpty == true
                                          ? AppDatePicker.convertDateTimeFormat(
                                            singleBatch.eXPDT!,
                                            "yyyy-MM-dd",
                                            "dd/MM/yyyy",
                                          )
                                          : '';

                                  row.rateController.text =
                                      singleBatch.sALERATE1?.toString() ?? '';
                                  row.discountController.text =
                                      singleBatch.sALEDISC?.toString() ?? '';
                                  row.mrpController.text =
                                      singleBatch.mRP?.toString() ?? '';
                                  row.unitController.text =
                                      singleBatch.pACKING?.toString() ?? '';
                                  row.barcodeController.text =
                                      singleBatch.iTEMBARCDNO?.toString() ?? '';

                                  // Single batch available - skip batch field and move to quantity
                                  SalesFocusManager.moveToNextField(
                                    row.productFocused,
                                    row.qtyFocused,
                                  );
                                } else {
                                  // Multiple batches - move to batch field for selection
                                  SalesFocusManager.moveToNextField(
                                    row.productFocused,
                                    row.batchFocused,
                                  );
                                }

                                // Auto-add new row if this is the last row and has content
                                if (index == rows.length - 1 &&
                                    row.productController.text.isNotEmpty) {
                                  addRow();
                                }
                              },
                              onSubmit: (String value) {
                                // Handle Enter key press - move to next field in sequence
                                if (value.trim().isNotEmpty) {
                                  // If there's text but no selection, try to search and select first match
                                  if (row.selectedProduct.value == null &&
                                      mainList.value.data?.isNotEmpty == true) {
                                    // Auto-select first matching product
                                    final firstMatch =
                                        mainList.value.data!.first;
                                    row.selectedProduct.value = firstMatch;
                                    row.productController.text =
                                        firstMatch.iTEMNAME ?? '';
                                    row.productCDController.text =
                                        firstMatch.iTEMCD ?? '';

                                    // Update batch list and move to appropriate next field
                                    updateBatchList(
                                      row,
                                      firstMatch.itemdtls ?? [],
                                    );

                                    if (row.batchList.length == 1) {
                                      // Auto-populate single batch and move to quantity
                                      final singleBatch = row.batchList.first;
                                      row.selectedBatch.value = singleBatch;
                                      row.batchController.text =
                                          singleBatch.sIZECD ?? '';
                                      SalesFocusManager.moveToNextField(
                                        row.productFocused,
                                        row.qtyFocused,
                                      );
                                    } else {
                                      // Move to batch field for selection
                                      SalesFocusManager.moveToNextField(
                                        row.productFocused,
                                        row.batchFocused,
                                      );
                                    }
                                  } else {
                                    // Move to next field in grid sequence
                                    moveToNextGridField(index, 'product');
                                  }
                                } else {
                                  // Empty field - just move to next field
                                  moveToNextGridField(index, 'product');
                                }
                              },
                            ),
                          ),
                        ),

                        /// --- BATCH FIELD ---
                        CommonTableCellContainer(
                          flex: 2,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Enhanced keyboard navigation for batch field
                                switch (event.logicalKey) {
                                  case LogicalKeyboardKey.arrowUp:
                                    // Move to previous row's batch field
                                    moveToPreviousRow();
                                    break;
                                  case LogicalKeyboardKey.arrowDown:
                                    // Move to next row's batch field
                                    moveToNextRow();
                                    break;
                                  case LogicalKeyboardKey.tab:
                                    // Tab navigation between fields
                                    if (event.isShiftPressed) {
                                      moveToPreviousGridField(index, 'batch');
                                    } else {
                                      moveToNextGridField(index, 'batch');
                                    }
                                    break;
                                  case LogicalKeyboardKey.escape:
                                    // Clear batch selection and move to previous field
                                    row.batchController.clear();
                                    row.selectedBatch.value = null;
                                    moveToPreviousGridField(index, 'batch');
                                    break;
                                  case LogicalKeyboardKey.enter:
                                    // Move to next field (quantity)
                                    moveToNextGridField(index, 'batch');
                                    break;
                                  default:
                                    break;
                                }
                              }
                            },
                            child: SearchField<Itemdtls>(
                              suggestions: const [],
                              itemHeight: 120,
                              maxSuggestionsInViewPort: 4,
                              suggestionsDecoration: SuggestionDecoration(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 4,
                              ),
                              controller: row.batchController,
                              focusNode: row.batchFocused,
                              searchInputDecoration: SearchInputDecoration(
                                hintText: 'Enter batch',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onSearchTextChanged: (pattern) async {
                                final search = pattern.toLowerCase().replaceAll(
                                  ' ',
                                  '',
                                );
                                final filteredList =
                                    row.batchList.where((item) {
                                      return (item.sIZECD ?? '')
                                          .toLowerCase()
                                          .contains(search);
                                    }).toList();

                                return filteredList.map((suggestion) {
                                  final stockValue =
                                      double.tryParse('${suggestion.cLSTK}') ??
                                      0;
                                  final stockColor =
                                      stockValue > 0
                                          ? Colors.green
                                          : Colors.red;

                                  String formatDate(String? rawDate) {
                                    if (rawDate == null || rawDate.isEmpty) {
                                      return 'N/A';
                                    }
                                    try {
                                      return AppDatePicker.convertDateTimeFormat(
                                        rawDate,
                                        'yyyy-MM-dd',
                                        'dd-MM-yyyy',
                                      );
                                    } catch (_) {
                                      return 'N/A';
                                    }
                                  }

                                  final expDateStr = suggestion.eXPDT ?? '';
                                  DateTime? expDate;
                                  if (expDateStr.isNotEmpty) {
                                    try {
                                      expDate = DateTime.parse(expDateStr);
                                    } catch (_) {}
                                  }
                                  final isExpiringSoon =
                                      expDate != null &&
                                      expDate.isBefore(
                                        DateTime.now().add(
                                          const Duration(days: 180),
                                        ),
                                      );

                                  return SearchFieldListItem<Itemdtls>(
                                    suggestion.sIZECD ?? '',
                                    item: suggestion,
                                    child: Container(
                                      width: double.infinity,
                                      height: 115,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Batch Name and Stock
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: CommonText(
                                                  text:
                                                      'Batch: ${suggestion.sIZECD ?? 'N/A'}',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: stockColor
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          3,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    'Stock: ${stockValue.toStringAsFixed(0)}',
                                                    style: TextStyle(
                                                      color: stockColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Rate and MRP
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      'Rate: ₹${suggestion.sALERATE1 ?? '0'}',
                                                  fontSize: 11,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      'MRP: ₹${suggestion.mRP ?? '0'}',
                                                  fontSize: 11,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      'Pack: ${suggestion.dESC2 ?? 'N/A'}',
                                                  fontSize: 11,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Dates and MFG
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      'MFG: ${formatDate(suggestion.mFGDT)}',
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Exp: ${formatDate(expDateStr)}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        isExpiringSoon
                                                            ? Colors.red
                                                            : Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      'By: ${suggestion.dESC3 ?? 'N/A'}',
                                                  fontSize: 10,
                                                  maxLine: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onSuggestionTap: (
                                SearchFieldListItem<Itemdtls> selected,
                              ) {
                                final selectedItem = selected.item!;
                                row.selectedBatch.value = selectedItem;
                                row.batchController.text =
                                    selectedItem.sIZECD ?? '';

                                row.expiryDtController.text =
                                    selectedItem.eXPDT?.isNotEmpty == true
                                        ? AppDatePicker.convertDateTimeFormat(
                                          selectedItem.eXPDT!,
                                          "yyyy-MM-dd",
                                          "dd/MM/yyyy",
                                        )
                                        : '';

                                row.rateController.text =
                                    selectedItem.sALERATE1?.toString() ?? '';
                                row.discountController.text =
                                    selectedItem.sALEDISC?.toString() ?? '';
                                row.mrpController.text =
                                    selectedItem.mRP?.toString() ?? '';
                                row.unitController.text =
                                    selectedItem.pACKING?.toString() ?? '';
                                row.barcodeController.text =
                                    selectedItem.iTEMBARCDNO?.toString() ?? '';

                                // Use enhanced focus management to move to quantity field
                                SalesFocusManager.moveToNextField(
                                  row.batchFocused,
                                  row.qtyFocused,
                                );
                              },
                              onSubmit: (p0) {
                                // Handle batch field submission - move to next field
                                moveToNextGridField(index, 'batch');
                              },
                            ),
                          ),
                        ),

                        /// --- QTY ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Handle keyboard navigation
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  moveToPreviousRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  moveToNextRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.tab) {
                                  if (event.isShiftPressed) {
                                    moveToPreviousGridField(index, 'quantity');
                                  } else {
                                    moveToNextGridField(index, 'quantity');
                                  }
                                }
                              }
                            },
                            child: TextField(
                              controller: row.qtyController,
                              focusNode: row.qtyFocused,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                // Use enhanced focus management
                                moveToNextGridField(index, 'quantity');
                              },
                              onChanged: (val) {
                                recalculateTotals(rows, searchTaxList);
                                // Handle auto-row creation if this is the last row and completed
                                handleAutoRowCreation(index, 'quantity');
                              },
                              decoration: const InputDecoration(
                                hintText: "Qty *",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// --- FREE QTY ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Handle keyboard navigation
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  moveToPreviousRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  moveToNextRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.tab) {
                                  if (event.isShiftPressed) {
                                    moveToPreviousGridField(index, 'freeQty');
                                  } else {
                                    moveToNextGridField(index, 'freeQty');
                                  }
                                }
                              }
                            },
                            child: TextField(
                              controller: row.freeQtyController,
                              focusNode: row.freeQtyFocused,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                // Use enhanced focus management
                                moveToNextGridField(index, 'freeQty');
                              },
                              onChanged: (val) {
                                // Handle auto-row creation if this is the last row and completed
                                handleAutoRowCreation(index, 'freeQty');
                              },
                              decoration: const InputDecoration(
                                hintText: "Free Qty",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// --- RATE ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Handle keyboard navigation
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  moveToPreviousRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  moveToNextRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.tab) {
                                  if (event.isShiftPressed) {
                                    moveToPreviousGridField(index, 'rate');
                                  } else {
                                    moveToNextGridField(index, 'rate');
                                  }
                                }
                              }
                            },
                            child: TextField(
                              controller: row.rateController,
                              focusNode: row.rateFocused,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(Utils.filterPatternWithDecimal0x2),
                                ),
                              ],
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                // Use enhanced focus management
                                moveToNextGridField(index, 'rate');
                              },
                              onChanged: (val) {
                                recalculateTotals(rows, searchTaxList);
                                // Handle auto-row creation if this is the last row and completed
                                handleAutoRowCreation(index, 'rate');
                              },
                              decoration: const InputDecoration(
                                hintText: "Rate",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// --- DISCOUNT ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Handle keyboard navigation
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  moveToPreviousRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  moveToNextRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.tab) {
                                  if (event.isShiftPressed) {
                                    moveToPreviousGridField(index, 'discount');
                                  } else {
                                    moveToNextGridField(index, 'discount');
                                  }
                                }
                              }
                            },
                            child: TextField(
                              controller: row.discountController,
                              focusNode: row.discountFocused,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(Utils.filterPatternWithDecimal0x2),
                                ),
                              ],
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                // Use enhanced focus management
                                moveToNextGridField(index, 'discount');
                              },
                              onChanged: (val) {
                                recalculateTotals(rows, searchTaxList);
                                // Handle auto-row creation if this is the last row and completed
                                handleAutoRowCreation(index, 'discount');
                              },
                              decoration: const InputDecoration(
                                hintText: "Dis %",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// --- GST (DISABLED) ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent) {
                                // Handle keyboard navigation even for disabled field
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowUp) {
                                  moveToPreviousRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.arrowDown) {
                                  moveToNextRow();
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.tab) {
                                  if (event.isShiftPressed) {
                                    moveToPreviousGridField(index, 'gst');
                                  } else {
                                    moveToNextGridField(index, 'gst');
                                  }
                                } else if (event.logicalKey ==
                                    LogicalKeyboardKey.enter) {
                                  // Handle auto-row creation when Enter is pressed on GST field
                                  handleAutoRowCreation(index, 'gst');
                                  moveToNextGridField(index, 'gst');
                                }
                              }
                            },
                            child: TextField(
                              controller: row.gstControllerHeader,
                              focusNode: row.gstFocused,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: "GST %",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// --- TOTAL ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: Obx(
                            () => Text(
                              row.total.value.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        /// --- DELETE ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: Listener(
                            onPointerHover: (_) {},
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => removeRowWithFocusAdjustment(index),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> buildSalesCartJson({
    required RxList<ItemRowModel> salesRowList,
    required List<TaxModel> taxRates,
  }) {
    final List<Map<String, dynamic>> items = [];

    for (var row in salesRowList) {
      final qtyText = row.qtyController.text.trim();
      final batchText = row.batchController.text.trim();

      if (qtyText.isEmpty ||
          double.tryParse(qtyText) == null ||
          batchText.isEmpty) {
        continue;
      }

      final product = row.selectedProduct.value;
      if (product == null) continue;

      final itemData = buildItemFromRow(row, product, taxRates);

      if (itemData.isNotEmpty) {
        items.add(itemData);
      }
    }

    return items;
  }

  Map<String, dynamic> buildItemFromRow(
    ItemRowModel row,
    ProductModel item,
    List<TaxModel> taxRates,
  ) {
    try {
      final quantity = double.tryParse(row.qtyController.text.trim()) ?? 0.0;
      final rate = double.tryParse(row.rateController.text.trim()) ?? 0.0;
      final discountPerc =
          double.tryParse(row.discountController.text.trim()) ?? 0.0;

      final amount = quantity * rate;
      final discountAmt = (discountPerc / 100) * amount;
      final taxableAmount = amount - discountAmt;

      double gstStateCd = 0.0;

      if (selectedDropdownOutState.value.toUpperCase() == 'N') {
        gstStateCd = double.tryParse(item.gSTSTAXCD?.toString() ?? '0') ?? 0;
      } else {
        gstStateCd =
            (double.tryParse(item.gSTSTAXCD?.toString() ?? '0') ?? 0) + 10;
      }

      final taxRateData = taxRates.firstWhere(
        (t) => t.cODE == gstStateCd,
        orElse: () => TaxModel(),
      );

      final gstRate = taxRateData.rATE?.toDouble() ?? 0.0;
      double sgstRate = 0.0;
      double cgstRate = 0.0;
      double sgstAmt = 0.0;
      double cgstAmt = 0.0;
      double igstRate = 0.0;
      double igstAmt = 0.0;

      if (selectedDropdownOutState.value.toUpperCase() == 'N') {
        sgstRate = taxRateData.sGSTRATE?.toDouble() ?? 0.0;
        cgstRate = taxRateData.cGSTRATE?.toDouble() ?? 0.0;
        sgstAmt = (sgstRate / 100) * taxableAmount;
        cgstAmt = (cgstRate / 100) * taxableAmount;
      } else {
        igstRate = taxRateData.iGSTRATE?.toDouble() ?? 0.0;
        igstAmt = (igstRate / 100) * taxableAmount;
      }

      return {
        "itemCd": item.iTEMCD!,
        "sizeCd": row.batchController.text,
        "quantity": quantity.toString(),
        "otherDesc": row.freeQtyController.text,
        "rate": rate.toStringAsFixed(2),
        "discPerc": discountPerc.toStringAsFixed(2),
        "discPerc1": 0,
        "discPerc2": 0,
        "discPerc3": 0,
        "discPerc4": 0,
        "discPerc5": 0,
        "idiscAmt": 0,
        "chrgPer": 0,
        "chrgAmt": 0,
        "gcPer": 0,
        "gcAmt": 0,
        "smanCd": "",
        "smanName": "",
        "amount": taxableAmount.toStringAsFixed(2),
        "taxCd": gstStateCd,
        "taxPerI": gstRate,
        "sgPerI": sgstRate,
        "sgAmt": sgstAmt.toStringAsFixed(2),
        "cgPerI": cgstRate,
        "cgAmt": cgstAmt.toStringAsFixed(2),
        "igPerI": igstRate,
        "igAmt": igstAmt.toStringAsFixed(2),
        "dosage": "",
        "mdcnDays": 0,
        "itemName": item.iTEMNAME,
        "ExDt": row.expiryDtController.text,
        "MRP": row.mrpController.text,
        "Packaging": row.packagingControllerHeader.text,
        "Units": row.unitController.text,
        "HSNCd": row.hsnCodeControllerHeader.text,
        "Barcode": row.barcodeController.text,
        "SaleRate1": row.rateController.text,
        "Rack": row.rackControllerHeader.text,
      };
    } catch (e) {
      return {};
    }
  }

  bool validation() {
    // Use the enhanced validation with focus retention
    if (!validateFormWithFocus()) {
      return false;
    }

    // Build cart items if validation passes
    final itemsJson = buildSalesCartJson(
      salesRowList: rows,
      taxRates: searchTaxList,
    );

    if (itemsJson.isEmpty) {
      showFieldError(
        'Please fill quantity and batch in at least one row',
        rows.first.productFocused,
      );
      return false;
    }

    cartItems.clear();
    cartItems.addAll(itemsJson);

    return true;
  }

  Future<void> insertUpdateSales(String type) async {
    try {
      isBottomLoading(true);
      isBottomDisable(true);

      if (await Network.isConnected()) {
        final Map<String, dynamic> param = {
          if (type == "U") "salesId": salesID.value,
          "vouchDt": AppDatePicker.convertDateTimeFormat(
            dtController.value.text,
            "dd/MM/yyyy",
            "yyyy-MM-dd",
          ),
          "vouchType": "Sales",
          "bookCd": "SA",
          "chlnNo": "",
          "einvAck": null,
          "einvIrn": "",
          "ewayNo": "",
          "orderNo": "",
          "partyCd":
              selectedDropdownPartyCode.value.isNotEmpty
                  ? selectedDropdownPartyCode.value
                  : 'C00001',
          "shipParty": "",
          "payMode": selectedPaymentMethod.value,
          "cashAmt":
              selectedPaymentMethod.value == 'Cash' ? netAmount.value : 0.00,
          "cashRecv":
              selectedPaymentMethod.value == 'Cash'
                  ? (cashReceivedController.value.text.isNotEmpty
                      ? cashReceivedController.value.text
                      : 0.00)
                  : 0.00,
          "bankAmt":
              selectedPaymentMethod.value == 'Bank' ? netAmount.value : 0.00,
          "cardAmt":
              selectedPaymentMethod.value == 'Card' ? netAmount.value : 0.00,
          "upiAmt":
              selectedPaymentMethod.value == 'UPI' ? netAmount.value : 0.00,
          "creditAmt":
              selectedPaymentMethod.value == 'Credit' ? netAmount.value : 0.00,
          "discPer1":
              discountPerController.value.text.isNotEmpty
                  ? discountPerController.value.text
                  : 0.00,
          "discAmt1":
              discountAmtController.value.text.isNotEmpty
                  ? discountAmtController.value.text
                  : 0.00,
          "discPerc2": 0.00,
          "discAmt2": 0.00,
          "discPerc3": 0.00,
          "discAmt3": 0.00,
          "discPerc4": 0.00,
          "discAmt4": 0.00,
          "discPerc5": 0.00,
          "discAmt5": 0.00,
          "chrgPer1": 0.00,
          "chrgAmt1": 0.00,
          "chrgPer2": 0.00,
          "chrgAmt2": 0.00,
          "chrgPer3": 0.00,
          "chrgAmt3": 0.00,
          "chrgPer4": 0.00,
          "chrgAmt4": 0.00,
          "chrgPer5": 0.00,
          "chrgAmt5": 0.00,
          "narration": "",
          "smanCd": "",
          "dmanCd": "",
          "crDays": 0,
          "paidTbp": 0.00,
          "tcsTds": "",
          "tcsPerc": 0.00,
          "tcsAmt": 0.00,
          "parcle": "",
          "lrNo": "",
          "lrDate": AppDatePicker.currentYYYYMMDDDate(),
          "transport": "",
          "frieght": 0.00,
          "servTax": 0.00,
          "payTopay": "",
          "desti": "",
          "loadAdd": "",
          "loadCity": "",
          "loadPin": "",
          "uloadAdd": "",
          "uloadCity": "",
          "uloadPin": "",
          "advanceAmt": 0.00,
          "truckNo": "",
          "driverNm": "",
          "driverLic": "",
          "driverMob": "",
          "ownerNm": "",
          "holdNo": "",
          "courierDocNo": "",
          "transAcc": "",
          "km": 0.00,
          "chequeNo": 0.00,
          "upiTransactionNo": "",
          "cardTransactionNo": "",
          "cardNo": "",
          //"moduleNo": moduleNo.value,
          "moduleNo": '201',
          "items":
              cartItems.map((item) {
                final newItem = Map<String, dynamic>.from(item);
                newItem.remove('itemName');
                newItem.remove('ExDt');
                newItem.remove('MRP');
                newItem.remove('Packaging');
                newItem.remove('Units');
                newItem.remove('HSNCd');
                newItem.remove('Barcode');
                newItem.remove('SaleRate1');
                newItem.remove('Rack');
                return newItem;
              }).toList(),
        };

        final dynamic response =
            type == "U"
                ? await DioClient().put(AppURL.salesURL, param)
                : await DioClient().post(AppURL.salesURL, param);

        if (response.statusCode == 200 || response.statusCode == 201) {
          cartItems.clear();

          clearData(); // Not Back

          // Get.back(); // From Summary to Item

          // if (type == "U") Get.back(); // From Item to Sales List

          AppSnackBar.showGetXCustomSnackBar(
            message:
                type == "U"
                    ? "Sale entry update successfully"
                    : "Sale entry saved successfully",
            backgroundColor: Colors.green,
          );

          final controller = Get.find<SalesController>();
          controller.fetchSales();
        } else {
          AppSnackBar.showGetXCustomSnackBar(
            message: 'Error: ${response.statusCode}',
          );
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      Utils.handleException(e);
    } finally {
      isBottomLoading(false);
      isBottomDisable(false);
    }
  }

  void clearData() {
    partyController.value.clear();
    partyFocus.unfocus();

    selectedDropdownParty.value = null;
    selectedDropdownPartyName.value = '';
    selectedDropdownPartyCode.value = '';
    selectedDropdownStateCD.value = '';
    selectedDropdownStateName.value = '';
    selectedDropdownOutState.value = '';

    rows.clear();

    addRow();

    subtotal.value = 0.0;
    totalDiscount.value = 0.0;
    totalGST.value = 0.0;
    netAmount.value = 0.0;
    roundOff.value = 0.0;

    selectedPaymentMethod.value = 'Credit';
    discountPercent.value = 0.0;
    discountAmount.value = 0.0;
    discountAmtController.value.clear();
    discountPerController.value.clear();
    cashReceivedController.value.clear();
    narrationController.value.clear();
  }

  /// Adds a new row to the sales grid
  void addRow() {
    final newRow = ItemRowModel();
    rows.add(newRow);
  }

  /// Moves focus to the next field in the grid
  void moveToNextGridField(int rowIndex, String currentField) {
    if (rowIndex >= rows.length) return;

    final row = rows[rowIndex];

    switch (currentField) {
      case 'product':
        // Move to batch field in the same row
        SalesFocusManager.moveToNextField(row.productFocused, row.batchFocused);
        break;
      case 'batch':
        // Move to quantity field in the same row
        SalesFocusManager.moveToNextField(row.batchFocused, row.qtyFocused);
        break;
      case 'quantity':
        // Move to rate field in the same row
        SalesFocusManager.moveToNextField(row.qtyFocused, row.rateFocused);
        break;
      case 'rate':
        // Move to discount field in the same row
        SalesFocusManager.moveToNextField(row.rateFocused, row.discountFocused);
        break;
      case 'discount':
        // Move to product field in the next row or add new row
        if (rowIndex < rows.length - 1) {
          // Move to next row's product field
          SalesFocusManager.moveToNextField(
            row.discountFocused,
            rows[rowIndex + 1].productFocused,
          );
        } else {
          // Add new row and focus on its product field
          addRow();
          SalesFocusManager.moveToNextField(
            row.discountFocused,
            rows.last.productFocused,
          );
        }
        break;
      default:
        break;
    }
  }

  /// Moves focus to the previous field in the grid
  void moveToPreviousGridField(int rowIndex, String currentField) {
    if (rowIndex >= rows.length) return;

    final row = rows[rowIndex];

    switch (currentField) {
      case 'product':
        // Move to discount field in the previous row or party field
        if (rowIndex > 0) {
          SalesFocusManager.moveToPreviousField(
            row.productFocused,
            rows[rowIndex - 1].discountFocused,
          );
        } else {
          // Move to party field
          SalesFocusManager.moveToPreviousField(row.productFocused, partyFocus);
        }
        break;
      case 'batch':
        // Move to product field in the same row
        SalesFocusManager.moveToPreviousField(
          row.batchFocused,
          row.productFocused,
        );
        break;
      case 'quantity':
        // Move to batch field in the same row
        SalesFocusManager.moveToPreviousField(row.qtyFocused, row.batchFocused);
        break;
      case 'rate':
        // Move to quantity field in the same row
        SalesFocusManager.moveToPreviousField(row.rateFocused, row.qtyFocused);
        break;
      case 'discount':
        // Move to rate field in the same row
        SalesFocusManager.moveToPreviousField(
          row.discountFocused,
          row.rateFocused,
        );
        break;
      default:
        break;
    }
  }

  /// Moves focus to the next row's same field
  void moveToNextRow() {
    // Find currently focused row and field
    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.productFocused.hasFocus && i < rows.length - 1) {
        SalesFocusManager.moveToNextField(
          row.productFocused,
          rows[i + 1].productFocused,
        );
        return;
      } else if (row.batchFocused.hasFocus && i < rows.length - 1) {
        SalesFocusManager.moveToNextField(
          row.batchFocused,
          rows[i + 1].batchFocused,
        );
        return;
      } else if (row.qtyFocused.hasFocus && i < rows.length - 1) {
        SalesFocusManager.moveToNextField(
          row.qtyFocused,
          rows[i + 1].qtyFocused,
        );
        return;
      } else if (row.rateFocused.hasFocus && i < rows.length - 1) {
        SalesFocusManager.moveToNextField(
          row.rateFocused,
          rows[i + 1].rateFocused,
        );
        return;
      } else if (row.discountFocused.hasFocus && i < rows.length - 1) {
        SalesFocusManager.moveToNextField(
          row.discountFocused,
          rows[i + 1].discountFocused,
        );
        return;
      }
    }
  }

  /// Moves focus to the previous row's same field
  void moveToPreviousRow() {
    // Find currently focused row and field
    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.productFocused.hasFocus && i > 0) {
        SalesFocusManager.moveToPreviousField(
          row.productFocused,
          rows[i - 1].productFocused,
        );
        return;
      } else if (row.batchFocused.hasFocus && i > 0) {
        SalesFocusManager.moveToPreviousField(
          row.batchFocused,
          rows[i - 1].batchFocused,
        );
        return;
      } else if (row.qtyFocused.hasFocus && i > 0) {
        SalesFocusManager.moveToPreviousField(
          row.qtyFocused,
          rows[i - 1].qtyFocused,
        );
        return;
      } else if (row.rateFocused.hasFocus && i > 0) {
        SalesFocusManager.moveToPreviousField(
          row.rateFocused,
          rows[i - 1].rateFocused,
        );
        return;
      } else if (row.discountFocused.hasFocus && i > 0) {
        SalesFocusManager.moveToPreviousField(
          row.discountFocused,
          rows[i - 1].discountFocused,
        );
        return;
      }
    }
  }
}
