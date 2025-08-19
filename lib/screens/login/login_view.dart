import 'package:demo/models/firm_response.dart';
import 'package:demo/screens/login/login_controller.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_button.dart';
import 'package:demo/widgets/common_input_field.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/app_dimensions.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_strings.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 75),
                child: _getView(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: FlutterLogo(size: 100)).paddingOnly(bottom: 30),
        CommonText(
          text: AppString.login,
          fontSize: AppDimensions.fontSizeExtraLarge,
          fontWeight: AppFontWeight.w600,
        ),
        CommonInputField(
          textEditingController: controller.userNameController.value,
          lableText: "User code",
          maxLength: 10,
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          isEnable: controller.isTextFieldDisable.value ? false : true,
          focusNode: controller.userNameFocus,
          nextFocusNode: controller.passWordFocus,
        ),
        CommonInputField(
          suffixIcon:
              controller.isObscured.value
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
          isEnable: controller.isTextFieldDisable.value ? false : true,
          onSuffixClick: () => controller.toggleObscured(),
          textInputAction: TextInputAction.done,
          textEditingController: controller.passwordController.value,
          lableText: "Password",
          // isPasswordCap: true,
          // textCapitalization: TextCapitalization.none,
          focusNode: controller.passWordFocus,
          isPassword: controller.isObscured.value ? true : false,
        ),
        controller.isDropdownLoading.isTrue
            ? Center(
              child: Utils.commonCircularProgress(),
            ).paddingOnly(top: 10, bottom: 10)
            : Visibility(
              visible: controller.selectedDropdownSyncID.isNotEmpty,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(Get.context!).colorScheme.primary,
                    ),
                  ),
                ),
                child: DropdownButton<FirmModel?>(
                  value: controller.selectedDropdownFirm.value,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  underline: const SizedBox(),
                  hint: CommonText(
                    text: 'Select Firm',
                    fontWeight: AppFontWeight.w400,
                    fontSize: 16,
                  ),
                  items:
                      controller.firmDropdownList.value.data?.map((
                        FirmModel leave,
                      ) {
                        return DropdownMenuItem<FirmModel>(
                          value: leave,
                          child: CommonText(
                            text: leave.fIRMNAME ?? "N/A",
                            fontSize: 16,
                            fontWeight: AppFontWeight.w400,
                          ),
                        );
                      }).toList(),
                  //menuMaxHeight: 250,
                  onChanged: (FirmModel? newValue) {
                    if (newValue != null &&
                        controller.selectedDropdownSyncID.value !=
                            newValue.sYNCID.toString()) {
                      controller.selectedDropdownFirm.value = newValue;
                      controller.selectedDropdownSyncID.value =
                          newValue.sYNCID.toString();

                      //PreferenceUtils.setUserCD(newValue.userCD.toString());
                      PreferenceUtils.setFirmID(newValue.fIRMID.toString());
                      PreferenceUtils.setCustID(newValue.cUSTID.toString());
                      PreferenceUtils.setSyncID(
                        controller.selectedDropdownSyncID.value,
                      );
                      PreferenceUtils.setFirmName(newValue.fIRMNAME.toString());
                      PreferenceUtils.setFirmGSTType(
                        newValue.gSTTYPE.toString(),
                      );
                      PreferenceUtils.setFirmStateCD(
                        newValue.sTATECODE.toString(),
                      );
                      PreferenceUtils.setFirmStateName(
                        newValue.sTATE.toString(),
                      );
                    }
                  },
                ),
              ),
            ).paddingOnly(top: 10, bottom: 10),
        Visibility(
          visible: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CheckboxListTile(
                  value: controller.isRememberCheck.value,
                  // Bind to reactive variable
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      controller.isRememberCheck.value = newValue;
                      PreferenceUtils.setIsRemember(
                        controller.isRememberCheck.value,
                      );

                      if (PreferenceUtils.getIsRemember()) {
                        PreferenceUtils.setLoginUserName(
                          controller.userNameController.value.text,
                        );
                        PreferenceUtils.setLoginUserPassword(
                          controller.passwordController.value.text,
                        );
                      } else {
                        PreferenceUtils.setLoginUserName('');
                        PreferenceUtils.setLoginUserPassword('');
                      }
                    }
                  },
                  title: CommonText(
                    text: "Remember Me",
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: -2.0,
                    vertical: -2.0,
                  ),
                  tileColor: Colors.transparent,
                  selectedTileColor: Colors.transparent,
                ),
              ),
              InkWell(
                onTap: () {
                  //Get.toNamed(AppRoutes.forgotPasswordRoute);
                },
                child: CommonText(
                  text: 'Forgot Password?',
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        CommonButton(
          buttonText:
              controller.selectedDropdownSyncID.value.isEmpty
                  ? 'Login'
                  : 'Continue',
          onPressed: () {
            if (controller.selectedDropdownSyncID.value.isEmpty) {
              controller.tempLoginValidationWithAPI();
            } else {
              controller.finalLoginValidationWithAPI();
            }
          },
          isLoading: controller.isLoading.value,
          isDisable: controller.isDisable.value,
        ),
      ],
    );
  }
}
