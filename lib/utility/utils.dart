import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:demo_project/api/app_exception.dart';
import 'package:demo_project/app/app_images.dart';
import 'package:demo_project/app/app_routes.dart';
import 'package:demo_project/app/app_snack_bar.dart';
import 'package:demo_project/models/firm_response.dart';
import 'package:demo_project/screens/drawer/app_drawer_controller.dart';
import 'package:demo_project/utility/constants.dart';
import 'package:demo_project/utility/preference_utils.dart';
import 'package:demo_project/widgets/common_app_image_svg.dart';
import 'package:demo_project/widgets/common_no_message.dart';
import 'package:demo_project/widgets/common_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import '../screens/drawer/app_drawer_model.dart';

/// All app level utility methods are defined here
class Utils {
  Utils._();

  static String commonUTCDateFormat = 'yyyy-MM-ddThh:mm:ss';
  static String commonAppDateFormat = 'yyyy, MMM dd hh:mm a';

  static String filterPattern = r'^[0-9]*\.?[0-9]*$';
  static String filterPatternWithDecimal0x2 = r'^\d*\.?\d{0,2}';
  static String filterPatternWithDecimal12x2 = r'^\d{0,12}(\.\d{0,2})?';

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static double getScreenHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth({required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void handleException1(Exception e) {
    final RxString errorMsg = ''.obs;
    if (e.toString().contains('NotFoundException')) {
      errorMsg.value = Constants.contactMsg;
    } else if (e.toString().contains('FetchDataException')) {
      errorMsg.value = Constants.internalServer;
    } else if (e.toString().contains('BadRequestException')) {
      errorMsg.value = Constants.badRequest;
    } else if (e.toString().contains('ApiNotRespondingException')) {
      errorMsg.value = Constants.timeOutMsg;
    } else if (e.toString().contains('UnAuthorizedException')) {
      PreferenceUtils.setIsLogin(false).then((_) {
        PreferenceUtils.setAuthToken('');
        //PreferenceUtils.clearAllPreferences();

        Get.offAllNamed(AppRoutes.loginRoute);
        AppSnackBar.showGetXCustomSnackBar(
          message: 'Logout successfully',
          backgroundColor: Colors.green,
        );
      });
      errorMsg.value = Constants.unAuthorizes;
    } else if (e.toString().contains('SocketException')) {
      errorMsg.value = Constants.somethingWrongMsg;
    } else if (e.toString().contains('TimeOutException')) {
      errorMsg.value = Constants.timeOutMsg;
    } else {
      errorMsg.value = Constants.somethingWrongMsg;
    }

    AppSnackBar.showGetXCustomSnackBar(message: errorMsg.value);
  }

  static void handleException(Object e) {
    String message;

    if (e is AppException && e.message != null) {
      message = e.message!;
    } else {
      message = Constants.somethingWrongMsg; // fallback
    }

    if (e is UnAuthorizedException) {
      PreferenceUtils.setIsLogin(false).then((_) {
        PreferenceUtils.setAuthToken('');
        //PreferenceUtils.clearAllPreferences();

        Get.offAllNamed(AppRoutes.loginRoute);
        AppSnackBar.showGetXCustomSnackBar(
          message: 'Logout successfully',
          backgroundColor: Colors.green,
        );
      });
    }

    AppSnackBar.showGetXCustomSnackBar(message: message);
  }

  void logoutUser() {
    PreferenceUtils.setIsLogin(false).then((_) {
      PreferenceUtils.setAuthToken('');
      //PreferenceUtils.clearAllPreferences();

      Get.offAllNamed(AppRoutes.loginRoute);
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Logout successfully',
        backgroundColor: Colors.green,
      );
    });
  }

  static Future<void> successWithBack(String msg, {dynamic result}) async {
    //Get.back();
    Navigator.pop(Get.context!, result);
    Utils.closeKeyboard(Get.context!);
    AppSnackBar.showGetXCustomSnackBar(
      message: msg,
      backgroundColor: AppColors.colorGreen,
    );
  }

  static Future<void> successWithoutBack(String msg) async {
    Utils.closeKeyboard(Get.context!);
    AppSnackBar.showGetXCustomSnackBar(
      message: msg,
      backgroundColor: AppColors.colorGreen,
    );
  }

  static Future<void> errorWithoutBack(String msg) async {
    Utils.closeKeyboard(Get.context!);
    AppSnackBar.showGetXCustomSnackBar(message: msg);
  }

  static void messageBottom(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CommonText(
                      padding: const EdgeInsets.only(top: 20),
                      text:
                          "Successfully Connected Enter your \n Credential to Login.",
                      fontSize: 19,
                      maxLine: 2,
                      color: AppColors.colorBlack,
                      fontWeight: AppFontWeight.regular,
                    ),
                  ],
                ).marginOnly(top: 50, left: 15, right: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                              (states) => AppColors.indigoSwatch,
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                          ),
                          onPressed: () {
                            //Get.back();
                            Navigator.pop(Get.context!);
                          },
                          child: CommonText(
                            text: 'OK',
                            color: AppColors.colorWhite,
                            fontSize: 16,
                            fontWeight: AppFontWeight.w600,
                          ),
                        ),
                      ).paddingOnly(left: 30, right: 30),
                    ],
                  ).marginOnly(top: 35, left: 15, right: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget iconButton() {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          side: BorderSide(color: AppColors.indigoSwatch),
        ),
        child: InkWell(
          onTap: () {},
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          splashColor: AppColors.indigoSwatch.withValues(alpha: 0.5),
          child: const RotatedBox(
            quarterTurns: 0,
            child: Icon(Icons.person, size: 16, color: AppColors.indigoSwatch),
          ),
        ),
      ),
    );
  }

  static Future<XFile?> pickImage({
    required ImageSource source,
    required CameraDevice cameraDevice,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        preferredCameraDevice: cameraDevice,
      );
      if (pickedFile != null) {
        // selectedImage.value = File(pickedFile.path);
        debugPrint("SELECTED ::: ${pickedFile.path}");
        return pickedFile;
      } else {
        debugPrint('No image selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return null;
  }

  static Widget commonCircularProgress() {
    return const CircularProgressIndicator(
      //color: AppColors.indigoSwatch,
      strokeWidth: 2,
    );
  }

  static Future<String> convertFileToBase64(String filePath) async {
    final file = File(filePath);
    final List<int> bytes = await file.readAsBytes();

    final String base64String = base64.encode(bytes);
    return base64String;
  }

  static Widget noDataUI1(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonAppImageSvg(
            imagePath: AppImages.svgNoData,
            height: 100,
            width: double.infinity,
          ),
          const SizedBox(height: 20),
          CommonText(
            text: message,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.colorBlack,
          ),
        ],
      ),
    );
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(
      (size.width * size.width) + (size.height * size.height),
    );
    final dpi = MediaQuery.of(context).devicePixelRatio;
    final screenInches = diagonal / dpi;

    return screenInches >= 7.0; // tablets typically >= 7 inches
  }

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';

  static formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  // static Future<String?> saveFile(
  //     String url, String reportName, String successMsg) async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   int androidVersion = 10;
  //   AndroidDeviceInfo d = await deviceInfo.androidInfo;
  //   androidVersion = int.parse(d.version.release.split('.')[0]);
  //
  //   try {
  //     // late final NotificationService notificationService;
  //     // notificationService = NotificationService();
  //     // void listenToNotificationStream() =>
  //     //     notificationService.behaviorSubject.listen((payload) async {});
  //     // listenToNotificationStream();
  //     // notificationService.initializePlatformNotifications();
  //
  //     File saveFileUrl = new File("");
  //     if (await _requestPermission(androidVersion.isGreaterThan(11)
  //         ? Permission.mediaLibrary
  //         : Permission.storage)) {
  //       Directory? directory;
  //       directory = Platform.isIOS
  //           ? await getApplicationDocumentsDirectory()
  //           : await Directory("/storage/emulated/0/Download");
  //       String newPath = "";
  //       List<String> paths = directory.path.split("/");
  //       for (int x = 1; x < paths.length; x++) {
  //         String folder = paths[x];
  //         if (folder != "Android") {
  //           newPath += "/" + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + "/ArhamErp";
  //       directory = Directory(newPath);
  //
  //       saveFileUrl =
  //           File(directory.path + "/${reportName}.${url.split(".").last}");
  //       if (kDebugMode) {
  //         print(saveFileUrl.path);
  //       }
  //       if (!await directory.exists()) {
  //         await directory.create(recursive: true);
  //       }
  //       print(url);
  //       if (await directory.exists()) {
  //         await Dio()
  //             .download(
  //           url,
  //           saveFileUrl.path,
  //         )
  //             .then((value) async {
  //           // Fluttertoast.showToast(
  //           //     msg: successMsg, toastLength: Toast.LENGTH_LONG);
  //           AppSnackBar.showGetXCustomSnackBar(
  //               message: successMsg, backgroundColor: Colors.green);
  //         });
  //       }
  //     } else {
  //       // Fluttertoast.showToast(
  //       //     msg: "Please provide storage Permission from the settings.",
  //       //     toastLength: Toast.LENGTH_LONG);
  //       AppSnackBar.showGetXCustomSnackBar(
  //           message: 'Please provide storage Permission from the settings.');
  //     }
  //     return saveFileUrl.path;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  static Future<String?> downloadFile(
    File file,
    String reportName,
    String successMsg,
  ) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    int androidVersion = 10;
    final AndroidDeviceInfo d = await deviceInfo.androidInfo;
    androidVersion = int.parse(d.version.release.split('.')[0]);

    try {
      File saveFileUrl = File(reportName);

      // Request permissions
      if (await _requestPermission(
        androidVersion > 11 ? Permission.mediaLibrary : Permission.storage,
      )) {
        Directory? directory;
        directory =
            Platform.isIOS
                ? await getApplicationDocumentsDirectory()
                : Directory("/storage/emulated/0/Download");

        String newPath = "";
        final List<String> paths = directory.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          final String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }

        newPath = "$newPath/ArhamErpPOS";
        directory = Directory(newPath);

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // Construct new file path with desired name
        final String extension = file.path.split('.').last;
        saveFileUrl = File("${directory.path}/$reportName.$extension");

        // Copy the file to the new location
        await file.copy(saveFileUrl.path);

        AppSnackBar.showGetXCustomSnackBar(
          message: successMsg,
          backgroundColor: Colors.green,
        );
      } else {
        AppSnackBar.showGetXCustomSnackBar(
          message: 'Please provide storage Permission from the settings.',
        );
      }

      return saveFileUrl.path;
    } catch (e) {
      return null;
    }
  }

  static void storeSelectedFirmObject(FirmModel firm) {
    final String firmJson = jsonEncode(
      firm.toJson(),
    ); // assuming your Firm model has toJson()
    PreferenceUtils.setFirmObject(firmJson);
  }

  static FirmModel? getStoredFirmObject() {
    final String firmJson = PreferenceUtils.getFirmObject();
    if (firmJson.isNotEmpty) {
      final Map<String, dynamic> firmMap = jsonDecode(firmJson);
      return FirmModel.fromJson(firmMap);
    }
    return null;
  }

  static Widget noDataUI(String message) {
    return Center(
      child: SingleChildScrollView(
        // Wrap to allow scrolling
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonAppImageSvg(
              imagePath: AppImages.svgNoData,
              height: 100,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            CommonText(
              text: message,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.colorBlack,
            ),
          ],
        ),
      ),
    );
  }

  static String numberFormat(val) {
    return NumberFormat('#,##0.00').format(val);
  }

  static Widget buildShimmerList() {
    final theme = Theme.of(Get.context!);
    final colorScheme = theme.colorScheme;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // Disable scroll while loading
      itemCount: 6,
      itemBuilder:
          (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Shimmer.fromColors(
              baseColor: colorScheme.primary.withValues(alpha: 0.25),
              highlightColor: colorScheme.onPrimary.withValues(alpha: 0.25),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
    );
  }

  static Widget buildConditionalView({
    required bool isLoading,
    required List list,
    required String searchQuery,
    required String errorMessage,
    required Widget Function(BuildContext context) onSuccess,
  }) {
    if (isLoading) {
      return buildShimmerList();
    } else if (list.isEmpty) {
      return CommonNoMessage(
        searchQuery: searchQuery,
        errorMessage: errorMessage,
      );
    } else {
      return Builder(builder: onSuccess);
    }
  }

  static double parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static String extractNumericValue(String input) {
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(input);
    return match != null ? match.group(0)! : '';
  }

  static String formatMobileAndAddress(String? mobile, String? address) {
    if ((mobile?.isEmpty ?? true) && (address?.isEmpty ?? true)) {
      return '';
    } else if (mobile?.isEmpty ?? true) {
      return address!;
    } else if (address?.isEmpty ?? true) {
      return mobile!;
    } else {
      return '$mobile | $address';
    }
  }

  static String formatIndianAmount(double? amount) {
    if (amount == null) return '';
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(amount).trim();
  }

  static String formatIndianPlainAmount(double? amount) {
    if (amount == null) return '';
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '', // No ₹ symbol
      decimalDigits: 2,
    );
    return formatter.format(amount).trim();
  }

  static String formatRate(String? rate) {
    if (rate == null || rate.isEmpty) return '';
    final parsed = double.tryParse(rate);
    return parsed != null ? parsed.toStringAsFixed(2) : rate;
  }

  static Map<String, DateTime> getFinancialYearRange() {
    final DateTime now = DateTime.now();
    if (now.month >= 4) {
      return {
        'start': DateTime(now.year, 4),
        'end': DateTime(now.year + 1, 3, 31),
      };
    } else {
      return {
        'start': DateTime(now.year - 1, 4),
        'end': DateTime(now.year, 3, 31),
      };
    }
  }

  static DateTime? parseDate(String dateStr, String format) {
    try {
      final DateFormat formatter = DateFormat(format);
      return formatter.parse(dateStr);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return null;
    }
  }

  static void navigateIfAuthorizedView1({
    required String moduleNo,
    required String routeName,
  }) {
    final AppDrawerController drawerController =
        Get.find<AppDrawerController>();

    final selectedModule = drawerController.modulesList.firstWhere(
      (module) => module.mODULENO == moduleNo,
      orElse: () => Modules(), // returns empty object if not found
    );

    final hasValidModule = selectedModule.mODULENO != null;
    final hasViewAccess = (selectedModule.rEADRIGHT ?? false);

    // final hasAddAccess = (selectedModule.wRITERIGHT ?? false);
    // final hasUpdateAccess = (selectedModule.uPDATERIGHT ?? false);
    // final hasDeleteAccess = (selectedModule.dELETERIGHT ?? false);
    // final hasPrintAccess = (selectedModule.pRINTRIGHT ?? false);

    if (hasValidModule && hasViewAccess) {
      Get.toNamed(
        routeName,
        arguments: {
          "ModuleNo": selectedModule.mODULENO,
          "ReadRight": selectedModule.rEADRIGHT,
          "WriteRight": selectedModule.wRITERIGHT,
          "UpdateRight": selectedModule.uPDATERIGHT,
          "DeleteRight": selectedModule.dELETERIGHT,
          "PrintRight": selectedModule.pRINTRIGHT,
        },
      );
    } else {
      AppSnackBar.showGetXCustomSnackBar(
        message:
            "You don't have access to this module: $moduleNo :- ${selectedModule.module?.mODULENAME ?? ''}",
      );
    }
  }

  static void navigateIfAuthorizedView({
    required String moduleNo,
    required String routeName,
    Map<String, dynamic> extraArguments = const {},
  }) {
    final AppDrawerController drawerController =
        Get.find<AppDrawerController>();

    final selectedModule = drawerController.modulesList.firstWhere(
      (module) => module.mODULENO == moduleNo,
      orElse: () => Modules(),
    );

    final hasValidModule = selectedModule.mODULENO != null;
    final hasViewAccess = (selectedModule.rEADRIGHT ?? false);

    // final hasAddAccess = (selectedModule.wRITERIGHT ?? false);
    // final hasUpdateAccess = (selectedModule.uPDATERIGHT ?? false);
    // final hasDeleteAccess = (selectedModule.dELETERIGHT ?? false);
    // final hasPrintAccess = (selectedModule.pRINTRIGHT ?? false);

    if (hasValidModule && hasViewAccess) {
      final Map<String, dynamic> baseArguments = {
        "ModuleNo": selectedModule.mODULENO,
        "ReadRight": selectedModule.rEADRIGHT,
        "WriteRight": selectedModule.wRITERIGHT,
        "UpdateRight": selectedModule.uPDATERIGHT,
        "DeleteRight": selectedModule.dELETERIGHT,
        "PrintRight": selectedModule.pRINTRIGHT,
      };

      final Map<String, dynamic> finalArguments = {
        ...baseArguments,
        ...extraArguments,
      };

      Get.toNamed(routeName, arguments: finalArguments);
    } else {
      AppSnackBar.showGetXCustomSnackBar(
        message:
            "You don't have access to this module: $moduleNo :- ${selectedModule.module?.mODULENAME ?? ''}",
      );
    }
  }

  static void navigateIfAuthorizedViewAdd({
    required String moduleNo,
    required String routeName,
    Map<String, dynamic> extraArguments = const {},
  }) {
    final AppDrawerController drawerController =
        Get.find<AppDrawerController>();

    final selectedModule = drawerController.modulesList.firstWhere(
      (module) => module.mODULENO == moduleNo,
      orElse: () => Modules(),
    );

    final hasValidModule = selectedModule.mODULENO != null;
    final hasAddAccess = (selectedModule.wRITERIGHT ?? false);

    // final hasViewAccess = (selectedModule.rEADRIGHT ?? false);
    // final hasUpdateAccess = (selectedModule.uPDATERIGHT ?? false);
    // final hasDeleteAccess = (selectedModule.dELETERIGHT ?? false);
    // final hasPrintAccess = (selectedModule.pRINTRIGHT ?? false);

    if (hasValidModule && hasAddAccess) {
      final Map<String, dynamic> baseArguments = {
        "ModuleNo": selectedModule.mODULENO,
        "ReadRight": selectedModule.rEADRIGHT,
        "WriteRight": selectedModule.wRITERIGHT,
        "UpdateRight": selectedModule.uPDATERIGHT,
        "DeleteRight": selectedModule.dELETERIGHT,
        "PrintRight": selectedModule.pRINTRIGHT,
      };

      final Map<String, dynamic> finalArguments = {
        ...baseArguments,
        ...extraArguments,
      };

      Get.toNamed(routeName, arguments: finalArguments);
    } else {
      AppSnackBar.showGetXCustomSnackBar(
        message:
            "You don't have access to this module: $moduleNo :- ${selectedModule.module?.mODULENAME ?? ''}",
      );
    }
  }

  static void navigateIfAuthorizedOffView({
    required String moduleNo,
    required String routeName,
    Map<String, dynamic> extraArguments = const {},
  }) {
    final AppDrawerController drawerController =
        Get.find<AppDrawerController>();

    final selectedModule = drawerController.modulesList.firstWhere(
      (module) => module.mODULENO == moduleNo,
      orElse: () => Modules(),
    );

    final hasValidModule = selectedModule.mODULENO != null;
    final hasViewAccess = (selectedModule.rEADRIGHT ?? false);

    // final hasAddAccess = (selectedModule.wRITERIGHT ?? false);
    // final hasUpdateAccess = (selectedModule.uPDATERIGHT ?? false);
    // final hasDeleteAccess = (selectedModule.dELETERIGHT ?? false);
    // final hasPrintAccess = (selectedModule.pRINTRIGHT ?? false);

    if (hasValidModule && hasViewAccess) {
      final Map<String, dynamic> baseArguments = {
        "ModuleNo": selectedModule.mODULENO,
        "ReadRight": selectedModule.rEADRIGHT,
        "WriteRight": selectedModule.wRITERIGHT,
        "UpdateRight": selectedModule.uPDATERIGHT,
        "DeleteRight": selectedModule.dELETERIGHT,
        "PrintRight": selectedModule.pRINTRIGHT,
      };

      final Map<String, dynamic> finalArguments = {
        ...baseArguments,
        ...extraArguments,
      };

      Get.offAndToNamed(routeName, arguments: finalArguments);
    } else {
      AppSnackBar.showGetXCustomSnackBar(
        message:
            "You don't have access to this module: $moduleNo :- ${selectedModule.module?.mODULENAME ?? ''}",
      );
    }
  }

  static void navigateIfAuthorizedViewReceivablePayable({
    required String moduleNo,
    required String routeName,
    Map<String, dynamic> extraArguments = const {},
  }) {
    final AppDrawerController drawerController =
        Get.find<AppDrawerController>();

    final selectedModule = drawerController.modulesList.firstWhere(
      (module) => module.mODULENO == moduleNo,
      orElse: () => Modules(),
    );

    // final hasValidModule = selectedModule.mODULENO != null;
    // final hasViewAccess = (selectedModule.rEADRIGHT ?? false);

    // final hasAddAccess = (selectedModule.wRITERIGHT ?? false);
    // final hasUpdateAccess = (selectedModule.uPDATERIGHT ?? false);
    // final hasDeleteAccess = (selectedModule.dELETERIGHT ?? false);
    // final hasPrintAccess = (selectedModule.pRINTRIGHT ?? false);

    //if (hasValidModule && hasViewAccess) {
    final Map<String, dynamic> baseArguments = {
      "ModuleNo": selectedModule.mODULENO,
      "ReadRight": selectedModule.rEADRIGHT,
      "WriteRight": selectedModule.wRITERIGHT,
      "UpdateRight": selectedModule.uPDATERIGHT,
      "DeleteRight": selectedModule.dELETERIGHT,
      "PrintRight": selectedModule.pRINTRIGHT,
    };

    final Map<String, dynamic> finalArguments = {
      ...baseArguments,
      ...extraArguments,
    };

    Get.toNamed(routeName, arguments: finalArguments);
    // } else {
    //   AppSnackBar.showGetXCustomSnackBar(
    //     message:
    //     "You don't have access to this module: $moduleNo :- ${selectedModule.module?.mODULENAME ?? ''}",
    //   );
    // }
  }

  static String getModuleNoSalesFromCategory() {
    final category = PreferenceUtils.getCategory().toLowerCase();

    switch (category) {
      case 'general':
        return '201';
      case 'pos':
        return '221';
      case 'pharmacy':
        return '223';
      default:
        return '000';
    }
  }

  static String getModuleNoSalesReturnsFromCategory() {
    final category = PreferenceUtils.getCategory().toLowerCase();

    switch (category) {
      case 'general':
        return '202';
      case 'pos':
        return '222';
      case 'pharmacy':
        return '224';
      default:
        return '000';
    }
  }

  static PdfPageFormat getCurrentPageFormat(String format) {
    switch (format) {
      case 'A5 Landscape':
        return PdfPageFormat.a5.landscape;
      case 'A4 Portrait':
        return PdfPageFormat.a4;
      case 'A4 Landscape':
        return PdfPageFormat.a4.landscape;
      case 'A5 Portrait':
      default:
        return PdfPageFormat.a5;
    }
  }

  static String formatToString(PdfPageFormat format) {
    if (format == PdfPageFormat.a5) return 'A5 Portrait';
    if (format == PdfPageFormat.a5.landscape) return 'A5 Landscape';
    if (format == PdfPageFormat.a4) return 'A4 Portrait';
    if (format == PdfPageFormat.a4.landscape) return 'A4 Landscape';
    return 'A5 Portrait';
  }

  // Helper method for consistent menu items
  static PopupMenuItem<String> buildMenuItem({
    required BuildContext context,
    required String value,
    required IconData icon,
    required Color iconColor,
    required String title,
    bool isHighlighted = false,
  }) {
    return PopupMenuItem<String>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border:
              isHighlighted
                  ? Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3,
                    ),
                  )
                  : null,
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
