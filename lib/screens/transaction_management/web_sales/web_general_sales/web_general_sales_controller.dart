import 'package:demo_project/api/dio_client.dart';
import 'package:demo_project/app/app_date_format.dart';
import 'package:demo_project/app/app_snack_bar.dart';
import 'package:demo_project/app/app_url.dart';
import 'package:demo_project/models/party_response.dart';
import 'package:demo_project/screens/inventory_management/item/product_model.dart';
import 'package:demo_project/screens/inventory_management/tax/tax_response.dart';
import 'package:demo_project/screens/transaction_management/sales/sales_controller.dart';
import 'package:demo_project/utility/constants.dart';
import 'package:demo_project/utility/network.dart';
import 'package:demo_project/utility/utils.dart';
import 'package:demo_project/widgets/common_auto_complete_text_view.dart';
import 'package:demo_project/widgets/common_table_cell_container.dart';
import 'package:demo_project/widgets/common_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:searchfield/searchfield.dart';

class ItemRowModel {
  final TextEditingController packagingControllerHeader =
      TextEditingController();
  final TextEditingController rackControllerHeader = TextEditingController();
  final TextEditingController hsnCodeControllerHeader = TextEditingController();
  final TextEditingController gstControllerHeader = TextEditingController();
  FocusNode gstFocused = FocusNode();

  final TextEditingController productCDController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  FocusNode productFocused = FocusNode();
  final TextEditingController batchController = TextEditingController();
  FocusNode batchFocused = FocusNode();
  final TextEditingController expiryDtController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  FocusNode qtyFocused = FocusNode();
  final TextEditingController freeQtyController = TextEditingController();
  FocusNode freeQtyFocused = FocusNode();
  final TextEditingController rateController = TextEditingController();
  FocusNode rateFocused = FocusNode();
  final TextEditingController discountController = TextEditingController();
  FocusNode discountFocused = FocusNode();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
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

    final isUpdate = salesID.value.isNotEmpty && salesInsertType.value == 'U';

    if (isUpdate) {
      // Handle update mode if needed
    } else {
      dtController.value.text = AppDatePicker.currentDate();
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

    dtController.value.dispose();
    partyController.value.dispose();
    discountAmtController.value.dispose();
    discountPerController.value.dispose();
    cashReceivedController.value.dispose();
    narrationController.value.dispose();

    dtFocus.dispose();
    partyFocus.dispose();
    discountAmtFocus.dispose();
    discountPerFocus.dispose();
    cashReceivedFocus.dispose();
    narrationFocus.dispose();

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
    if (index < 0 || index >= rows.length) return;

    final currentRow = rows[index];

    // Check if row is blank (all key fields empty)
    final isBlankRow =
        currentRow.productController.text.trim().isEmpty &&
        currentRow.batchController.text.trim().isEmpty &&
        currentRow.qtyController.text.trim().isEmpty &&
        currentRow.rateController.text.trim().isEmpty;

    // If it's the last row and blank, do not delete
    if (rows.length == 1 && isBlankRow) return;

    currentRow.dispose();
    rows.removeAt(index);

    // Ensure at least one blank row always remains
    if (rows.isEmpty ||
        rows.every((r) => r.productController.text.trim().isNotEmpty)) {
      addRow();
    }

    recalculateTotals(rows, searchTaxList);
  }

  void updateDiscountFromAmount(String text) {
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

    if (subtotal.value > 0) {
      final percent = (parsed / subtotal.value) * 100;
      discountPercent.value = percent;
      discountPerController.value.text = percent.toStringAsFixed(2);
    }

    recalculateTotals(rows, searchTaxList);
  }

  void updateDiscountFromPercent(String text) {
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

    if (parsed > 100) {
      discountPerController.value.clear();
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Discount % cannot be greater than 100',
      );
      return;
    }

    discountPercent.value = parsed;

    final discount = (parsed / 100) * subtotal.value;
    discountAmount.value = discount;

    discountAmtController.value.text = discount.toStringAsFixed(2);

    recalculateTotals(rows, searchTaxList);
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

