import 'dart:developer';

import 'package:demo/api/dio_client.dart';
import 'package:demo/app/app_date_format.dart';
import 'package:demo/app/app_dimensions.dart';
import 'package:demo/app/app_font_weight.dart';
import 'package:demo/app/app_routes.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/app/app_url.dart';
import 'package:demo/models/firm_response.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/screens/transaction_management/sales/sales_expand_response.dart';
import 'package:demo/screens/transaction_management/sales/sales_response.dart';
import 'package:demo/screens/transaction_management/sales/sales_response_new.dart';
import 'package:demo/utility/constants.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utility/network.dart';

class SalesController extends GetxController {
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  var isLoading = false.obs;
  var isExpandWithoutVouchLoading = false.obs;
  var isExpandWithVouchLoading = false.obs;
  var isDeleteLoading = false.obs;
  var loadingIndex = RxnInt();

  var mainList = SalesResponseNew().obs;
  var searchList = <SalesModelNew>[].obs;
  var errorMsg = ''.obs;

  var salesExpandWithVocuhList = SalesExpandResponse().obs;
  var searchExpandWithVocuhList = <SalesExpandItemsModel>[].obs;

  var searchGroupController = TextEditingController().obs;
  var searchGroupFocus = FocusNode();
  var searchQuery = ''.obs;

  var searchGroupExpandController = TextEditingController().obs;
  var searchGroupExpandFocus = FocusNode();
  var searchExpandQuery = ''.obs;

  var fromDateController = TextEditingController().obs;
  var toDateController = TextEditingController().obs;
  var fromDtFocus = FocusNode();
  var toDtFocus = FocusNode();

  var isDropdownPartyLoading = false.obs;
  var partyList = PartyResponse().obs;
  var selectedDropdownParty = Rx<PartyModel?>(null);
  var selectedDropdownPartyName = ''.obs;
  var selectedDropdownPartyCode = ''.obs;
  var partyController = TextEditingController().obs;
  var partyFocus = FocusNode();

  var moduleNo = ''.obs;
  var readRight = false.obs;
  var writeRights = false.obs;
  var updateRights = false.obs;
  var deleteRights = false.obs;
  var printRights = false.obs;

  var screenWidth = MediaQuery.of(Get.context!).size.width;
  var screenHeight = MediaQuery.of(Get.context!).size.height;
  var marginBottom = 56.0;
  var marginRight = 20.0;
  var fabSizeHeight = 56.0;
  var fabSizeWidth = 140.0;
  var dx = 0.0;
  var dy = 0.0;

  var firmName = '';
  var personName = '';
  var personNo = '';
  var personNo1 = '';
  var gstNo = '';
  var add1 = '';
  var add2 = '';
  var add3 = '';
  var add4 = '';
  var add5 = '';
  var foot1 = '';
  var foot2 = '';
  var foot3 = '';
  var foot4 = '';
  var foot5 = '';
  var logo = '';
  var qr = '';
  var sign = '';
  var upiID = '';
  var fssiNo = '';
  var drugLic1 = '';
  var drugLic2 = '';
  var panNo = '';
  var regNo1 = '';
  var regNo2 = '';

