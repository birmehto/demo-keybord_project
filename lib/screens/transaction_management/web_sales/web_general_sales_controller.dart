import 'package:demo/api/dio_client.dart';
import 'package:demo/app/app_date_format.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/app/app_url.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/models/product_model.dart';
import 'package:demo/models/tax_response.dart';
import 'package:demo/screens/transaction_management/sales/sales_controller.dart';
import 'package:demo/utility/constants.dart';
import 'package:demo/utility/network.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_table_cell_container.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

class ItemRowModel {
  // Controllers
  final packagingControllerHeader = TextEditingController();
  final rackControllerHeader = TextEditingController();
  final hsnCodeControllerHeader = TextEditingController();
  final gstControllerHeader = TextEditingController();
  final productCDController = TextEditingController();
  final productController = TextEditingController();
  final batchController = TextEditingController();
  final expiryDtController = TextEditingController();
  final qtyController = TextEditingController();
  final freeQtyController = TextEditingController();
  final rateController = TextEditingController();
  final discountController = TextEditingController();
  final mrpController = TextEditingController();
  final unitController = TextEditingController();
  final barcodeController = TextEditingController();

  // Focus Nodes
  final gstFocused = FocusNode();
  final productFocused = FocusNode();
  final batchFocused = FocusNode();
  final qtyFocused = FocusNode();
  final freeQtyFocused = FocusNode();
  final rateFocused = FocusNode();
  final discountFocused = FocusNode();
  final mrpFocused = FocusNode();
  final unitFocused = FocusNode();
  final barcodeFocused = FocusNode();

  // Reactive values
  final RxDouble total = 0.0.obs;
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  final Rx<Itemdtls?> selectedBatch = Rx<Itemdtls?>(null);
  final RxList<Itemdtls> batchList = <Itemdtls>[].obs;

  ItemRowModel() {
    _addListeners();
  }

  void _addListeners() {
    final calculateTotal = _calculateTotal;
    qtyController.addListener(calculateTotal);
    rateController.addListener(calculateTotal);
    discountController.addListener(calculateTotal);
    gstControllerHeader.addListener(calculateTotal);
  }

