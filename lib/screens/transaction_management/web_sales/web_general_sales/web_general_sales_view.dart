import 'package:demo_project/app/app_date_format.dart';
import 'package:demo_project/app/app_dimensions.dart';
import 'package:demo_project/app/app_routes.dart';
import 'package:demo_project/models/party_response.dart';
import 'package:demo_project/screens/globalshortcutmanager.dart';
import 'package:demo_project/screens/transaction_management/web_sales/web_general_sales/web_general_sales_controller.dart';
import 'package:demo_project/utility/preference_utils.dart';
import 'package:demo_project/utility/utils.dart';
import 'package:demo_project/widgets/common_app_bar.dart';
import 'package:demo_project/widgets/common_date_picker.dart';
import 'package:demo_project/widgets/common_dropdown.dart';
import 'package:demo_project/widgets/common_filled_button_with_icon.dart';
import 'package:demo_project/widgets/common_input_field.dart';
import 'package:demo_project/widgets/common_summary_box.dart';
import 'package:demo_project/widgets/common_text.dart';
import 'package:demo_project/widgets/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/common_serch_dropdown.dart';

class WebGeneralSalesView extends GetView<WebGeneralSalesController> {
  const WebGeneralSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalShortcutManager(
      onInsert: () {
        if (controller.validation()) {
          controller.insertUpdateSales("A");
        }
      },
      child: Scaffold(
        appBar: const CommonAppBar(title: 'Sales'),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              _buildHeaderSection(context),

              Expanded(
                child: controller.buildSalesGrid(context).paddingOnly(top: 10),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Card(
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const CommonText(text: 'Discount : '),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                          () => CommonInputField(
                            textInputAction: TextInputAction.done,
                            lableText: "Dis %",
                            textEditingController:
                                controller.discountPerController.value,
                            textInputType: TextInputType.number,
                            focusNode: controller.discountPerFocus,
                            onChanged: controller.updateDiscountFromPercent,
                            suffixIcon: Icons.percent,
                          ),
                        ).paddingOnly(top: 10),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                          () => CommonInputField(
                            lableText: "Dis Amt",
                            textInputAction: TextInputAction.done,
                            textEditingController:
                                controller.discountAmtController.value,
                            textInputType: TextInputType.number,
                            focusNode: controller.discountAmtFocus,
                            suffixIcon: Icons.currency_rupee,
                            onChanged: controller.updateDiscountFromAmount,
                          ),
                        ).paddingOnly(top: 10),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                          () => CommonDropdown(
                            labelText: 'Mode of Payment',
                            items: const [
                              'Cash',
                              'Bank',
                              'Card',
                              'UPI',
                              'Credit',
                            ],
                            initialValue:
                                controller.selectedPaymentMethod.value,
                            hint: 'Select Mode of Payment',
                            onChanged: (String value) {
                              controller.selectedPaymentMethod.value = value;

                              if (controller.selectedPaymentMethod.value !=
                                  'Cash') {
                                controller.cashReceivedController.value.clear();
                              } else {
                                controller.cashReceivedController.value.text =
                                    controller.netAmount.value
                                        .toString()
                                        .trim();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(() {
                        return controller.selectedPaymentMethod.value == 'Cash'
                            ? Expanded(
                              child: CommonInputField(
                                textInputAction: TextInputAction.done,
                                textEditingController:
                                    controller.cashReceivedController.value,
                                lableText: "Cash Received",
                                maxLength: 15,
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(Utils.filterPatternWithDecimal12x2),
                                  ),
                                ],
                                focusNode: controller.cashReceivedFocus,
                              ).paddingOnly(top: 10),
                            )
                            : const SizedBox.shrink();
                      }),
                      Obx(() {
                        return controller.selectedPaymentMethod.value == 'Cash'
                            ? const SizedBox(width: 10)
                            : const SizedBox.shrink();
                      }),
                      Expanded(
                        child: Obx(
                          () => CommonInputField(
                            textInputAction: TextInputAction.done,
                            textEditingController:
                                controller.narrationController.value,
                            lableText: "Remarks",
                            maxLength: 255,
                            focusNode: controller.narrationFocus,
                          ),
                        ).paddingOnly(top: 10),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1),
                  buildSummaryAndActionsRow(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryAndActionsRow(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  CommonSummaryBox(
                    title: 'Sub Total',
                    value: Utils.formatIndianAmount(controller.subtotal.value),
                  ),
                  CommonSummaryBox(
                    title: 'Total Disc.',
                    value:
                        '- ${Utils.formatIndianAmount(controller.totalDiscount.value)}',
                  ),
                  CommonSummaryBox(
                    title: 'Total GST',
                    value: Utils.formatIndianAmount(controller.totalGST.value),
                  ),
                  CommonSummaryBox(
                    title: 'Round Off',
                    value:
                        '${controller.roundOff.value >= 0 ? '+' : ''}${Utils.formatIndianAmount(controller.roundOff.value)}',
                  ),
                  CommonSummaryBox(
                    title: 'Net Amt',
                    value: Utils.formatIndianAmount(controller.netAmount.value),
                    isHighlighted: true,
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Visibility(
                  visible: false,
                  child: CommonFilledButtonWithIcon(
                    label: "Submit & Print",
                    icon: Icons.print,
                    onPressed: () async {
                      if (controller.validation()) {
                        await controller.insertUpdateSales("A");
                      } else {
                        throw Exception("Validation failed");
                      }
                    },
                  ),
                ),
                Obx(
                  () => CommonFilledButtonWithIcon(
                    label: "Submit",
                    icon: Icons.send,
                    onPressed: () async {
                      if (controller.validation()) {
                        await controller.insertUpdateSales("A");
                      } else {
                        throw Exception("Validation failed");
                      }
                    },
                    isLoading: controller.isBottomLoading.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonDatePickerInput(
            controller: controller.dtController.value,
            labelText: "Date",
            isEnabled: true,
            onTap: () {
              Utils.closeKeyboard(context);
              AppDatePicker.allDateEnable(
                context,
                controller.dtController.value,
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () =>
                controller.isDropdownPartyLoading.isTrue
                    ? Center(
                      child: Utils.commonCircularProgress(),
                    ).paddingOnly(top: 10)
                    : CommonSearchableDropdown2<PartyModel>(
                      controller: controller.partyController.value,
                     
    
                      // focusNode: controller.partyFocus,
                      labelText: 'Party Name',
                      // maxLength: 11,
                      suggestionsCallback: (pattern) async {
                        final search = pattern.toLowerCase().replaceAll(
                          ' ',
                          '',
                        );
                        //if (search.length < 3) return [];

                        final result =
                            controller.partyList.value.data?.where((item) {
                              final accName =
                                  item.aCCNAME?.toLowerCase().replaceAll(
                                    ' ',
                                    '',
                                  ) ??
                                  "";
                              final accCd =
                                  item.aCCCD?.toLowerCase().replaceAll(
                                    ' ',
                                    '',
                                  ) ??
                                  "";
                              final mobile =
                                  item.mobile1?.toLowerCase().replaceAll(
                                    ' ',
                                    '',
                                  ) ??
                                  "";
                              return accName.contains(search) ||
                                  accCd.contains(search) ||
                                  mobile.contains(search);
                            }).toList();

                        // If empty, return a dummy item with a special flag
                        if (result == null || result.isEmpty) {
                          return [PartyModel(aCCNAME: "__not_found__")];
                        }

                        return result;
                      },
                      itemBuilder: (context, suggestion) {
                        if (suggestion.aCCNAME == "__not_found__") {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: CommonText(
                                    text: "Party not found.",
                                    fontSize: AppDimensions.fontSizeMedium,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 34,
                                  child: CommonTextButton(
                                    title: 'Tap to Create',
                                    onPressed: () {
                                      controller.partyController.value.clear();
                                      controller.partyFocus.unfocus();

                                      Get.toNamed(
                                        AppRoutes.addCustomerRoute,
                                        arguments: {
                                          "AccCD": "",
                                          "GroupCd": '83',
                                          "Type": "A",
                                          "StateCD":
                                              PreferenceUtils.getFirmStateCD(),
                                        },
                                      )?.then((value) {
                                        if (value != null &&
                                            value is Map &&
                                            value['ACC_CD'] != null) {
                                          controller.insertACCCd.value =
                                              value['ACC_CD'].toString();
                                        }
                                        controller.fetchParty();
                                      });

                                      // Get.toNamed(AppRoutes.addAccountRoute,
                                      //     arguments: {
                                      //       "AccCD": "",
                                      //       "Type": "A",
                                      //       "StateCD": PreferenceUtils.getFirmStateCD(),
                                      //     })?.then((value) {
                                      //   if (value != null &&
                                      //       value is Map &&
                                      //       value['ACC_CD'] != null) {
                                      //     controller.insertACCCd.value = value['ACC_CD'].toString();
                                      //   }
                                      //   controller.fetchParty();
                                      // });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: -2.0,
                            vertical: -4.0,
                          ),
                          title: CommonText(text: suggestion.aCCNAME ?? ""),
                        );
                      },
                      onSuggestionSelected: (selectedItem) {
                        controller.selectedDropdownParty.value = selectedItem;
                        controller.selectedDropdownPartyName.value =
                            selectedItem.aCCNAME ?? '';
                        controller.selectedDropdownPartyCode.value =
                            selectedItem.aCCCD ?? '';
                        controller.partyController.value.text =
                            selectedItem.aCCNAME ?? '';
                        controller.partyFocus.unfocus();
                        controller.selectedDropdownStateCD.value =
                            selectedItem.sTATECODE.toString();
                        controller.selectedDropdownStateName.value =
                            selectedItem.sTATE.toString();
                        controller.selectedDropdownOutState.value =
                            selectedItem.oUTSTATE.toString();

                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //     FocusScope.of(context).requestFocus(itemRowModel.productFocused);
                            //   });
                      },
                      onClear: () {
                        controller.partyController.value.clear();
                        controller.partyFocus.unfocus();
                        controller.selectedDropdownParty.value = null;
                        controller.selectedDropdownPartyName.value = '';
                        controller.selectedDropdownPartyCode.value = '';
                        controller.selectedDropdownStateCD.value = '';
                        controller.selectedDropdownStateName.value = '';
                        controller.selectedDropdownOutState.value = '';
                        Utils.closeKeyboard(Get.context!);
                      },
                    ),
          ).paddingOnly(top: 7.5),
        ),
      ],
    );
  }
}
