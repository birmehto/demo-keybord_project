import 'package:demo/app/app_colors.dart';
import 'package:demo/app/app_font_weight.dart';
import 'package:demo/app/app_images.dart';
import 'package:demo/app/app_snack_bar.dart';
import 'package:demo/screens/drawer/app_drawer_controller.dart';
import 'package:demo/utility/preference_utils.dart';
import 'package:demo/utility/utils.dart';
import 'package:demo/widgets/common_app_image.dart';
import 'package:demo/widgets/common_expansion_tile.dart';
import 'package:demo/widgets/common_list_tile.dart';
import 'package:demo/widgets/common_material_dialog.dart';
import 'package:demo/widgets/common_no_message.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_routes.dart';

@immutable
class AppDrawerView extends GetView<AppDrawerController> {
  AppDrawerView({super.key});

  @override
  final controller = Get.put(AppDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //TODO : Header Show
            const DrawerHeader(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: CommonAppImage(
                imagePath: AppImages.icArhamLogo,
                fit: BoxFit.fill,
              ),
            ),
            Obx(() {
              return controller.isLoading.isTrue
                  ? Center(child: Utils.commonCircularProgress())
                  : controller.drawerList.value.data != null
                  ? Column(children: [_buildReportsTile(context)])
                  : Center(
                    child: CommonNoMessage(
                      searchQuery: '',
                      errorMessage: controller.errorMsg.value,
                    ),
                  );
            }),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
              leading: const CommonAppImage(
                imagePath: AppImages.icLogoutIcon,
                width: 24,
                height: 24,
                color: AppColors.colorDarkGray,
              ),
              title: CommonText(
                text: 'Logout',
                color: AppColors.colorDarkGray,
                fontWeight: AppFontWeight.w600,
              ),
              onTap: () {
                Get.dialog(
                  CommonMaterialDialog(
                    title: 'Logout',
                    message: 'Are you sure you want to\nlogout?',
                    yesButtonText: 'Yes',
                    noButtonText: 'No',
                    onConfirm: () {
                      PreferenceUtils.setIsLogin(false).then((_) {
                        PreferenceUtils.setAuthToken('');
                        PreferenceUtils.setLoginUserCode('');
                        PreferenceUtils.setLoginUserName('');
                        PreferenceUtils.setLoginCustID('');
                        PreferenceUtils.setLoginUserRole('');
                        PreferenceUtils.setLoginUserPassword('');
                        PreferenceUtils.setLoginMobileNO('');
                        //PreferenceUtils.clearAllPreferences();

                        Get.offAllNamed(AppRoutes.loginRoute);
                        AppSnackBar.showGetXCustomSnackBar(
                          message: 'Logout successfully',
                          backgroundColor: Colors.green,
                        );
                      });
                    },
                    onCancel: () {
                      //Get.back();
                      Navigator.pop(Get.context!);
                    },
                    isLoading: controller.isLoading,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsTile(BuildContext context) {
    return CommonExpansionTile(
      title: 'Reports & Analysis',
      leadingIcon: AppImages.icReportsAnalysisIcon,
      children: [
        if (controller.getModuleByNo('201') != null ||
            controller.getModuleByNo('221') != null ||
            controller.getModuleByNo('220') != null ||
            controller.getModuleByNo('223') != null)
          CommonListTile(
            imagePath: AppImages.icSalesTrnIcon,
            text: 'Sales',
            onTap: () {
              Get.back();
              final category = PreferenceUtils.getCategory().toLowerCase();

              String? moduleNo;
              if (category == 'general') {
                moduleNo = '201';
              } else if (category == 'pos') {
                moduleNo = '221';
              } else if (category == 'pharmacy') {
                moduleNo = '223';
              } else {
                moduleNo = '220';
              }
              final module = controller.getModuleByNo(moduleNo)!;

              Get.toNamed(
                AppRoutes.salesRoute,
                arguments: {
                  "ModuleNo": module.mODULENO,
                  "ReadRight": module.rEADRIGHT,
                  "WriteRight": module.wRITERIGHT,
                  "UpdateRight": module.uPDATERIGHT,
                  "DeleteRight": module.dELETERIGHT,
                  "PrintRight": module.pRINTRIGHT,
                },
              );
            },
          ),
      ],
    );
  }
}