  Widget buildSalesGrid1(BuildContext context) {
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
            () => Column(
              children: List.generate(rows.length, (index) {
                final row = rows[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    spacing: 10,
                    children: [
                      Text((index + 1).toString()),
                      Expanded(
                        flex: 4,
                        child: CommonAutoCompleteTextView<ProductModel>(
                          controller: row.productController,
                          focusNode: row.productFocused,
                          nextFocusNode: row.batchFocused,
                          hintText: 'Item (Min 3 Char For Search)',

                          suggestionsCallback: (pattern) async {
                            final trimmed = pattern.trim();
                            if (trimmed.length < 3) return [];
                            await fetchProductBySearch(trimmed);
                            return mainList.value.data ?? [];
                          },
                          displayString: (item) => item.iTEMNAME ?? '',
                          itemBuilder: (context, suggestion) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Item Name
                                CommonText(
                                  text: suggestion.iTEMNAME ?? "",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),

                                // Stock and Company
                                Row(
                                  children: [
                                    // Stock with background
                                    Builder(
                                      builder: (_) {
                                        final stockValue =
                                            double.tryParse(
                                              '${suggestion.cSTK}',
                                            ) ??
                                            0;

                                        final color =
                                            stockValue > 0
                                                ? Colors.green
                                                : Colors.red;

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: color.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            'Stock: ${stockValue.toString()}',
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CommonText(
                                        text:
                                            "Company: ${suggestion.deptment?.dEPTNAME ?? 'N/A'}",
                                        fontSize: 10,
                                        color: Colors.black87,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Pack, Rate, MRP
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CommonText(
                                        text:
                                            "Pack: ${suggestion.uNIT ?? 'N/A'}",
                                        fontSize: 10,
                                        color: Colors.black87,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      flex: 2,
                                      child: CommonText(
                                        text:
                                            "Rate: ₹${suggestion.sRATE1 ?? '0'}",
                                        fontSize: 10,
                                        color: Colors.black87,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      flex: 2,
                                      child: CommonText(
                                        text: "MRP: ₹${suggestion.mRP ?? '0'}",
                                        fontSize: 10,
                                        color: Colors.black87,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          onSelected: (selectedItem) {
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

                            updateBatchList(row, selectedItem.itemdtls ?? []);

                            addRow();
                          },
                          onClear: () => row.clearProductBatchFields(),
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 2,
                        child: CommonAutoCompleteTextView<Itemdtls>(
                          controller: row.batchController,
                          focusNode: row.batchFocused,
                          nextFocusNode: row.qtyFocused,
                          hintText: 'Enter batch',
                          textCapitalization: TextCapitalization.characters,
                          //keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z0-9]'),
                            ),
                          ],
                          suggestionsCallback: (pattern) async {
                            final search = pattern.toLowerCase().replaceAll(
                              ' ',
                              '',
                            );
                            return row.batchList.where((item) {
                              return (item.sIZECD ?? '').toLowerCase().contains(
                                search,
                              );
                            }).toList();
                          },
                          displayString: (item) => item.sIZECD ?? '',
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              'Batch : ${suggestion.sIZECD ?? ''}',
                                        ),
                                      ),
                                      Expanded(
                                        child: Builder(
                                          builder: (_) {
                                            final stockValue =
                                                double.tryParse(
                                                  '${suggestion.cLSTK}',
                                                ) ??
                                                0;

                                            final color =
                                                stockValue > 0
                                                    ? Colors.green
                                                    : Colors.red;

                                            return Text.rich(
                                              TextSpan(
                                                text: 'Cl Stock : ',
                                                children: [
                                                  TextSpan(
                                                    text: stockValue.toString(),
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              'Sale Rate : ₹${suggestion.sALERATE1 ?? ''}',
                                        ),
                                      ),
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              'MRP : ₹${suggestion.mRP ?? ''}',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Builder(
                                          builder: (_) {
                                            final rawDate =
                                                suggestion.mFGDT ?? '';
                                            String formattedDate = '';

                                            if (rawDate.isNotEmpty) {
                                              try {
                                                formattedDate =
                                                    AppDatePicker.convertDateTimeFormat(
                                                      rawDate,
                                                      'yyyy-MM-dd',
                                                      'dd-MM-yyyy',
                                                    );
                                              } catch (_) {
                                                formattedDate =
                                                    ''; // fallback if format fails
                                              }
                                            }

                                            return CommonText(
                                              text: 'MFG Dt : $formattedDate',
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Builder(
                                          builder: (_) {
                                            final expDateStr =
                                                suggestion.eXPDT ?? '';
                                            DateTime? expDate;
                                            String formattedDate = '';

                                            if (expDateStr.isNotEmpty) {
                                              try {
                                                expDate = DateTime.parse(
                                                  expDateStr,
                                                );
                                                formattedDate =
                                                    AppDatePicker.convertDateTimeFormat(
                                                      expDateStr,
                                                      'yyyy-MM-dd',
                                                      'dd-MM-yyyy',
                                                    );
                                              } catch (_) {
                                                expDate = null;
                                                formattedDate = '';
                                              }
                                            }

                                            final now = DateTime.now();
                                            final sixMonthsLater = DateTime(
                                              now.year,
                                              now.month + 6,
                                              now.day,
                                            );

                                            final isExpiringSoon =
                                                expDate != null &&
                                                expDate.isBefore(
                                                  sixMonthsLater,
                                                );
                                            final dateColor =
                                                isExpiringSoon
                                                    ? Colors.red
                                                    : null; // null = default theme color

                                            return Text.rich(
                                              TextSpan(
                                                text: 'Exp Dt : ',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: formattedDate,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          dateColor, // Only red if expiring
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              'Packing : ${suggestion.dESC2 ?? ''}',
                                        ),
                                      ),
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              'MFG By : ${suggestion.dESC3 ?? ''}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          onSelected: (selectedItem) {
                            row.selectedBatch.value = selectedItem;
                            row.batchController.text =
                                selectedItem.sIZECD ?? '';

                            final exp = selectedItem.eXPDT ?? '';
                            row.expiryDtController.text =
                                exp.isNotEmpty
                                    ? AppDatePicker.convertDateTimeFormat(
                                      exp,
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

                            row.sizeIdxDtl.value =
                                selectedItem.sIZEIDX?.toString() ?? '';
                            row.blackListDtl.value =
                                selectedItem.bLACKLIST?.toString() ?? '';
                            row.pRateTaxDtl.value =
                                selectedItem.pRATETAX?.toString() ?? '';
                            row.opRateDtl.value =
                                selectedItem.oPRATE?.toString() ?? '';
                            row.clRateDtl.value =
                                selectedItem.cLRATE?.toString() ?? '';
                            row.saleRate1Dtl.value =
                                selectedItem.sALERATE1?.toString() ?? '';
                            row.saleRate2Dtl.value =
                                selectedItem.sALERATE2?.toString() ?? '';
                            row.saleRate3Dtl.value =
                                selectedItem.sALERATE3?.toString() ?? '';
                            row.saleRate4Dtl.value =
                                selectedItem.sALERATE4?.toString() ?? '';
                            row.saleRate5Dtl.value =
                                selectedItem.sALERATE5?.toString() ?? '';
                            row.saleRate6Dtl.value =
                                selectedItem.sALERATE6?.toString() ?? '';
                            row.saleRate7Dtl.value =
                                selectedItem.sALERATE7?.toString() ?? '';
                            row.saleRate8Dtl.value =
                                selectedItem.sALERATE8?.toString() ?? '';
                            row.comRateDtl.value =
                                selectedItem.cOMRATE?.toString() ?? '';
                            row.saleDiscDtl.value =
                                selectedItem.sALEDISC?.toString() ?? '';
                            row.saleDisc1Dtl.value =
                                selectedItem.sALEDISC1?.toString() ?? '';
                            row.saleDisc2Dtl.value =
                                selectedItem.sALEDISC2?.toString() ?? '';
                            row.saleDisc3Dtl.value =
                                selectedItem.sALEDISC3?.toString() ?? '';
                            row.sioDiscDtl.value =
                                selectedItem.sIODISC?.toString() ?? '';
                            row.opStkDtl.value =
                                selectedItem.oPSTK?.toString() ?? '';
                            row.drStkDtl.value =
                                selectedItem.dRSTK?.toString() ?? '';
                            row.crStkDtl.value =
                                selectedItem.cRSTK?.toString() ?? '';
                            row.clStkDtl.value =
                                selectedItem.cLSTK?.toString() ?? '';
                            row.orStkDtl.value =
                                selectedItem.oRSTK?.toString() ?? '';
                            row.opDescDtl.value =
                                selectedItem.oPDESC?.toString() ?? '';
                            row.clDescDtl.value =
                                selectedItem.cLDESC?.toString() ?? '';
                            row.drBaseDtl.value =
                                selectedItem.dRBASE?.toString() ?? '';
                            row.drFrDtl.value =
                                selectedItem.dRFR?.toString() ?? '';
                            row.crBaseDtl.value =
                                selectedItem.cRBASE?.toString() ?? '';
                            row.crFrDtl.value =
                                selectedItem.cRFR?.toString() ?? '';
                            row.minStkDtl.value =
                                selectedItem.mINSTK?.toString() ?? '';
                            row.roStkDtl.value =
                                selectedItem.rOSTK?.toString() ?? '';
                            row.actualStkDtl.value =
                                selectedItem.aCTUALSTK?.toString() ?? '';
                            row.mfgDtDtl.value =
                                selectedItem.mFGDT?.toString() ?? '';
                            row.desc1Dtl.value =
                                selectedItem.dESC1?.toString() ?? '';
                            row.batchNoDtl.value =
                                selectedItem.bATCHNO?.toString() ?? '';
                            row.desc3Dtl.value =
                                selectedItem.dESC3?.toString() ?? '';
                          },
                          onClear: () {
                            row.clearBatchFields();
                          },
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: CommonAutoCompleteTextView<String>(
                          controller: row.qtyController,
                          focusNode: row.qtyFocused,
                          nextFocusNode: row.freeQtyFocused,
                          hintText: "Qty *",
                          showClearButton: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (val) {
                            recalculateTotals(rows, searchTaxList);
                          },
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: CommonAutoCompleteTextView<String>(
                          controller: row.freeQtyController,
                          focusNode: row.freeQtyFocused,
                          nextFocusNode: row.rateFocused,
                          hintText: "Free Qty",
                          showClearButton: false,
                          // keyboardType: TextInputType.text,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(
                          //       RegExp(r'[a-zA-Z0-9]')),
                          // ],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: CommonAutoCompleteTextView<String>(
                          controller: row.rateController,
                          focusNode: row.rateFocused,
                          nextFocusNode: row.discountFocused,
                          hintText: "Rate",
                          showClearButton: false,
                          onChanged: (val) {
                            recalculateTotals(rows, searchTaxList);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                Utils.filterPatternWithDecimal0x2,
                              ), // allows up to 2 decimal places
                            ),
                          ],
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: CommonAutoCompleteTextView<String>(
                          controller: row.discountController,
                          focusNode: row.discountFocused,
                          nextFocusNode: row.gstFocused,

                          
                          hintText: "Dis %",
                          showClearButton: false,
                          
                          onChanged: (val) {
                            recalculateTotals(rows, searchTaxList);
                            
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                Utils.filterPatternWithDecimal0x2,
                              ), // allows up to 2 decimal places
                            ),
                          ],
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: CommonAutoCompleteTextView<String>(
                          controller: row.gstControllerHeader,
                          focusNode: row.gstFocused,
                          hintText: "GST %",
                          showClearButton: false,
                          enabled: false,
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: Obx(
                          () => Text(
                            row.total.value.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      CommonTableCellContainer(
                        flex: 1,
                        child: Listener(
                          onPointerHover: (_) {},
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              removeRow(index);
                            },
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
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
                                final stockColor =
                                    stockValue > 0 ? Colors.green : Colors.red;

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

                              updateBatchList(row, selectedItem.itemdtls ?? []);
                              
                              // Auto-populate batch if only one batch available
                              if (row.batchList.length == 1) {
                                final singleBatch = row.batchList.first;
                                row.selectedBatch.value = singleBatch;
                                row.batchController.text = singleBatch.sIZECD ?? '';
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

                              // Move focus to quantity field
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  FocusScope.of(context).requestFocus(row.qtyFocused);
                                });
                              } else {
                                // Move focus to batch field
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  FocusScope.of(context).requestFocus(row.batchFocused);
                                });
                              }
                              addRow();
                            },
                            onSubmit: (String value) {
                              // Handle text submission without selection
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.batchFocused);
                              });
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
                              final filteredList =
                                  row.batchList.where((item) {
                                    return (item.sIZECD ?? '')
                                        .toLowerCase()
                                        .contains(search);
                                  }).toList();

                              return filteredList.map((suggestion) {
                                final stockValue =
                                    double.tryParse('${suggestion.cLSTK}') ?? 0;
                                final stockColor =
                                    stockValue > 0 ? Colors.green : Colors.red;

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
                                                  color:
                                                      isExpiringSoon
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

                              // Move focus to quantity field
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.qtyFocused);
                              });
                            },
                            onSubmit: (p0) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.qtyFocused);
                              });
                            },
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
                            onSubmitted: (_) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.freeQtyFocused);
                              });
                            },
                            onChanged:
                                (val) => recalculateTotals(rows, searchTaxList),
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
                            onSubmitted: (_) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.rateFocused);
                              });
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
                            onSubmitted: (_) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.discountFocused);
                              });
                            },
                            onChanged:
                                (val) => recalculateTotals(rows, searchTaxList),
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
                            onSubmitted: (_) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(row.gstFocused);
                              });
                            },
                            onChanged:
                                (val) => recalculateTotals(rows, searchTaxList),
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
                          child: Listener(
                            onPointerHover: (_) {},
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => removeRow(index),
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
    if (dtController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select date.');
      return false;
    }

    if (selectedDropdownPartyCode.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select party.');
      return false;
    }

    final List<String> validationErrors = [];

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];

      final itemSelected = row.selectedProduct.value != null;
      final batchSelected =
          row.selectedBatch.value != null &&
          (row.selectedBatch.value?.sIZECD?.isNotEmpty ?? false);
      final qtyEntered =
          row.qtyController.text.trim().isNotEmpty &&
          double.tryParse(row.qtyController.text.trim()) != null;

      if (itemSelected && batchSelected && !qtyEntered) {
        validationErrors.add("Item ${i + 1}: Please enter quantity");
      }
    }

    if (validationErrors.isNotEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: validationErrors.join("\n"));
      return false;
    }

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
}
