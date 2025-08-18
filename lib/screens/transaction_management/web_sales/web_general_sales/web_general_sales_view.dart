import 'package:demo/app/app_date_format.dart';
import 'package:demo/app/app_dimensions.dart';
import 'package:demo/app/app_routes.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/screens/globalshortcutmanager.dart';
import 'package:demo/screens/transaction_management/web_sales/web_general_sales/web_general_sales_controller.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_app_bar.dart';
import 'package:demo/widgets/common_date_picker.dart';
import 'package:demo/widgets/common_dropdown.dart';
import 'package:demo/widgets/common_filled_button_with_icon.dart';
import 'package:demo/widgets/common_input_field.dart';
import 'package:demo/widgets/common_summary_box.dart';
import 'package:demo/widgets/common_serch_dropdown.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:demo/widgets/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
                            nextFocusNode: controller.discountAmtFocus,
                            validator: controller.getFieldValidator(
                              'discountPercent',
                            ),
                            onValidationError:
                                controller.onFieldValidationError,
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
                            previousFocusNode: controller.discountPerFocus,
                            nextFocusNode:
                                controller.selectedPaymentMethod.value == 'Cash'
                                    ? controller.cashReceivedFocus
                                    : controller.narrationFocus,
                            validator: controller.getFieldValidator(
                              'discountAmount',
                            ),
                            onValidationError:
                                controller.onFieldValidationError,
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
                              // Use the enhanced payment method selection handler
                              controller.handlePaymentMethodSelection(value);
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
                                previousFocusNode: controller.discountAmtFocus,
                                nextFocusNode: controller.narrationFocus,
                                validator: controller.getFieldValidator(
                                  'cashReceived',
                                ),
                                onValidationError:
                                    controller.onFieldValidationError,
                                onChanged: controller.onCashReceivedChanged,
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
                            previousFocusNode:
                                controller.selectedPaymentMethod.value == 'Cash'
                                    ? controller.cashReceivedFocus
                                    : controller.discountAmtFocus,
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
            focusNode: controller.dtFocus,
            onTap: () {
              Utils.closeKeyboard(context);
              AppDatePicker.allDateEnable(
                context,
                controller.dtController.value,
              );
              // Trigger field completion when date is selected
              Future.delayed(const Duration(milliseconds: 100), () {
                if (controller.dtController.value.text.isNotEmpty) {
                  controller.onFieldComplete(
                    'date',
                    controller.dtController.value.text,
                  );
                }
              });
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
                      labelText: 'Party Name',
                      // Enhanced focus management parameters
                      focusNode: controller.partyFocus,
                      nextFocusNode:
                          controller.rows.isNotEmpty
                              ? controller.rows.first.productFocused
                              : null,
                      previousFocusNode: controller.dtFocus,
                      autoFocus: false,
                      enableKeyboardNavigation: true,
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
                        // Use the new party selection handler with auto-focus
                        controller.onPartySelected(selectedItem);
                      },
                      onSelectionComplete: (selectedItem) {
                        // This will be called after onSuggestionSelected
                        // The auto-focus to next field is handled by the enhanced dropdown
                      },
                      onNotFound: (query) {
                        // Handle "not found" scenario
                        debugPrint('Party not found for query: $query');
                      },
                      onClear: () {
                        controller.partyController.value.clear();
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
