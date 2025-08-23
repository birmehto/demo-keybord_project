import 'package:demo/screens/transaction_management/web_sales/web_general_sales_controller.dart';
import 'package:get/get.dart';

class WebGeneralSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WebGeneralSalesController(),
      fenix: true, // Allows recreation if needed
    );
  }
}
