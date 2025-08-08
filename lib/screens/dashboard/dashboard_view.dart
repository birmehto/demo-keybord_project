import 'package:demo_project/screens/dashboard/dashboard_controller.dart';
import 'package:demo_project/screens/drawer/app_drawer_view.dart';
import 'package:demo_project/widgets/common_app_bar.dart';
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