  void _calculateTotal() {
    final qty = double.tryParse(qtyController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 0;
    final discount = double.tryParse(discountController.text) ?? 0;
    final gst = double.tryParse(gstControllerHeader.text) ?? 0;

    final amount = qty * rate;
    final disAmt = (amount * discount) / 100;
    final gstAmt = (amount * gst) / 100;
    total.value = amount + gstAmt - disAmt;
  }

  void clearProductBatchFields({bool unfocus = true}) {
    if (unfocus && Get.context != null) {
      Utils.closeKeyboard(Get.context!);
    }
    selectedProduct.value = null;
    productController.clear();
    gstControllerHeader.clear();

    packagingControllerHeader.clear();
    rackControllerHeader.clear();
    hsnCodeControllerHeader.clear();

    batchList.clear();

    clearBatchFields(unfocus: unfocus);
  }

  void clearBatchFields({bool unfocus = true}) {
    if (unfocus && Get.context != null) {
      Utils.closeKeyboard(Get.context!);
    }

    final controllers = [
      batchController,
      expiryDtController,
      qtyController,
      freeQtyController,
      rateController,
      discountController,
      gstControllerHeader,
    ];

    for (final controller in controllers) {
      controller.clear();
    }

    total.value = 0.0;
    selectedBatch.value = null;
  }

  void dispose() {
    // Remove listeners first to prevent callbacks during disposal
    qtyController.removeListener(_calculateTotal);
    rateController.removeListener(_calculateTotal);
    discountController.removeListener(_calculateTotal);
    gstControllerHeader.removeListener(_calculateTotal);

    // Dispose controllers
    final controllers = [
      packagingControllerHeader,
      rackControllerHeader,
      hsnCodeControllerHeader,
      gstControllerHeader,
      productCDController,
      productController,
      batchController,
      expiryDtController,
      qtyController,
      freeQtyController,
      rateController,
      discountController,
      mrpController,
      unitController,
      barcodeController,
    ];

    for (final controller in controllers) {
      if (!controller.hasListeners) {
        controller.dispose();
      }
    }

    // Dispose focus nodes safely
    final focusNodes = [
      gstFocused,
      productFocused,
      batchFocused,
      qtyFocused,
      freeQtyFocused,
      rateFocused,
      discountFocused,
      mrpFocused,
      unitFocused,
      barcodeFocused,
    ];

    for (final focusNode in focusNodes) {
      if (focusNode.canRequestFocus) {
        focusNode.unfocus();
      }
      if (!focusNode.hasListeners) {
        focusNode.dispose();
      }
    }
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
  // Basic info
  final moduleNo = ''.obs;
  final salesID = ''.obs;
  final salesInsertType = ''.obs;

  // Date controller
  final dtController = TextEditingController().obs;
  final dtFocus = FocusNode();

  // Party related
  final isDropdownPartyLoading = false.obs;
  final partyList = PartyResponse().obs;
  final selectedDropdownParty = Rx<PartyModel?>(null);
  final selectedDropdownPartyName = ''.obs;
  final selectedDropdownPartyCode = ''.obs;
  final selectedDropdownStateCD = ''.obs;
  final selectedDropdownStateName = ''.obs;
  final selectedDropdownOutState = ''.obs;
  final insertACCCd = ''.obs;
  final partyController = TextEditingController().obs;
  final partyFocus = FocusNode();

  // Product search
  final isLoading = false.obs;
  final mainList = ProductResponse().obs;
  final searchList = <ProductModel>[].obs;
  final errorMsg = ''.obs;

  // Tax data
  final taxList = TaxResponse().obs;
  final searchTaxList = <TaxModel>[].obs;

  // Cart and rows
  final List<Map<String, dynamic>> cartItems = [];
  final rows = <ItemRowModel>[ItemRowModel()].obs;

  // Totals
  final subtotal = 0.0.obs;
  final totalDiscount = 0.0.obs;
  final totalGST = 0.0.obs;
  final netAmount = 0.0.obs;
  final roundOff = 0.0.obs;

  // Payment and discount
  final selectedPaymentMethod = 'Credit'.obs;
  final discountPercent = 0.0.obs;
  final discountAmount = 0.0.obs;
  final discountAmtController = TextEditingController().obs;
  final discountAmtFocus = FocusNode();
  final discountPerController = TextEditingController().obs;
  final discountPerFocus = FocusNode();
  final cashReceivedController = TextEditingController().obs;
  final cashReceivedFocus = FocusNode();
  final narrationController = TextEditingController().obs;
  final narrationFocus = FocusNode();
  final paymentModeFocus = FocusNode();

  // UI state
  final isButtonClick = ''.obs;
  final isBottomLoading = false.obs;
  final isBottomDisable = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _initializeFromArguments();
    _setDefaultDate();
    await _initializeData();
  }

  void _initializeFromArguments() {
    final args = Get.arguments;
    moduleNo.value = args?['ModuleNo']?.toString() ?? '';
    salesID.value = args?['SalesID']?.toString() ?? '';
    salesInsertType.value = args?['Type']?.toString() ?? '';
  }

  void _setDefaultDate() {
    final isUpdate = salesID.value.isNotEmpty && salesInsertType.value == 'U';
    if (!isUpdate) {
      dtController.value.text = AppDatePicker.currentDate();
    }
  }

  Future<void> _initializeData() async {
    await Future.wait([fetchParty(), fetchTax()]);
  }

  @override
  void onClose() {
    _disposeRows();
    _disposeControllers();
    _disposeFocusNodes();
    super.onClose();
  }

  void _disposeRows() {
    // Unfocus all row focus nodes first
    for (final row in rows) {
      _unfocusRowNodes(row);
    }

    // Then dispose rows
    for (final row in rows) {
      row.dispose();
    }
    rows.clear();
  }

  void _disposeControllers() {
    final controllers = [
      dtController.value,
      partyController.value,
      discountAmtController.value,
      discountPerController.value,
      cashReceivedController.value,
      narrationController.value,
    ];

    for (final controller in controllers) {
      if (!controller.hasListeners) {
        controller.dispose();
      }
    }
  }

  void _disposeFocusNodes() {
    final focusNodes = [
      dtFocus,
      partyFocus,
      discountAmtFocus,
      discountPerFocus,
      cashReceivedFocus,
      narrationFocus,
      paymentModeFocus,
    ];

    for (final focusNode in focusNodes) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
      if (!focusNode.hasListeners) {
        focusNode.dispose();
      }
    }
  }

