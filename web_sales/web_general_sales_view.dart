import 'package:demo/app/app_dimensions.dart';
import 'package:demo/app/app_routes.dart';
import 'package:demo/models/party_response.dart';
import 'package:demo/screens/transaction_management/web_sales/web_general_sales_controller.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_app_bar.dart';
import 'package:demo/widgets/common_filled_button_with_icon.dart';
import 'package:demo/widgets/common_input_field.dart';
import 'package:demo/widgets/common_search_dropdown.dart';
import 'package:demo/widgets/common_summary_box.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:demo/widgets/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WebGeneralSalesView extends GetView<WebGeneralSalesController> {
  const WebGeneralSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Sales'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderSection(context),
            const SizedBox(height: 10),
            Expanded(child: controller.buildSalesGrid(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomSection(context),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
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
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDiscountAndPaymentRow(context),
              const Divider(thickness: 1),
              _buildSummaryAndActionsRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountAndPaymentRow(BuildContext context) {
    return Row(
      children: [
        const CommonText(text: 'Discount : '),
        const SizedBox(width: 10),
        _buildDiscountPercentField(),
        const SizedBox(width: 10),
        _buildDiscountAmountField(),
        const SizedBox(width: 10),
        _buildPaymentModeDropdown(context),
        const SizedBox(width: 10),
        _buildCashReceivedField(),
        _buildCashReceivedSpacer(),
        _buildRemarksField(),
      ],
    );
  }

  Widget _buildDiscountPercentField() {
    return Expanded(
      child: Obx(
        () => CommonInputField(
          textInputAction: TextInputAction.next,
          lableText: "Dis %",
          textEditingController: controller.discountPerController.value,
          textInputType: const TextInputType.numberWithOptions(decimal: true),
          focusNode: controller.discountPerFocus,
          onChanged: controller.updateDiscountFromPercent,
          onSubmitted: (_) => _handleFieldSubmission(
            controller.discountPerFocus,
            controller.discountAmtFocus,
          ),
          suffixIcon: Icons.percent,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(Utils.filterPatternWithDecimal0x2),
            ),
          ],
        ),
      ).paddingOnly(top: 10),
    );
  }

  Widget _buildDiscountAmountField() {
    return Expanded(
      child: Obx(
        () => CommonInputField(
          lableText: "Dis Amt",
          textInputAction: TextInputAction.next,
          textEditingController: controller.discountAmtController.value,
          textInputType: const TextInputType.numberWithOptions(decimal: true),
          focusNode: controller.discountAmtFocus,
          suffixIcon: Icons.currency_rupee,
          onChanged: controller.updateDiscountFromAmount,
          onSubmitted: (_) => _handleDiscountAmountSubmit(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(Utils.filterPatternWithDecimal12x2),
            ),
          ],
        ),
      ).paddingOnly(top: 10),
    );
  }

  Widget _buildPaymentModeDropdown(BuildContext context) {
    return Expanded(
      child: Obx(
        () => DropdownMenu<String>(
          showTrailingIcon: false,
          initialSelection: controller.selectedPaymentMethod.value,
          focusNode: controller.paymentModeFocus,
          label: const Text('Mode of Payment'),
          hintText: 'Select Mode of Payment',
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          onSelected: (value) {
            if (value != null) {
              controller.selectedPaymentMethod.value = value;
              _handlePaymentMethodChange(value);
            }
          },
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'Cash', label: 'Cash'),
            DropdownMenuEntry(value: 'Bank', label: 'Bank'),
            DropdownMenuEntry(value: 'Card', label: 'Card'),
            DropdownMenuEntry(value: 'UPI', label: 'UPI'),
            DropdownMenuEntry(value: 'Credit', label: 'Credit'),
          ],
        ).paddingOnly(top: 12),
      ),
    );
  }

  Widget _buildCashReceivedField() {
    return Obx(() {
      return controller.selectedPaymentMethod.value == 'Cash'
          ? Expanded(
              child: CommonInputField(
                textInputAction: TextInputAction.next,
                textEditingController: controller.cashReceivedController.value,
                lableText: "Cash Received",
                maxLength: 15,
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(Utils.filterPatternWithDecimal12x2),
                  ),
                ],
                focusNode: controller.cashReceivedFocus,
                onSubmitted: (_) => _handleFieldSubmission(
                  controller.cashReceivedFocus,
                  controller.narrationFocus,
                ),
              ).paddingOnly(top: 10),
            )
          : const SizedBox.shrink();
    });
  }

  Widget _buildCashReceivedSpacer() {
    return Obx(() {
      return controller.selectedPaymentMethod.value == 'Cash'
          ? const SizedBox(width: 10)
          : const SizedBox.shrink();
    });
  }

  Widget _buildRemarksField() {
    return Expanded(
      child: Obx(
        () => CommonInputField(
          textInputAction: TextInputAction.done,
          textEditingController: controller.narrationController.value,
          lableText: "Remarks",
          maxLength: 255,
          focusNode: controller.narrationFocus,
        ),
      ).paddingOnly(top: 10),
    );
  }

  Widget _buildSummaryAndActionsRow(BuildContext context) {
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
                    onPressed: () => _handleSubmitAndPrint(),
                  ),
                ),
                Obx(
                  () => CommonFilledButtonWithIcon(
                    label: "Submit",
                    icon: Icons.send,
                    onPressed: () => _handleSubmit(),
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
        _buildDateField(context),
        const SizedBox(width: 10),
        _buildPartyDropdown(),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller.dtController.value,
        focusNode: controller.dtFocus,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Date',
          hint: Text('DD/MM/YY'),
          suffixIcon: Icon(Icons.calendar_today),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        onFieldSubmitted: (_) =>
            _handleFieldSubmission(controller.dtFocus, controller.partyFocus),
        onTap: () {
          // Handle date picker if needed
          // You can add date picker functionality here
        },
      ),
    );
  }

  Widget _buildPartyDropdown() {
    return Expanded(
      child: CommonSearchableDropdown2<PartyModel>(  // removed circuller progress
        focusNode: controller.partyFocus,
        controller: controller.partyController.value,
        labelText: 'Party Name',
        suggestionsCallback: _getPartySuggestions,
        itemBuilder: _buildPartyItem,
        onSuggestionSelected: _handlePartySelection,
        onClear: _handlePartyClear,
      ),
    );
  }
  // Widget _buildPartyDropdown() {
  //   return Expanded(
  //     child: Obx(
  //       () => controller.isDropdownPartyLoading.isTrue
  //           ? Center(child: Utils.commonCircularProgress()).paddingOnly(top: 3)
  //           : CommonSearchableDropdown2<PartyModel>(
  //               focusNode: controller.partyFocus,
  //               controller: controller.partyController.value,
  //               labelText: 'Party Name',
  //               suggestionsCallback: _getPartySuggestions,
  //               itemBuilder: _buildPartyItem,
  //               onSuggestionSelected: _handlePartySelection,
  //               onClear: _handlePartyClear,
  //             ),
  //     ),
  //   );
  // }

  // Helper methods for focus management
  void _focusNext(FocusNode nextFocus) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nextFocus.canRequestFocus && Get.context != null) {
        FocusScope.of(Get.context!).requestFocus(nextFocus);
      }
    });
  }

  void _unfocusAndFocusNext(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    _focusNext(nextFocus);
  }

  void _handleFieldSubmission(FocusNode currentFocus, FocusNode? nextFocus) {
    if (nextFocus != null) {
      _unfocusAndFocusNext(currentFocus, nextFocus);
    } else {
      currentFocus.unfocus();
    }
  }

  void _handleDiscountAmountSubmit() {
    // Always focus payment mode first, then let payment mode handle cash field focus
    _handleFieldSubmission(
      controller.discountAmtFocus,
      controller.paymentModeFocus,
    );
  }

  void _handlePaymentMethodChange(String value) {
    controller.selectedPaymentMethod.value = value;

    if (value != 'Cash') {
      controller.cashReceivedController.value.clear();
      // Focus remarks field if not Cash
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNext(controller.narrationFocus);
      });
    } else {
      controller.cashReceivedController.value.text = controller.netAmount.value
          .toString()
          .trim();
      // Auto-focus cash received field when Cash is selected
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNext(controller.cashReceivedFocus);
      });
    }
  }

  // Party dropdown helper methods
  Future<List<PartyModel>> _getPartySuggestions(String pattern) async {
    final search = pattern.toLowerCase().replaceAll(' ', '');

    final result = controller.partyList.value.data?.where((item) {
      final accName = item.aCCNAME?.toLowerCase().replaceAll(' ', '') ?? "";
      final accCd = item.aCCCD?.toLowerCase().replaceAll(' ', '') ?? "";
      final mobile = item.mobile1?.toLowerCase().replaceAll(' ', '') ?? "";

      return accName.contains(search) ||
          accCd.contains(search) ||
          mobile.contains(search);
    }).toList();

    // Return not found indicator if no results
    if (result == null || result.isEmpty) {
      return [PartyModel(aCCNAME: "__not_found__")];
    }

    return result;
  }

  Widget _buildPartyItem(BuildContext context, PartyModel suggestion) {
    if (suggestion.aCCNAME == "__not_found__") {
      return _buildNotFoundItem();
    }

    return ListTile(
      visualDensity: const VisualDensity(horizontal: -2.0, vertical: -4.0),
      title: CommonText(text: suggestion.aCCNAME ?? ""),
    );
  }

  Widget _buildNotFoundItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
              onPressed: _handleCreateNewParty,
            ),
          ),
        ],
      ),
    );
  }

  void _handleCreateNewParty() {
    try {
      controller.partyController.value.clear();
      controller.partyFocus.unfocus();
      controller.unfocusAllFields();

      Get.toNamed(
            AppRoutes.addCustomerRoute,
            arguments: {
              "AccCD": "",
              "GroupCd": '83',
              "Type": "A",
              "StateCD": PreferenceUtils.getFirmStateCD(),
            },
          )
          ?.then((value) {
            if (value != null && value is Map && value['ACC_CD'] != null) {
              controller.insertACCCd.value = value['ACC_CD'].toString();

              // Show success message
              Get.snackbar(
                'Success',
                'New party created successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.8),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            }
            controller.fetchParty();
          })
          .catchError((error) {
            debugPrint('Error creating new party: $error');
            Get.snackbar(
              'Error',
              'Failed to create new party. Please try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
          });
    } catch (e) {
      debugPrint('Error in _handleCreateNewParty: $e');
    }
  }

  void _handlePartySelection(PartyModel selectedItem) {
    controller.selectedDropdownParty.value = selectedItem;
    controller.selectedDropdownPartyName.value = selectedItem.aCCNAME ?? '';
    controller.selectedDropdownPartyCode.value = selectedItem.aCCCD ?? '';
    controller.partyController.value.text = selectedItem.aCCNAME ?? '';

    controller.selectedDropdownStateCD.value = selectedItem.sTATECODE
        .toString();
    controller.selectedDropdownStateName.value = selectedItem.sTATE.toString();
    controller.selectedDropdownOutState.value = selectedItem.oUTSTATE
        .toString();

    // Unfocus party field and focus first product field
    _handleFieldSubmission(
      controller.partyFocus,
      controller.rows.isNotEmpty ? controller.rows.first.productFocused : null,
    );
  }

  void _handlePartyClear() {
    try {
      controller.partyController.value.clear();
      controller.selectedDropdownParty.value = null;
      controller.selectedDropdownPartyName.value = '';
      controller.selectedDropdownPartyCode.value = '';
      controller.selectedDropdownStateCD.value = '';
      controller.selectedDropdownStateName.value = '';
      controller.selectedDropdownOutState.value = '';

      // Unfocus and close keyboard
      controller.partyFocus.unfocus();
      controller.unfocusAllFields();

      // Show feedback to user
      Get.snackbar(
        'Cleared',
        'Party selection cleared',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      debugPrint('Error clearing party: $e');
    }
  }

  // Submit handlers
  Future<void> _handleSubmit() async {
    // Unfocus all fields before validation
    controller.unfocusAllFields();

    try {
      if (controller.validation()) {
        controller.isBottomLoading.value = true;
        await controller.insertUpdateSales("A");

        // Show success message
        Get.snackbar(
          'Success',
          'Sales record saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      // Enhanced error handling with user feedback
      debugPrint('Submit error: $e');
      Get.snackbar(
        'Error',
        'Failed to save sales record. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      controller.isBottomLoading.value = false;
    }
  }

  Future<void> _handleSubmitAndPrint() async {
    // Unfocus all fields before validation
    controller.unfocusAllFields();

    try {
      if (controller.validation()) {
        controller.isBottomLoading.value = true;
        await controller.insertUpdateSales("A");

        // Show success message with print indication
        Get.snackbar(
          'Success',
          'Sales record saved successfully. Preparing for print...',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Add print functionality here if needed
        await _handlePrintDocument();
      }
    } catch (e) {
      // Enhanced error handling with user feedback
      debugPrint('Submit and print error: $e');
      Get.snackbar(
        'Error',
        'Failed to save or print sales record. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      controller.isBottomLoading.value = false;
    }
  }

  Future<void> _handlePrintDocument() async {
    try {
      // Placeholder for print functionality
      // This can be implemented based on your printing requirements
      await Future.delayed(const Duration(milliseconds: 500));

      Get.snackbar(
        'Print',
        'Document sent to printer successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Print error: $e');
      Get.snackbar(
        'Print Error',
        'Failed to print document. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
