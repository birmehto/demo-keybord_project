import 'package:demo_project/app/app_snack_bar.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    final DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      AppSnackBar.showGetXCustomSnackBar(
        message: 'Press back again to exit app.',
      );
      return Future.value(false);
    }

    return Future.value(true);
  }
}