  void recalculateTotals(List<ItemRowModel> rows, List<TaxModel> taxRates) {
    final totals = _calculateRowTotals(rows);
    final globalDiscAmt = discountAmount.value;
    final net =
        totals.subtotal - totals.itemDiscount - globalDiscAmt + totals.gst;
    final roundedNet = net.roundToDouble();

    subtotal.value = totals.subtotal;
    totalDiscount.value = totals.itemDiscount + globalDiscAmt;
    totalGST.value = totals.gst;
    roundOff.value = roundedNet - net;
    netAmount.value = roundedNet;
  }

  ({double subtotal, double itemDiscount, double gst}) _calculateRowTotals(
    List<ItemRowModel> rows,
  ) {
    double subtotal = 0.0, itemDiscount = 0.0, gst = 0.0;

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

        subtotal += lineTotal;
        itemDiscount += lineDiscAmt;
        gst += lineGstAmt;
      }
    }

    return (subtotal: subtotal, itemDiscount: itemDiscount, gst: gst);
  }

  void addRow() {
    final newRow = ItemRowModel();
    rows.add(newRow);
  }

  void removeRow(int index) {
    if (!_isValidRowIndex(index)) return;

    // Don't delete if it's the only row
    if (rows.length <= 1) return;

    final currentRow = rows[index];

    // Unfocus any focused nodes in this row before disposal
    _unfocusRowNodes(currentRow);

    // Dispose the row safely
    currentRow.dispose();
    rows.removeAt(index);

    _ensureMinimumRows();
    recalculateTotals(rows, searchTaxList);

    print('Row removed successfully. New total rows: ${rows.length}');
  }

  void _unfocusRowNodes(ItemRowModel row) {
    final focusNodes = [
      row.gstFocused,
      row.productFocused,
      row.batchFocused,
      row.qtyFocused,
      row.freeQtyFocused,
      row.rateFocused,
      row.discountFocused,
      row.mrpFocused,
      row.unitFocused,
      row.barcodeFocused,
    ];

    for (final focusNode in focusNodes) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
  }

  void focusNextField(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    currentFocus.unfocus();
    if (nextFocus != null && nextFocus.canRequestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.context != null) {
          FocusScope.of(Get.context!).requestFocus(nextFocus);
        }
      });
    }
  }

  void focusFieldSafely(FocusNode? focusNode) {
    if (focusNode != null && focusNode.canRequestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.context != null) {
          FocusScope.of(Get.context!).requestFocus(focusNode);
        }
      });
    }
  }

  void unfocusAllFields() {
    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
  }

  void focusNextRowOrField(
    BuildContext context,
    int currentRowIndex,
    String currentField,
  ) {
    final currentRow = rows[currentRowIndex];

    switch (currentField) {
      case 'product':
        focusNextField(
          context,
          currentRow.productFocused,
          currentRow.batchFocused,
        );
        break;
      case 'batch':
        focusNextField(context, currentRow.batchFocused, currentRow.qtyFocused);
        break;
      case 'qty':
        focusNextField(
          context,
          currentRow.qtyFocused,
          currentRow.freeQtyFocused,
        );
        break;
      case 'freeQty':
        focusNextField(
          context,
          currentRow.freeQtyFocused,
          currentRow.rateFocused,
        );
        break;
      case 'rate':
        focusNextField(
          context,
          currentRow.rateFocused,
          currentRow.discountFocused,
        );
        break;
      case 'discount':
        // Move to next row's product field or add new row
        if (currentRowIndex < rows.length - 1) {
          focusNextField(
            context,
            currentRow.discountFocused,
            rows[currentRowIndex + 1].productFocused,
          );
        }
        break;
      case 'gst':
        // GST field is disabled, skip to next row
        if (currentRowIndex < rows.length - 1) {
          focusNextField(
            context,
            currentRow.gstFocused,
            rows[currentRowIndex + 1].productFocused,
          );
        } else {
          addRow();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (rows.isNotEmpty) {
              focusNextField(
                context,
                currentRow.gstFocused,
                rows.last.productFocused,
              );
            }
          });
        }
        break;
    }
  }

  bool _isValidRowIndex(int index) => index >= 0 && index < rows.length;

  void _ensureMinimumRows() {
    if (rows.isEmpty ||
        rows.every((r) => r.productController.text.trim().isNotEmpty)) {
      addRow();
    }
  }

  void updateDiscountFromAmount(String text) {
    if (text.trim().isEmpty) {
      _clearDiscountFields();
      return;
    }

    final parsed = double.tryParse(text);
    if (parsed == null) {
      discountAmount.value = 0.0;
      return;
    }

    discountAmount.value = parsed;
    _updateDiscountPercent(parsed);
    recalculateTotals(rows, searchTaxList);
  }

  void updateDiscountFromPercent(String text) {
    if (text.trim().isEmpty) {
      _clearDiscountFields();
      return;
    }

    final parsed = double.tryParse(text);
    if (parsed == null) {
      _resetDiscountToZero();
      return;
    }

    if (parsed > 100) {
      discountPerController.value.clear();
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Discount % cannot be greater than 100',
      );
      return;
    }

    discountPercent.value = parsed;
    _updateDiscountAmount(parsed);
    recalculateTotals(rows, searchTaxList);
  }

  void _clearDiscountFields() {
    discountAmount.value = 0.0;
    discountPercent.value = 0.0;
    discountPerController.value.clear();
    discountAmtController.value.clear();
    recalculateTotals(rows, searchTaxList);
  }

  void _resetDiscountToZero() {
    discountPercent.value = 0.0;
    discountAmount.value = 0.0;
    discountAmtController.value.text = '0.00';
  }

  void _updateDiscountPercent(double amount) {
    if (subtotal.value > 0) {
      final percent = (amount / subtotal.value) * 100;
      discountPercent.value = percent;
      discountPerController.value.text = percent.toStringAsFixed(2);
    }
  }

  void _updateDiscountAmount(double percent) {
    final discount = (percent / 100) * subtotal.value;
    discountAmount.value = discount;
    discountAmtController.value.text = discount.toStringAsFixed(2);
  }

  Future<void> fetchParty() async {
    if (!await Network.isConnected()) {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      return;
    }

    try {
      isDropdownPartyLoading(true);
      final response = await DioClient().get(AppURL.productsPartyURL);
      partyList.value = PartyResponse.fromJson(response);

      if (partyList.value.data?.isNotEmpty == true) {
        _setSelectedPartyIfExists();
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: 'No party found.');
      }
    } catch (e) {
      Utils.handleException(e);
    } finally {
      isDropdownPartyLoading(false);
    }
  }

  void _setSelectedPartyIfExists() {
    final partyCdStr = _getPartyCdFromArguments();
    if (partyCdStr?.trim().isNotEmpty == true) {
      final selectedItem = partyList.value.data!.firstWhere(
        (party) => party.aCCCD == partyCdStr,
        orElse: () => PartyModel(),
      );

      _updateSelectedParty(selectedItem);
    }
  }

  String? _getPartyCdFromArguments() {
    if (salesID.value.isNotEmpty && insertACCCd.value.isEmpty) {
      return Get.arguments?['PartyCD'];
    } else if (insertACCCd.value.isNotEmpty) {
      return insertACCCd.value;
    }
    return null;
  }

  void _updateSelectedParty(PartyModel party) {
    selectedDropdownParty.value = party;
    selectedDropdownPartyName.value = party.aCCNAME ?? '';
    selectedDropdownPartyCode.value = party.aCCCD ?? '';
    partyController.value.text = party.aCCNAME ?? '';
    selectedDropdownStateCD.value = party.sTATECODE?.toString() ?? '';
    selectedDropdownStateName.value = party.sTATE?.toString() ?? '';
    selectedDropdownOutState.value = party.oUTSTATE?.toString() ?? '';
  }

  Future<void> fetchTax() async {
    if (!await Network.isConnected()) {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      return;
    }

    try {
      final response = await DioClient().get(AppURL.taxURL);
      taxList.value = TaxResponse.fromJson(response);

      if (taxList.value.data?.isNotEmpty == true) {
        if (taxList.value.message == 'Data fetch successfully') {
          searchTaxList.value = taxList.value.data!;
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response.data['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: 'No data found.');
      }
    } catch (e) {
      Utils.handleException(e);
    }
  }

  Future<void> fetchProductBySearch(String val) async {
    if (!await Network.isConnected()) {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      return;
    }

    try {
      isLoading.value = true;
      errorMsg.value = '';

      final response = await DioClient().getQueryParam(
        AppURL.productsURL,
        queryParams: _buildSearchParams(val),
      );

      final newData = ProductResponse.fromJson(response);
      _updateProductList(newData, val);
    } catch (e) {
      _handleProductSearchError(e);
    } finally {
      isLoading.value = false;
      mainList.refresh();
    }
  }

  Map<String, dynamic> _buildSearchParams(String searchValue) {
    return {
      "search": searchValue,
      "deptCd": "",
      "items_per_page": "",
      "page": "1",
    };
  }

  void _updateProductList(ProductResponse newData, String searchValue) {
    if (newData.data?.isNotEmpty == true) {
      mainList.value = ProductResponse(
        message: newData.message,
        data: newData.data,
      );
      searchList.clear();
      searchList.addAll(newData.data!);
      filterData(serachVal: searchValue);
    } else {
      _clearProductList();
    }
  }

  void _clearProductList() {
    mainList.value = ProductResponse(data: []);
    searchList.clear();
  }

  void _handleProductSearchError(dynamic e) {
    _clearProductList();
    errorMsg.value = 'Something went wrong while searching.';
    Utils.handleException(e);
  }

  void filterData({List<String>? multipleQueries, required String serachVal}) {
    final queries = _getSearchQueries(multipleQueries, serachVal);

    if (queries.isEmpty) {
      mainList.value.data = List.from(searchList);
    } else {
      mainList.value.data = searchList
          .where((product) => _productMatchesQueries(product, queries))
          .toList();
    }

    mainList.refresh();
  }

  List<String> _getSearchQueries(
    List<String>? multipleQueries,
    String searchVal,
  ) {
    if (multipleQueries?.isNotEmpty == true) {
      return multipleQueries!;
    }
    return searchVal.isEmpty ? [] : [searchVal];
  }

  bool _productMatchesQueries(ProductModel product, List<String> queries) {
    return queries.any((query) => _productMatchesQuery(product, query));
  }

  bool _productMatchesQuery(ProductModel product, String query) {
    final lowerQuery = query.toLowerCase();

    return [
          product.iTEMNAME,
          product.iTEMSNAME,
          product.iTEMLNAME,
        ].any((field) => field?.toLowerCase().contains(lowerQuery) == true) ||
        [
          product.iTEMCD2?.toString(),
          product.iTEMCD?.toString(),
        ].any((field) => field?.contains(query) == true);
  }

  void updateBatchList(ItemRowModel row, List<Itemdtls> itemdtls) {
    final seen = <String>{};
    final filtered = itemdtls.where((e) {
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
    return Row(
      spacing: 10,
      children: [
        const Text("Sr"),
        const CommonTableCellContainer(flex: 4, child: Text("Item")),
        const CommonTableCellContainer(flex: 2, child: Text("Batch")),
        const CommonTableCellContainer(flex: 1, child: Text("Qty")),
        const CommonTableCellContainer(flex: 1, child: Text("Free")),
        const CommonTableCellContainer(flex: 1, child: Text("Rate")),
        const CommonTableCellContainer(flex: 1, child: Text("Disc.%")),
        const CommonTableCellContainer(flex: 1, child: Text("GST%")),
        const CommonTableCellContainer(
          flex: 1,
          child: Text("Total", textAlign: TextAlign.center),
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
                                    double.tryParse('${suggestion.cSTK}') ?? 0;
                                final stockColor = stockValue > 0
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
                                                color: stockColor.withValues(
                                                  alpha: 0.15,
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
                                                overflow: TextOverflow.ellipsis,
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CommonText(
                                                text:
                                                    "Rate: ₹${suggestion.sRATE1 ?? '0'}",
                                                fontSize: 10,
                                                maxLine: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CommonText(
                                                text:
                                                    "MRP: ₹${suggestion.mRP ?? '0'}",
                                                fontSize: 10,
                                                maxLine: 1,
                                                overflow: TextOverflow.ellipsis,
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
                            onSuggestionTap:
                                (
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
                                        singleBatch.iTEMBARCDNO?.toString() ??
                                        '';

                                    // Move focus to quantity field
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(row.qtyFocused);
                                        });
                                  } else {
                                    // Move focus to batch field
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(row.batchFocused);
                                        });
                                  }
                                  addRow();
                                },
                            onSubmit: (String value) {
                              // Handle text submission without selection
                              focusNextRowOrField(context, index, 'product');
                            },
                          ),
                        ),

                        /// --- BATCH FIELD ---
                        CommonTableCellContainer(
                          flex: 2,
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
                              final filteredList = row.batchList.where((item) {
                                return (item.sIZECD ?? '')
                                    .toLowerCase()
                                    .contains(search);
                              }).toList();

                              return filteredList.map((suggestion) {
                                final stockValue =
                                    double.tryParse('${suggestion.cLSTK}') ?? 0;
                                final stockColor = stockValue > 0
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
                                                overflow: TextOverflow.ellipsis,
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
                                                  color: stockColor.withValues(
                                                    alpha: 0.15,
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CommonText(
                                                text:
                                                    'MRP: ₹${suggestion.mRP ?? '0'}',
                                                fontSize: 11,
                                                maxLine: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CommonText(
                                                text:
                                                    'Pack: ${suggestion.dESC2 ?? 'N/A'}',
                                                fontSize: 11,
                                                maxLine: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Exp: ${formatDate(expDateStr)}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isExpiringSoon
                                                      ? Colors.red
                                                      : Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CommonText(
                                                text:
                                                    'By: ${suggestion.dESC3 ?? 'N/A'}',
                                                fontSize: 10,
                                                maxLine: 1,
                                                overflow: TextOverflow.ellipsis,
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
                            onSuggestionTap:
                                (SearchFieldListItem<Itemdtls> selected) {
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
                                      selectedItem.iTEMBARCDNO?.toString() ??
                                      '';

                                  // Move focus to batch field
                                  focusNextRowOrField(
                                    context,
                                    index,
                                    'product',
                                  );
                                },
                            onSubmit: (p0) =>
                                focusNextRowOrField(context, index, 'batch'),
                          ),
                        ),

                        /// --- QTY ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: TextField(
                            controller: row.qtyController,
                            focusNode: row.qtyFocused,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                focusNextRowOrField(context, index, 'qty'),
                            onChanged: (val) =>
                                recalculateTotals(rows, searchTaxList),
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

                        /// --- FREE QTY ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: TextField(
                            controller: row.freeQtyController,
                            focusNode: row.freeQtyFocused,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                focusNextRowOrField(context, index, 'freeQty'),
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

                        /// --- RATE ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: TextField(
                            controller: row.rateController,
                            focusNode: row.rateFocused,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(Utils.filterPatternWithDecimal0x2),
                              ),
                            ],
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                focusNextRowOrField(context, index, 'rate'),
                            onChanged: (val) =>
                                recalculateTotals(rows, searchTaxList),
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

                        /// --- DISCOUNT ---
                        CommonTableCellContainer(
                          flex: 1,
                          child: TextField(
                            controller: row.discountController,
                            focusNode: row.discountFocused,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(Utils.filterPatternWithDecimal0x2),
                              ),
                            ],
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                focusNextRowOrField(context, index, 'discount'),
                            onChanged: (val) =>
                                recalculateTotals(rows, searchTaxList),
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

                        /// --- GST (DISABLED) ---
                        CommonTableCellContainer(
                          flex: 1,
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
                          child: Center(
                            child: Obx(
                              () => IconButton(
                                onPressed: rows.length > 1
                                    ? () => removeRow(index)
                                    : null,
                                icon: const Icon(Icons.delete),
                                color: rows.length > 1
                                    ? Colors.red
                                    : Colors.grey,
                                tooltip: rows.length > 1
                                    ? 'Delete Row'
                                    : 'Cannot delete last row',
                                splashRadius: 20,
                                autofocus: false,
                                focusNode: FocusNode(skipTraversal: true),
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
    // Basic field validation
    if (!_validateBasicFields()) return false;

    // Row validation
    final validationErrors = _validateRows();
    if (validationErrors.isNotEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: validationErrors.join("\n"));
      return false;
    }

    // Build and validate cart items
    final itemsJson = buildSalesCartJson(
      salesRowList: rows,
      taxRates: searchTaxList,
    );

    if (itemsJson.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Please fill quantity and batch in at least one row',
      );
      return false;
    }

    cartItems.clear();
    cartItems.addAll(itemsJson);
    return true;
  }

  bool _validateBasicFields() {
    if (dtController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select date.');
      return false;
    }

    if (selectedDropdownPartyCode.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select party.');
      return false;
    }

    return true;
  }

  List<String> _validateRows() {
    final validationErrors = <String>[];

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      final rowValidation = _validateSingleRow(row, i + 1);
      if (rowValidation != null) {
        validationErrors.add(rowValidation);
      }
    }

    return validationErrors;
  }

  String? _validateSingleRow(ItemRowModel row, int rowNumber) {
    final itemSelected = row.selectedProduct.value != null;
    final batchSelected =
        row.selectedBatch.value != null &&
        (row.selectedBatch.value?.sIZECD?.isNotEmpty ?? false);
    final qtyEntered =
        row.qtyController.text.trim().isNotEmpty &&
        double.tryParse(row.qtyController.text.trim()) != null;

    if (itemSelected && batchSelected && !qtyEntered) {
      return "Item $rowNumber: Please enter quantity";
    }

    return null;
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
          "partyCd": selectedDropdownPartyCode.value.isNotEmpty
              ? selectedDropdownPartyCode.value
              : 'C00001',
          "shipParty": "",
          "payMode": selectedPaymentMethod.value,
          "cashAmt": selectedPaymentMethod.value == 'Cash'
              ? netAmount.value
              : 0.00,
          "cashRecv": selectedPaymentMethod.value == 'Cash'
              ? (cashReceivedController.value.text.isNotEmpty
                    ? cashReceivedController.value.text
                    : 0.00)
              : 0.00,
          "bankAmt": selectedPaymentMethod.value == 'Bank'
              ? netAmount.value
              : 0.00,
          "cardAmt": selectedPaymentMethod.value == 'Card'
              ? netAmount.value
              : 0.00,
          "upiAmt": selectedPaymentMethod.value == 'UPI'
              ? netAmount.value
              : 0.00,
          "creditAmt": selectedPaymentMethod.value == 'Credit'
              ? netAmount.value
              : 0.00,
          "discPer1": discountPerController.value.text.isNotEmpty
              ? discountPerController.value.text
              : 0.00,
          "discAmt1": discountAmtController.value.text.isNotEmpty
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
          "items": cartItems.map((item) {
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

        final dynamic response = type == "U"
            ? await DioClient().put(AppURL.salesURL, param)
            : await DioClient().post(AppURL.salesURL, param);

        if (response.statusCode == 200 || response.statusCode == 201) {
          cartItems.clear();

          clearData(); // Not Back

          // Get.back(); // From Summary to Item

          // if (type == "U") Get.back(); // From Item to Sales List

          AppSnackBar.showGetXCustomSnackBar(
            message: type == "U"
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
    _clearPartyData();
    _clearRowsData();
    _clearTotals();
    _clearPaymentData();
  }

  void _clearPartyData() {
    partyController.value.clear();
    partyFocus.unfocus();
    selectedDropdownParty.value = null;
    selectedDropdownPartyName.value = '';
    selectedDropdownPartyCode.value = '';
    selectedDropdownStateCD.value = '';
    selectedDropdownStateName.value = '';
    selectedDropdownOutState.value = '';
  }

  void _clearRowsData() {
    rows.clear();
    addRow();
  }

  void _clearTotals() {
    subtotal.value = 0.0;
    totalDiscount.value = 0.0;
    totalGST.value = 0.0;
    netAmount.value = 0.0;
    roundOff.value = 0.0;
  }

  void _clearPaymentData() {
    selectedPaymentMethod.value = 'Credit';
    discountPercent.value = 0.0;
    discountAmount.value = 0.0;

    final controllers = [
      discountAmtController.value,
      discountPerController.value,
      cashReceivedController.value,
      narrationController.value,
    ];

    for (final controller in controllers) {
      controller.clear();
    }
  }
}
