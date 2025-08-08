import 'package:demo_project/screens/drawer/app_drawer_controller.dart';
import 'package:get/get.dart';

class AppDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppDrawerController());
  }
}