  void useStoredFirmValues() {
    final FirmModel? storedFirm = Utils.getStoredFirmObject();
    if (storedFirm != null) {
      firmName = storedFirm.fIRMNAME ?? '';
      personName = storedFirm.pERSONNM ?? '';
      personNo = storedFirm.mOBILE1 ?? '';
      personNo1 = storedFirm.mOBILE2 ?? '';
      gstNo = storedFirm.gSTNO ?? '';
      add1 = storedFirm.aDD1 ?? '';
      add2 = storedFirm.aDD2 ?? '';
      add3 = storedFirm.aDD3 ?? '';
      add4 = storedFirm.aDD4 ?? '';
      add5 = storedFirm.aDD5 ?? '';

      foot1 = storedFirm.fOOTER1 ?? '';
      foot2 = storedFirm.fOOTER2 ?? '';
      foot3 = storedFirm.fOOTER3 ?? '';
      foot4 = storedFirm.fOOTER4 ?? '';
      foot5 = storedFirm.fOOTER5 ?? '';

      logo = storedFirm.fIRMLOGO ?? '';
      qr = storedFirm.fIRMQRCODE ?? '';
      sign = storedFirm.fIRMSIGN ?? '';
      upiID = storedFirm.uPI ?? '';
      fssiNo = storedFirm.fSSAINO ?? '';
      drugLic1 = storedFirm.dRUGLIC1 ?? '';
      drugLic2 = storedFirm.dRUGLIC2 ?? '';
      panNo = storedFirm.pANNO ?? '';
      regNo1 = storedFirm.rEGNO1 ?? '';
      regNo2 = storedFirm.rEGNO2 ?? '';
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    moduleNo.value = Get.arguments['ModuleNo'] ?? '';
    readRight.value = Get.arguments['ReadRight'] ?? false;
    writeRights.value = Get.arguments['WriteRight'] ?? false;
    updateRights.value = Get.arguments['UpdateRight'] ?? false;
    deleteRights.value = Get.arguments['DeleteRight'] ?? false;
    printRights.value = Get.arguments['PrintRight'] ?? false;

    if (kDebugMode) {
      print("Sales Screen : Module No : ${moduleNo.value}");
      print("Sales Screen : Read Right : ${readRight.value}");
      print("Sales Screen : Write Right : ${writeRights.value}");
      print("Sales Screen : Update Right : ${updateRights.value}");
      print("Sales Screen : Delete Right : ${deleteRights.value}");
      print("Sales Screen : Print Right : ${printRights.value}");
    }

    //fromDateController.value.text = AppDatePicker.firstDayFinancialYear();
    //toDateController.value.text = AppDatePicker.lastDayFinancialYear();

    fromDateController.value.text = AppDatePicker.currentDate();
    toDateController.value.text = AppDatePicker.currentDate();

    dx = screenWidth - fabSizeWidth - marginRight;
    dy = screenHeight - fabSizeHeight - marginBottom;

    useStoredFirmValues();

    await fetchSales();
    await fetchParty();
  }

  Future<void> fetchParty() async {
    if (await Network.isConnected()) {
      try {
        isDropdownPartyLoading(true);

        final response = await DioClient().get(AppURL.productsPartyURL);
        partyList.value = PartyResponse.fromJson(response);

        if (partyList.value.data!.isNotEmpty) {
          if (partyList.value.message == 'Data fetch successfully') {
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
      } finally {
        isDropdownPartyLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchSales() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);

        mainList.value.sales?.clear();
        searchList.clear();
        mainList.refresh();

        final Map<String, dynamic> param = {
          "fromDate": AppDatePicker.convertDateTimeFormat(
            fromDateController.value.text,
            'dd/MM/yyyy',
            'yyyy-MM-dd',
          ),
          "toDate": AppDatePicker.convertDateTimeFormat(
            toDateController.value.text,
            'dd/MM/yyyy',
            'yyyy-MM-dd',
          ),
          "partyCd": selectedDropdownPartyCode.value,
          "userCd": PreferenceUtils.getUserCD(),
        };

        final response = await DioClient().getQueryParam(
          AppURL.salesReportURL,
          queryParams: param,
        );

        final newData = SalesResponseNew.fromJson(response);

        if (newData.sales != null && newData.sales!.isNotEmpty) {
          mainList.value = newData;
          searchList.value = newData.sales!;
          filterData();
        } else {
          errorMsg.value = 'No sales data found.';
        }
      } catch (e) {
        Utils.handleException(e);
      } finally {
        isLoading(false);
        mainList.refresh();
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  void filterData() {
    List<SalesModelNew> filteredList = searchList;

    if (searchQuery.value.isNotEmpty) {
      final String query = searchQuery.value.toLowerCase();
      filteredList =
          filteredList.where((group) {
            return (group.bILLNO != null &&
                    group.bILLNO!.toString().toLowerCase().contains(query)) ||
                // (group.vOUCHNO != null &&
                //     group.vOUCHNO!.toString().toLowerCase().contains(query)) ||
                (group.pARTYCD != null &&
                    group.pARTYCD!.toString().toLowerCase().contains(query));
          }).toList();

      if (filteredList.isEmpty) {
        mainList.value.sales = [];
        mainList.refresh();
        return;
      }
    }

    // Update the payment list
    mainList.value.sales = filteredList;
    mainList.refresh(); // Update UI
  }

  void showBottomSheetDialogExpandPaymentWithoutVocuhNoTable(
    BuildContext context,
    List<Salesitems> list,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            final bool isDark = Theme.of(context).brightness == Brightness.dark;

            final ScrollController verticalScrollController =
                ScrollController();
            final ScrollController horizontalScrollController =
                ScrollController();

            final purchases = list;

            final totalAmount = purchases.fold<double>(0, (sum, item) {
              return sum +
                  (double.tryParse(item.aMOUNT?.toString() ?? '0') ?? 0);
            });

            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Icon(Icons.drag_handle, size: 30)),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: verticalScrollController,
                      child: SingleChildScrollView(
                        controller: horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 25.0,
                          border: TableBorder.all(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          columns: const [
                            DataColumn(label: CommonText(text: 'Item Name')),
                            DataColumn(label: CommonText(text: 'Batch/MRP')),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Rate'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Qty'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Free Qty'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Amt'),
                              ),
                            ),
                            DataColumn(label: CommonText(text: 'Remarks')),
                          ],
                          rows: [
                            ...purchases.map((purchase) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CommonText(text: purchase.iTEMNAME ?? ''),
                                  ),
                                  DataCell(
                                    CommonText(text: purchase.sIZECD ?? ''),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.rATE?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text:
                                            purchase.qUANTITY?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.oTHERDESC ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.aMOUNT?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    CommonText(
                                      text:
                                          purchase.oTHERDESC?.toString() ?? '',
                                    ),
                                  ),
                                ],
                              );
                            }),
                            DataRow(
                              cells: [
                                const DataCell(
                                  CommonText(
                                    text: 'Total',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CommonText(
                                      text: Utils.formatIndianAmount(
                                        totalAmount,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                const DataCell(CommonText(text: '')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> deleteSales(String sALESID) async {
    try {
      isDeleteLoading(true);

      if (await Network.isConnected()) {
        final String url = '${AppURL.salesURL}/$sALESID';
        final response = await DioClient().delete(url);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final String message =
              response.data['message'] ?? 'Deleted successfully';
          await Utils.successWithBack(message).then((_) {
            fetchSales();
          });
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
      isDeleteLoading(false);
    }
  }

  Future<void> fetchExpandPaymentWithVouch(String salesId) async {
    if (await Network.isConnected()) {
      try {
        isExpandWithVouchLoading(true);

        //TODO: This Type BookCd [SA/SR/PU/PR/SO/SI/WS] Not Bind Vouch No
        //TODO: This Type BookCd [RC/PY/EP/IC/JV] Bind Vouch No

        final Map<String, dynamic> param = {"salesId": salesId};

        final response = await DioClient().getQueryParam(
          AppURL.salesReportByIdURL,
          queryParams: param,
        );

        salesExpandWithVocuhList.value = SalesExpandResponse.fromJson(response);

        if (salesExpandWithVocuhList.value.sales != null) {
          searchExpandWithVocuhList.value =
              salesExpandWithVocuhList.value.items!;

          showBottomSheetDialogExpandPaymentWithVocuhNoTable(Get.context!);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'No data found.');
        }
      } catch (e) {
        Utils.handleException(e);
      } finally {
        isExpandWithVouchLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> fetchViewDetails(String salesId, int index) async {
    if (await Network.isConnected()) {
      try {
        loadingIndex.value = index;

        final Map<String, dynamic> param = {"salesId": salesId};

        final response = await DioClient().getQueryParam(
          AppURL.salesReportByIdURL,
          queryParams: param,
        );

        salesExpandWithVocuhList.value = SalesExpandResponse.fromJson(response);

        if (salesExpandWithVocuhList.value.sales != null) {
          searchExpandWithVocuhList.value =
              salesExpandWithVocuhList.value.items!;
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'No data found.');
        }
      } catch (e) {
        log(e.toString());
        Utils.handleException(e);
      } finally {
        loadingIndex.value = null;
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  void showBottomSheetDialogExpandPaymentWithVocuhNoTable(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final bool isDark = Theme.of(context).brightness == Brightness.dark;

        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            final ScrollController verticalScrollController =
                ScrollController();
            final ScrollController horizontalScrollController =
                ScrollController();

            final purchases = salesExpandWithVocuhList.value.items ?? [];

            final totalAmount = purchases.fold<double>(0, (sum, item) {
              return sum +
                  (double.tryParse(item.aMOUNT?.toString() ?? '0') ?? 0);
            });

            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Icon(Icons.drag_handle, size: 30)),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: verticalScrollController,
                      child: SingleChildScrollView(
                        controller: horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 25,
                          border: TableBorder.all(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          columns: const [
                            DataColumn(label: CommonText(text: 'Item Name')),
                            DataColumn(label: CommonText(text: 'Batch/MRP')),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Rate'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Qty'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Free Qty'),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: CommonText(text: 'Amt'),
                              ),
                            ),
                            //DataColumn(label: CommonText(text: 'Remarks')),
                          ],
                          rows: [
                            ...purchases.map((purchase) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CommonText(text: purchase.iTEMNAME ?? ''),
                                  ),
                                  DataCell(
                                    CommonText(text: purchase.sIZECD ?? ''),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.rATE?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text:
                                            purchase.qUANTITY?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.oTHERDESC ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CommonText(
                                        text: purchase.aMOUNT?.toString() ?? '',
                                      ),
                                    ),
                                  ),
                                  // DataCell(
                                  //   CommonText(
                                  //       text: purchase.oTHERDESC?.toString() ??
                                  //           ''),
                                  // ),
                                ],
                              );
                            }),
                            DataRow(
                              cells: [
                                const DataCell(
                                  CommonText(
                                    text: 'Total',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                const DataCell(CommonText(text: '')),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CommonText(
                                      text: Utils.formatIndianAmount(
                                        totalAmount,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                //DataCell(CommonText(text: '')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.toNamed(
                              AppRoutes.generalSalesAddRoute,
                              arguments: {"FirmCD": "", "Type": "A"},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.fiber_manual_record_outlined),
                                const SizedBox(width: 10),
                                CommonText(
                                  text: 'Manually',
                                  fontSize: AppDimensions.fontSizeMedium,
                                  fontWeight: AppFontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
