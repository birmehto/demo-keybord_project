import 'package:demo/utility/preference_utils.dart';
import 'package:get/get.dart';

import '../../../app/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        _checkFirstTime();
      },
    );
  }

  Future<void> _checkFirstTime() async {
    if (PreferenceUtils.getAuthToken().isNotEmpty) {
      Get.offAllNamed(AppRoutes.dashBoardRoute);
    } else {
      Get.offAllNamed(AppRoutes.loginRoute);
    }
  }
}
