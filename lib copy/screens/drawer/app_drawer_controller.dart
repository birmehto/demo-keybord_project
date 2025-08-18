import 'package:demo/api/dio_client.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/app/app_url.dart';
import 'package:demo/screens/drawer/app_drawer_model.dart';
import 'package:demo/utility/constants.dart';
import 'package:demo/utility/utils.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utility/network.dart';

class AppDrawerController extends GetxController {
  var isLoading = false.obs;
  var isDarkMode = false.obs;

  var drawerList = DrawerResponse().obs;
  var modulesList = <Modules>[].obs;
  var uniqueModules = <String>{}.obs;

  var errorMsg = ''.obs;
  var version = '';
  var buildNumber = '';

  @override
  void onInit() {
    super.onInit();
    fetchDrawer();
    _appInfo();
  }

  void _appInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> fetchDrawer() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);
        final response = await DioClient().get(AppURL.drawerURL);
        drawerList.value = DrawerResponse.fromJson(response);

        if (drawerList.value.data != null &&
            drawerList.value.message == 'Data fetch successfully') {
          if (drawerList.value.data!.modules!.isNotEmpty) {
            modulesList.value = drawerList.value.data!.modules!;
            uniqueModules.clear();

            for (var module in modulesList) {
              if (module.rEADRIGHT == true && module.mODULENO != null) {
                uniqueModules.add(module.mODULENO!);
              }
            }
          } else {
            AppSnackBar.showGetXCustomSnackBar(
              message: response.data['message'],
            );
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response.data['message']);
        }
      } catch (e) {
        Utils.handleException(e);
      } finally {
        isLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Modules? getModuleByNo(String moduleNo) {
    try {
      return modulesList.firstWhere(
        (module) => module.mODULENO == moduleNo && module.rEADRIGHT == true,
      );
    } catch (e) {
      return null;
    }
  }
}
