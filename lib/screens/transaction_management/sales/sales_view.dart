import 'package:demo/app/app_date_format.dart';
import 'package:demo/app/app_dimensions.dart';
import 'package:demo/app/app_font_weight.dart';
import 'package:demo/app/app_routes.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/screens/drawer/app_drawer_controller.dart';
import 'sales_controller.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_app_bar.dart';
import 'package:demo/widgets/common_date_picker.dart';
import 'package:demo/widgets/common_input_field.dart';
import 'package:demo/widgets/common_material_dialog.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:demo/widgets/common_text_button.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_searchable_dropdown.dart';

class SalesView extends GetView<SalesController> {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: Visibility(
        visible:
            controller.writeRights.value &&
            PreferenceUtils.getCategory().toLowerCase() == 'general',
        //visible: false,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (kIsWeb) {
              Get.toNamed(
                AppRoutes.webGeneralSalesRoute,
                arguments: {
                  "ModuleNo": controller.moduleNo.value,
                  "SalesID": '',
                  "Type": "A",
                },
              );
            } else {
              // Get.toNamed(AppRoutes.generalSalesAddRoute, arguments: {
              //   "ModuleNo": controller.moduleNo.value,
              //   "SalesID": '',
              //   "Type": "A",
              // });
            }
          },
          tooltip: 'Add Sales',
          icon: const Icon(Icons.add),
          label: const Text('Add Sales'),
        ),
      ),
      floatingWidgetHeight: controller.fabSizeHeight,
      floatingWidgetWidth: controller.fabSizeWidth,
      dx: controller.dx,
      dy: controller.dy,
      mainScreenWidget: PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) {
            Future.microtask(() {
              final drawerController = Get.find<AppDrawerController>();
              drawerController.fetchDrawer();
            });
          }
          return;
        },
        child: Scaffold(
          appBar: const CommonAppBar(title: 'Sales Report'),
          body: SafeArea(
            child: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonDatePickerInput(
                            controller: controller.fromDateController.value,
                            labelText: "From Date",
                            isEnabled: true,
                            onTap: () async {
                              Utils.closeKeyboard(context);
                              final DateTime? selectedDate =
                                  await AppDatePicker.allDateEnable1(
                                    context,
                                    controller.fromDateController.value,
                                  );

                              if (selectedDate != null) {
                                final String formattedDate =
                                    AppDatePicker.formatDate(selectedDate);
                                controller.fromDateController.value.text =
                                    formattedDate;
                                controller.fetchSales();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CommonDatePickerInput(
                            controller: controller.toDateController.value,
                            labelText: "To Date",
                            isEnabled: true,
                            onTap: () async {
                              Utils.closeKeyboard(context);
                              final DateTime? selectedDate =
                                  await AppDatePicker.allDateEnable1(
                                    context,
                                    controller.toDateController.value,
                                  );

                              if (selectedDate != null) {
                                final String formattedDate =
                                    AppDatePicker.formatDate(selectedDate);
                                controller.toDateController.value.text =
                                    formattedDate;
                                controller.fetchSales();
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    Obx(
                      () =>
                          controller.isDropdownPartyLoading.isTrue
                              ? Center(
                                child: Utils.commonCircularProgress(),
                              ).paddingOnly(top: 10)
                              : CommonSearchableDropdown<PartyModel>(
                                controller: controller.partyController.value,
                                focusNode: controller.partyFocus,
                                labelText: 'Party Name',
                                maxLength: 11,
                                suggestionsCallback: (pattern) async {
                                  final search = pattern
                                      .toLowerCase()
                                      .replaceAll(' ', '');
                                  //if (search.length < 3) return [];

                                  return controller.partyList.value.data?.where(
                                        (item) {
                                          final accName =
                                              item.aCCNAME
                                                  ?.toLowerCase()
                                                  .replaceAll(' ', '') ??
                                              "";
                                          final accCd =
                                              item.aCCCD
                                                  ?.toLowerCase()
                                                  .replaceAll(' ', '') ??
                                              "";
                                          final mobile =
                                              item.mobile1
                                                  ?.toLowerCase()
                                                  .replaceAll(' ', '') ??
                                              "";
                                          return accName.contains(search) ||
                                              accCd.contains(search) ||
                                              mobile.contains(search);
                                        },
                                      ).toList() ??
                                      [];
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    visualDensity: const VisualDensity(
                                      horizontal: -2.0,
                                      vertical: -4.0,
                                    ),
                                    title: CommonText(
                                      text:
                                          '(${suggestion.aCCCD ?? ''}) ${suggestion.aCCNAME ?? ''}',
                                    ),
                                  );
                                },
                                onSelected: (selectedItem) {
                                  controller.selectedDropdownParty.value =
                                      selectedItem;
                                  controller.selectedDropdownPartyName.value =
                                      selectedItem.aCCNAME ?? '';
                                  controller.selectedDropdownPartyCode.value =
                                      selectedItem.aCCCD ?? '';
                                  controller.partyController.value.text =
                                      selectedItem.aCCNAME ?? '';
                                  controller.partyFocus.unfocus();
                                  controller.fetchSales();
                                },
                                onClear: () {
                                  controller.partyController.value.clear();
                                  controller.partyFocus.unfocus();
                                  controller.selectedDropdownParty.value = null;
                                  controller.selectedDropdownPartyName.value =
                                      '';
                                  controller.selectedDropdownPartyCode.value =
                                      '';
                                  Utils.closeKeyboard(Get.context!);

                                  controller.fetchSales();
                                },
                              ),
                    ),

                    CommonInputField(
                      textInputAction: TextInputAction.done,
                      textEditingController:
                          controller.searchGroupController.value,
                      prifixIcon: Icons.search,
                      suffixIcon:
                          controller.searchQuery.value.isNotEmpty
                              ? Icons.close
                              : null,
                      lableText:
                          "Search here.. (i.e, Bill no,Vouch no,Party cd)",
                      maxLength: 40,
                      focusNode: controller.searchGroupFocus,
                      onChanged: (text) {
                        controller.searchQuery.value = text;
                        controller.filterData();
                      },
                      onSuffixClick: () {
                        controller.searchGroupController.value.clear();
                        Utils.closeKeyboard(context);
                        controller.searchQuery.value = '';
                        controller.filterData();
                      },
                    ),
                    Expanded(child: _getView(context)),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Obx(() {
            final cartData = controller.mainList.value.sales ?? [];

            if (cartData.isEmpty) return const SizedBox.shrink();

            final totalNetAmount = cartData.fold<double>(
              0,
              (sum, item) =>
                  sum +
                  (double.tryParse(item.nETAMT?.toString() ?? '0') ?? 0.0),
            );

            // final Set<String> seenBillNumbers = {};
            //
            // final totalNetAmount = cartData.fold<double>(
            //   0,
            //       (sum, item) {
            //     final billNo = item.bILLNO?.toString() ?? '';
            //     final netAmt = double.tryParse(item.nETAMT?.toString() ?? '0') ?? 0.0;
            //
            //     if (!seenBillNumbers.contains(billNo)) {
            //       seenBillNumbers.add(billNo);
            //       return sum + netAmt;
            //     } else {
            //       return sum; // Already counted this billNo
            //     }
            //   },
            // );

            return Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
              elevation: 1,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10.0,
                    bottom: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CommonText(
                              text:
                                  'Total Bill Amt: ${Utils.formatIndianAmount(totalNetAmount)}',
                              fontWeight: AppFontWeight.w600,
                              fontSize: AppDimensions.fontSizeRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _getView(BuildContext context) {
    return Utils.buildConditionalView(
      isLoading: controller.isLoading.value,
      list: controller.mainList.value.sales ?? [],
      searchQuery: controller.searchQuery.value,
      errorMessage: controller.errorMsg.value,
      onSuccess: (context) => _listUI(context),
    );
  }

  Widget _listUI(BuildContext context) {
    return ListView.builder(
      itemCount: controller.mainList.value.sales!.length,
      itemBuilder: (context, index) {
        final product = controller.mainList.value.sales![index];

        return Card(
          //margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Item details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: 'Bill No: ${product.bILLNO ?? ''}'),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              CommonText(
                                text: 'Book: ${product.bOOKCD ?? '-'}',
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              CommonText(
                                text: 'Date: ${product.vOUCHDT ?? '-'}',
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible:
                              controller.readRight.value ||
                              controller.writeRights.value ||
                              controller.updateRights.value ||
                              controller.deleteRights.value ||
                              controller.printRights.value,
                          child: PopupMenuButton<String>(
                            onSelected: (value) async {
                              switch (value) {
                                case 'edit':
                                  // Get.delete<AddGeneralSalesController>();
                                  // if (kIsWeb) {
                                  //   Utils.navigateIfAuthorizedViewAdd(
                                  //       moduleNo: controller.moduleNo.value,
                                  //       routeName:
                                  //           AppRoutes.generalSalesAddRoute,
                                  //       extraArguments: {
                                  //         "ModuleNo": controller.moduleNo.value,
                                  //         "SalesID": product.sALESID.toString(),
                                  //         "PartyCD": product.pARTYCD.toString(),
                                  //         "SalesData": product,
                                  //         "Type": "U",
                                  //       });
                                  // } else {
                                  //   Utils.navigateIfAuthorizedViewAdd(
                                  //       moduleNo: controller.moduleNo.value,
                                  //       routeName:
                                  //           AppRoutes.generalSalesAddRoute,
                                  //       extraArguments: {
                                  //         "ModuleNo": controller.moduleNo.value,
                                  //         "SalesID": product.sALESID.toString(),
                                  //         "PartyCD": product.pARTYCD.toString(),
                                  //         "SalesData": product,
                                  //         "Type": "U",
                                  //       });
                                  // }
                                  Get.toNamed(
                                    AppRoutes.generalSalesAddRoute,
                                    arguments: {
                                      "ModuleNo": controller.moduleNo.value,
                                      "SalesID": product.sALESID.toString(),
                                      "PartyCD": product.pARTYCD.toString(),
                                      "SalesData": product,
                                      "Type": "U",
                                    },
                                  );
                                case 'delete':
                                  Get.dialog(
                                    CommonMaterialDialog(
                                      title: 'Delete Confirmation',
                                      message:
                                          'Are you sure you want to delete this sales: ${controller.mainList.value.sales![index].bILLNO}?',
                                      yesButtonText: 'Yes',
                                      noButtonText: 'No',
                                      onConfirm: () {
                                        controller.deleteSales(
                                          product.sALESID!.toString(),
                                        );
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                      isLoading: controller.isDeleteLoading,
                                    ),
                                  );
                                case 'view_details':
                                  controller.fetchExpandPaymentWithVouch(
                                    product.sALESID.toString(),
                                  );
                                case 'duplicate':
                                  Get.toNamed(
                                    AppRoutes.generalSalesAddRoute,
                                    arguments: {
                                      "ModuleNo": controller.moduleNo.value,
                                      "SalesID": product.sALESID.toString(),
                                      "PartyCD": product.pARTYCD.toString(),
                                      "SalesData": product,
                                      "Type": "D",
                                    },
                                  );
                              }
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.more_vert,
                                color: Theme.of(context).colorScheme.primary,
                                size: 22,
                              ),
                            ),
                            offset: const Offset(0, 40),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.2),
                              ),
                            ),
                            itemBuilder:
                                (context) => [
                                  if (controller.updateRights.value &&
                                      product.mODULENO == '201')
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'edit',
                                      icon: Icons.edit_outlined,
                                      iconColor:
                                          Theme.of(context).colorScheme.primary,
                                      // Adapts to theme
                                      title: 'Edit',
                                    ),
                                  if (controller.deleteRights.value)
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'delete',
                                      icon: Icons.delete_outline,
                                      iconColor:
                                          Theme.of(context).colorScheme.error,
                                      // Red in light/dark
                                      title: 'Delete',
                                    ),
                                  if (controller.printRights.value)
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'create_pdf',
                                      icon: Icons.picture_as_pdf_outlined,
                                      iconColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                      // Or use .tertiary
                                      title: 'Create PDF',
                                    ),
                                  if (controller.printRights.value)
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'invoice_print',
                                      icon: Icons.print,
                                      iconColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withValues(alpha: 0.5),
                                      // Adapts
                                      title: 'Print',
                                    ),
                                  if (controller.readRight.value)
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'view_details',
                                      icon: Icons.visibility_outlined,
                                      iconColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.8),
                                      // Subtle
                                      title: 'View Details',
                                    ),
                                  if (controller.writeRights.value &&
                                      product.mODULENO == '201')
                                    Utils.buildMenuItem(
                                      context: context,
                                      value: 'duplicate',
                                      icon: Icons.content_copy_outlined,
                                      iconColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                      // Adapts
                                      title: 'Duplicate',
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (product.aCCNAME != null)
                  Row(
                    children: [
                      Expanded(
                        child: CommonText(
                          text: product.aCCNAME!,
                          maxLine: 2,
                          textAlign: TextAlign.start,
                          fontSize: AppDimensions.fontSizeMedium,
                          fontWeight: AppFontWeight.w700,
                        ),
                      ),
                      // Price
                      CommonText(
                        text: '₹ ${product.nETAMT ?? '0.00'}',
                        fontSize: AppDimensions.fontSizeRegular,
                        fontWeight: AppFontWeight.w700,
                      ),
                    ],
                  ),
                Visibility(
                  visible: false,
                  child: Row(
                    children: [
                      if (product.mODULENO == '201')
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CommonTextButton(
                              title: 'Edit',
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.generalSalesAddRoute,
                                  arguments: {
                                    "ModuleNo": controller.moduleNo.value,
                                    "SalesID": product.sALESID.toString(),
                                    // "BillNo": product.bILLNO.toString(),
                                    // "BookCD": product.bOOKCD.toString(),
                                    // "VouchDt": product.vOUCHDT.toString(),
                                    "PartyCD": product.pARTYCD.toString(),
                                    // "AccName": product.aCCNAME.toString(),
                                    'SalesData': product,
                                    "Type": "U",
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      if (product.mODULENO == '201') const SizedBox(width: 10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CommonTextButton(
                            title: 'View Details',
                            onPressed: () {
                              controller.fetchExpandPaymentWithVouch(
                                product.sALESID.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
