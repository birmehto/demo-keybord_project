import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:demo/api/dio_client.dart';
import 'package:demo/app/app_colors.dart';
import 'package:demo/app/app_permission.dart';
import 'package:demo/app/app_routes.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/app/app_url.dart';
import 'package:demo/models/firm_response.dart';
import 'package:demo/utility/constants.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/network.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isDisable = false.obs;
  var isDropdownLoading = false.obs;
  var isTextFieldDisable = false.obs;

  late Rx<TextEditingController> userNameController;
  late Rx<TextEditingController> passwordController;
  late FocusNode userNameFocus;
  late FocusNode passWordFocus;
  var isObscured = true.obs;

  var isRememberCheck = false.obs;
  var strIdentifier = 'Unknown'.obs;
  var tempToken = ''.obs;
  var token = ''.obs;

  var firmDropdownList = FirmResponse().obs;
  var selectedDropdownFirm = Rx<FirmModel?>(null);
  var selectedDropdownFirmName = ''.obs;
  var selectedDropdownSyncID = ''.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // Initialize controllers and focus nodes
    userNameController = TextEditingController().obs;
    passwordController = TextEditingController().obs;
    userNameFocus = FocusNode();
    passWordFocus = FocusNode();

    PreferenceUtils.setAuthToken('');

    await AppPermission.checkAndRequestAllPermissions(Get.context!);

    await deviceID();

    if (PreferenceUtils.getIsRemember()) {
      isRememberCheck.value = PreferenceUtils.getIsRemember();
      userNameController.value.text = PreferenceUtils.getLoginUserName();
      passwordController.value.text = PreferenceUtils.getLoginUserPassword();
    }
  }

  @override
  void onClose() {
    // Dispose controllers and focus nodes
    userNameController.value.dispose();
    passwordController.value.dispose();
    // userNameFocus.dispose();
    // passWordFocus.dispose();

    // Optional: close the Rx
    userNameController.close();
    passwordController.close();

    super.onClose();
  }

  void toggleObscured() {
    isObscured.value = !isObscured.value;
  }

  Future<void> deviceID() async {
    String? identifier;
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        identifier = androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        identifier = iosInfo.identifierForVendor;
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfo.windowsInfo;
        identifier = windowsInfo.deviceId;
      } else {
        identifier = "Unsupported Platform";
      }
    } catch (e) {
      identifier = 'Failed to get Unique Identifier';
    }

    strIdentifier.value = identifier!;

    PreferenceUtils.setDeviceID(strIdentifier.value);

    if (kDebugMode) {
      print("Uniq ID : ${strIdentifier.value}");
    }
  }

  void tempLoginValidationWithAPI() {
    if (userNameController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter user code.');
    } else if (passwordController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter password.');
    } else {
      tempLogin(userNameController.value.text, passwordController.value.text);
    }
  }

  Future<void> tempLogin(String username, String password) async {
    try {
      isLoading(true);
      isDisable(true);

      if (await Network.isConnected()) {
        final Map<String, dynamic> param = {
          'userName': username,
          'password': password,
        };

        final response = await DioClient().post(AppURL.loginURL, param);

        if (response.statusCode == 200 || response.statusCode == 201) {
          isTextFieldDisable.value = true;

          Utils.closeKeyboard(Get.context!);
          tempToken.value = response.data['tempToken'];

          PreferenceUtils.setAuthToken('Bearer ${tempToken.value}');
          PreferenceUtils.setLoginUserCode(response.data['data']['USER_CD']);
          PreferenceUtils.setLoginUserName(response.data['data']['USER_NAME']);
          PreferenceUtils.setLoginCustID(response.data['data']['CUST_ID']);
          PreferenceUtils.setLoginUserRole(response.data['data']['USER_TYPE']);
          PreferenceUtils.setLoginUserPassword(password);
          PreferenceUtils.setLoginMobileNO(response.data['data']['MOBILENO']);

          if (tempToken.value.isNotEmpty) {
            fetchFirmDropdown();
          }
        } else {
          log('Error:>>> ${response.statusCode}');
          errorMsg.value = response.data['message'];

          AppSnackBar.showGetXCustomSnackBar(message: response.data['message']);
        }
      } else {
        errorMsg.value = Constants.networkMsg;
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      log('Error:>>> $e');

      Utils.handleException(e);
    } finally {
      isLoading(false);
      isDisable(false);
    }
  }

  Future<void> fetchFirmDropdown() async {
    if (await Network.isConnected()) {
      try {
        isDropdownLoading(true);

        final response = await DioClient().getQueryParam(AppURL.getFirmURL);

        firmDropdownList.value = FirmResponse.fromJson(response);

        if (firmDropdownList.value.data!.isNotEmpty) {
          final firstFirm = firmDropdownList.value.data!.first;
          selectedDropdownFirm.value = firstFirm;
          selectedDropdownFirmName.value = firstFirm.fIRMNAME.toString();
          selectedDropdownSyncID.value = firstFirm.sYNCID.toString();

          //PreferenceUtils.setUserCD(firstFirm.userCD);
          PreferenceUtils.setFirmID(firstFirm.fIRMID.toString());
          PreferenceUtils.setCustID(firstFirm.cUSTID.toString());
          PreferenceUtils.setSyncID(selectedDropdownSyncID.value);
          PreferenceUtils.setFirmName(firstFirm.fIRMNAME.toString());
          PreferenceUtils.setFirmGSTType(firstFirm.gSTTYPE.toString());
          PreferenceUtils.setFirmStateCD(firstFirm.sTATECODE.toString());
          PreferenceUtils.setFirmStateName(firstFirm.sTATE.toString());

          Utils.storeSelectedFirmObject(firstFirm);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'No Firms Available');
        }
      } catch (e) {
        Utils.handleException(e);
      } finally {
        isDropdownLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  void finalLoginValidationWithAPI() {
    if (selectedDropdownFirmName.value.isEmpty &&
        selectedDropdownSyncID.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select firm.');
    } else {
      finalLogin(selectedDropdownSyncID.value);
    }
  }

  Future<void> finalLogin(String dropdownId) async {
    try {
      isLoading(true);
      isDisable(true);

      if (await Network.isConnected()) {
        final Map<String, dynamic> param = {'syncId': dropdownId};

        final response = await DioClient().post(AppURL.changeFirmURL, param);

        if (response.statusCode == 200) {
          if (response.data['message'] == 'Login Successful') {
            Utils.closeKeyboard(Get.context!);

            final String role = response.data['role'];
            final String token = response.data['token'];
            final String category = response.data['category'] ?? '';

            PreferenceUtils.setLoginUserRole(role);
            PreferenceUtils.setAuthToken('Bearer $token');
            PreferenceUtils.setCategory(category);
            PreferenceUtils.setIsLogin(true).then((_) {
              Get.offAllNamed(AppRoutes.salesRoute);
              AppSnackBar.showGetXCustomSnackBar(
                message: response.data['message'],
                backgroundColor: AppColors.colorGreen,
              );
            });
          } else {
            // Show failure message based on the message from the response
            AppSnackBar.showGetXCustomSnackBar(
              message: response.data['message'],
            );
          }
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
      isLoading(false);
      isDisable(false);
    }
  }
}
