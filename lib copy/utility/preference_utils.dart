import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  static Future<void> clearAllPreferences() async {
    await _prefsInstance?.clear();
  }

  static Future<void> setFirstTime(bool value) async {
    ArgumentError.checkNotNull(value, Constants.isFirstTime);
    await _prefsInstance!.setBool(Constants.isFirstTime, value);
  }

  static bool isFirstTime() {
    return _prefsInstance?.getBool(Constants.isFirstTime) ?? true;
  }

  static Future<bool> setString(String key, String value) {
    return _prefsInstance!.setString(key, value);
  }

  static String getString(String key) {
    return _prefsInstance?.getString(key) ?? '';
  }

  static bool containsKey(String key) {
    return _prefsInstance?.containsKey(key) ?? false;
  }

  static bool getIsTheme() {
    return _prefsInstance?.getBool(Constants.isThemePref) ?? false;
  }

  static Future<bool> setIsTheme(bool isTheme) {
    ArgumentError.checkNotNull(isTheme, Constants.isThemePref);
    return _prefsInstance!.setBool(Constants.isThemePref, isTheme);
  }

  static String getFCMId() {
    return _prefsInstance?.getString(Constants.fcmIdPref) ?? '';
  }

  static Future<bool> setFCMId(String fcmId) {
    ArgumentError.checkNotNull(fcmId, Constants.fcmIdPref);
    return _prefsInstance!.setString(Constants.fcmIdPref, fcmId);
  }

  static bool getIsLogin() {
    return _prefsInstance?.getBool(Constants.isLoginPref) ?? false;
  }

  static Future<bool> setIsLogin(bool isLogin) {
    ArgumentError.checkNotNull(isLogin, Constants.isLoginPref);
    return _prefsInstance!.setBool(Constants.isLoginPref, isLogin);
  }

  static String getAuthToken() {
    return _prefsInstance?.getString(Constants.authTokenPref) ?? '';
  }

  static Future<bool> setAuthToken(String authToken) {
    ArgumentError.checkNotNull(authToken, Constants.authTokenPref);
    return _prefsInstance!.setString(Constants.authTokenPref, authToken);
  }

  static String getCategory() {
    return _prefsInstance?.getString(Constants.category) ?? '';
  }

  static Future<bool> setCategory(String category) {
    ArgumentError.checkNotNull(category, Constants.category);
    return _prefsInstance!.setString(Constants.category, category);
  }

  static String getDeviceID() {
    return _prefsInstance?.getString(Constants.deviceIDPref) ?? '';
  }

  static Future<bool> setDeviceID(String deviceIDPref) {
    ArgumentError.checkNotNull(deviceIDPref, Constants.deviceIDPref);
    return _prefsInstance!.setString(Constants.deviceIDPref, deviceIDPref);
  }

  static String getLoginUserRole() {
    return _prefsInstance?.getString(Constants.loginUserRolePref) ?? '';
  }

  static Future<bool> setLoginUserRole(String loginUserRole) {
    ArgumentError.checkNotNull(loginUserRole, Constants.loginUserRolePref);
    return _prefsInstance!
        .setString(Constants.loginUserRolePref, loginUserRole);
  }

  static String getLoginUserName() {
    return _prefsInstance?.getString(Constants.loginUserNamePref) ?? '';
  }

  static Future<bool> setLoginUserName(String loginUserNamePref) {
    ArgumentError.checkNotNull(loginUserNamePref, Constants.loginUserNamePref);
    return _prefsInstance!
        .setString(Constants.loginUserNamePref, loginUserNamePref);
  }

  static String getLoginUserPassword() {
    return _prefsInstance?.getString(Constants.loginUserPasswordPref) ?? '';
  }

  static Future<bool> setLoginUserPassword(String loginUserPasswordPref) {
    ArgumentError.checkNotNull(
        loginUserPasswordPref, Constants.loginUserPasswordPref);
    return _prefsInstance!
        .setString(Constants.loginUserPasswordPref, loginUserPasswordPref);
  }

  static String getLoginMobileNO() {
    return _prefsInstance?.getString(Constants.loginMobileNOPref) ?? '';
  }

  static Future<bool> setLoginMobileNO(String loginMobileNOPref) {
    ArgumentError.checkNotNull(loginMobileNOPref, Constants.loginMobileNOPref);
    return _prefsInstance!
        .setString(Constants.loginMobileNOPref, loginMobileNOPref);
  }

  static String getLoginUserCode() {
    return _prefsInstance?.getString(Constants.loginUserCodePref) ?? '';
  }

  static Future<bool> setLoginUserCode(String loginUserCodePref) {
    ArgumentError.checkNotNull(loginUserCodePref, Constants.loginUserCodePref);
    return _prefsInstance!
        .setString(Constants.loginUserCodePref, loginUserCodePref);
  }

  static String getLoginCustID() {
    return _prefsInstance?.getString(Constants.loginCustIDPref) ?? '';
  }

  static Future<bool> setLoginCustID(String loginCustIDPref) {
    ArgumentError.checkNotNull(loginCustIDPref, Constants.loginCustIDPref);
    return _prefsInstance!
        .setString(Constants.loginCustIDPref, loginCustIDPref);
  }

  static bool getIsRemember() {
    return _prefsInstance?.getBool(Constants.isRememberPref) ?? false;
  }

  static Future<bool> setIsRemember(bool isRememberPref) {
    ArgumentError.checkNotNull(isRememberPref, Constants.isRememberPref);
    return _prefsInstance!.setBool(Constants.isRememberPref, isRememberPref);
  }

  static String getUserCD() {
    return _prefsInstance?.getString(Constants.userCodePref) ?? '';
  }

  static Future<bool> setUserCD(String userCodePref) {
    ArgumentError.checkNotNull(userCodePref, Constants.userCodePref);
    return _prefsInstance!.setString(Constants.userCodePref, userCodePref);
  }

  static String getFirmID() {
    return _prefsInstance?.getString(Constants.firmIDPref) ?? '';
  }

  static Future<bool> setFirmID(String firmIDPref) {
    ArgumentError.checkNotNull(firmIDPref, Constants.firmIDPref);
    return _prefsInstance!.setString(Constants.firmIDPref, firmIDPref);
  }

  static String getCustID() {
    return _prefsInstance?.getString(Constants.custIDPref) ?? '';
  }

  static Future<bool> setCustID(String custIDPref) {
    ArgumentError.checkNotNull(custIDPref, Constants.custIDPref);
    return _prefsInstance!.setString(Constants.custIDPref, custIDPref);
  }

  static String getSyncID() {
    return _prefsInstance?.getString(Constants.syncIDPref) ?? '';
  }

  static Future<bool> setSyncID(String syncIDPref) {
    ArgumentError.checkNotNull(syncIDPref, Constants.syncIDPref);
    return _prefsInstance!.setString(Constants.syncIDPref, syncIDPref);
  }

  static String getFirmName() {
    return _prefsInstance?.getString(Constants.firmNamePref) ?? '';
  }

  static Future<bool> setFirmName(String firmNamePref) {
    ArgumentError.checkNotNull(firmNamePref, Constants.firmNamePref);
    return _prefsInstance!.setString(Constants.firmNamePref, firmNamePref);
  }

  static String getFirmGSTType() {
    return _prefsInstance?.getString(Constants.firmGSTTypePref) ?? '';
  }

  static Future<bool> setFirmGSTType(String firmGSTTypePref) {
    ArgumentError.checkNotNull(firmGSTTypePref, Constants.firmGSTTypePref);
    return _prefsInstance!
        .setString(Constants.firmGSTTypePref, firmGSTTypePref);
  }

  static String getFirmStateCD() {
    return _prefsInstance?.getString(Constants.firmStateCDPref) ?? '';
  }

  static Future<bool> setFirmStateCD(String firmStateCDPref) {
    ArgumentError.checkNotNull(firmStateCDPref, Constants.firmStateCDPref);
    return _prefsInstance!
        .setString(Constants.firmStateCDPref, firmStateCDPref);
  }

  static String getFirmStateName() {
    return _prefsInstance?.getString(Constants.firmStateNamePref) ?? '';
  }

  static Future<bool> setFirmStateName(String firmStateNamePref) {
    ArgumentError.checkNotNull(firmStateNamePref, Constants.firmStateNamePref);
    return _prefsInstance!
        .setString(Constants.firmStateNamePref, firmStateNamePref);
  }

  static String getFirmOutState() {
    return _prefsInstance?.getString(Constants.firmOutState) ?? '';
  }

  static Future<bool> setFirmOutState(String firmOutState) {
    ArgumentError.checkNotNull(firmOutState, Constants.firmOutState);
    return _prefsInstance!
        .setString(Constants.firmOutState, firmOutState);
  }

  static String getPartyID() {
    return _prefsInstance?.getString(Constants.partyIDPref) ?? '';
  }

  static Future<bool> setPartyID(String partyIDPref) {
    ArgumentError.checkNotNull(partyIDPref, Constants.partyIDPref);
    return _prefsInstance!.setString(Constants.partyIDPref, partyIDPref);
  }

  static String getPartyName() {
    return _prefsInstance?.getString(Constants.partyNamePref) ?? '';
  }

  static Future<bool> setPartyName(String partyNamePref) {
    ArgumentError.checkNotNull(partyNamePref, Constants.partyNamePref);
    return _prefsInstance!.setString(Constants.partyNamePref, partyNamePref);
  }

  static String getBillPartyCode() {
    return _prefsInstance?.getString(Constants.partyBillIDPref) ?? '';
  }

  static Future<bool> setBillPartyCode(String partyBillIDPref) {
    ArgumentError.checkNotNull(partyBillIDPref, Constants.partyBillIDPref);
    return _prefsInstance!
        .setString(Constants.partyBillIDPref, partyBillIDPref);
  }

  static String getBillPartyName() {
    return _prefsInstance?.getString(Constants.partyBillNamePref) ?? '';
  }

  static Future<bool> setBillPartyName(String partyBillNamePref) {
    ArgumentError.checkNotNull(partyBillNamePref, Constants.partyBillNamePref);
    return _prefsInstance!
        .setString(Constants.partyBillNamePref, partyBillNamePref);
  }

  static String getBillPartyMobile() {
    return _prefsInstance?.getString(Constants.partyBillMobilePref) ?? '';
  }

  static Future<bool> setBillPartyMobile(String partyBillMobilePref) {
    ArgumentError.checkNotNull(
        partyBillMobilePref, Constants.partyBillMobilePref);
    return _prefsInstance!
        .setString(Constants.partyBillMobilePref, partyBillMobilePref);
  }

  static String getBillPartyCreditDays() {
    return _prefsInstance?.getString(Constants.partyBillCreditDays) ?? '';
  }

  static Future<bool> setBillPartyCreditDays(String partyBillCreditDays) {
    ArgumentError.checkNotNull(
        partyBillCreditDays, Constants.partyBillCreditDays);
    return _prefsInstance!
        .setString(Constants.partyBillCreditDays, partyBillCreditDays);
  }

  static String getBillPartyOutState() {
    return _prefsInstance?.getString(Constants.partyBillOutState) ?? '';
  }

  static Future<bool> setBillPartyOutState(String partyBillOutState) {
    ArgumentError.checkNotNull(
        partyBillOutState, Constants.partyBillOutState);
    return _prefsInstance!
        .setString(Constants.partyBillOutState, partyBillOutState);
  }

  static String getBillPartyStateCD() {
    return _prefsInstance?.getString(Constants.partyBillStateCD) ?? '';
  }

  static Future<bool> setBillPartyStateCD(String partyBillStateCD) {
    ArgumentError.checkNotNull(
        partyBillStateCD, Constants.partyBillStateCD);
    return _prefsInstance!
        .setString(Constants.partyBillStateCD, partyBillStateCD);
  }

  static String getBillPartyDoctorCode() {
    return _prefsInstance?.getString(Constants.partyBillDoctorCode) ?? '';
  }

  static Future<bool> setBillPartyDoctorCode(String partyBillDoctorCode) {
    ArgumentError.checkNotNull(
        partyBillDoctorCode, Constants.partyBillDoctorCode);
    return _prefsInstance!
        .setString(Constants.partyBillDoctorCode, partyBillDoctorCode);
  }

  static String getBillPartyDoctorName() {
    return _prefsInstance?.getString(Constants.partyBillDoctorName) ?? '';
  }

  static Future<bool> setBillPartyDoctorName(String partyBillDoctorName) {
    ArgumentError.checkNotNull(
        partyBillDoctorName, Constants.partyBillDoctorName);
    return _prefsInstance!
        .setString(Constants.partyBillDoctorName, partyBillDoctorName);
  }

  static String getBillPartyDoctorMobile() {
    return _prefsInstance?.getString(Constants.partyBillDoctorMobile) ?? '';
  }

  static Future<bool> setBillPartyDoctorMobile(String partyBillDoctorMobile) {
    ArgumentError.checkNotNull(
        partyBillDoctorMobile, Constants.partyBillDoctorMobile);
    return _prefsInstance!
        .setString(Constants.partyBillDoctorMobile, partyBillDoctorMobile);
  }

  static String getFirmObject() {
    return _prefsInstance?.getString(Constants.firmObjectPref) ?? '';
  }

  static Future<bool> setFirmObject(String firmObjectPref) {
    ArgumentError.checkNotNull(firmObjectPref, Constants.firmObjectPref);
    return _prefsInstance!.setString(Constants.firmObjectPref, firmObjectPref);
  }

  static String getBluetoothName() {
    return _prefsInstance?.getString(Constants.bluetoothNamePref) ?? '';
  }

  static Future<bool> setBluetoothName(String bluetoothNamePref) {
    ArgumentError.checkNotNull(bluetoothNamePref, Constants.bluetoothNamePref);
    return _prefsInstance!
        .setString(Constants.bluetoothNamePref, bluetoothNamePref);
  }

  static String getBluetoothAddress() {
    return _prefsInstance?.getString(Constants.bluetoothAddressPref) ?? '';
  }

  static Future<bool> setBluetoothAddress(String bluetoothAddressPref) {
    ArgumentError.checkNotNull(
        bluetoothAddressPref, Constants.bluetoothAddressPref);
    return _prefsInstance!
        .setString(Constants.bluetoothAddressPref, bluetoothAddressPref);
  }
}
