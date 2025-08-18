import 'package:demo/screens/dashboard/dashboard_controller.dart';
import 'package:demo/screens/drawer/app_drawer_view.dart';
import 'package:demo/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        controller.onWillPop;
        return;
      },
      child: Scaffold(
        appBar: const CommonAppBar(title: 'Dashboard'),
        drawer: AppDrawerView(),
      ),
    );
  }
}
