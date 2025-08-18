import 'dart:async';
import 'dart:io';

import 'package:demo/widgets/common_text.dart';
import 'package:demo/widgets/common_text_button.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  static bool _isRequestingPermissions = false;

  static Future<void> checkAndRequestAllPermissions(
    BuildContext context,
  ) async {
    // Step 1: Base permissions (camera, storage, photos)
    final List<Permission> basePermissions = [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ];

    // Step 2: Notification permission (iOS/Android 13+)
    final List<Permission> notificationPermissions = [Permission.notification];

    // Step 3: Bluetooth permissions
    final List<Permission> bluetoothPermissions =
        await _getBluetoothPermissions();

    // Combine all permissions
    final allPermissions = [
      ...basePermissions,
      ...notificationPermissions,
      ...bluetoothPermissions,
    ];

    // Check if all permissions are granted
    bool allGranted = true;
    for (Permission permission in allPermissions) {
      if (!(await permission.isGranted)) {
        allGranted = false;
        break;
      }
    }

    // Request permissions if any is missing
    if (!allGranted && context.mounted) {
      await requestPermissions(allPermissions, context);
    }
  }

  static Future<void> requestPermissions(
    List<Permission> permissions,
    BuildContext context,
  ) async {
    if (_isRequestingPermissions) return;

    try {
      _isRequestingPermissions = true;

      bool showRationale = false;
      for (Permission permission in permissions) {
        if (!await permission.isGranted &&
            await permission.shouldShowRequestRationale) {
          showRationale = true;
          break;
        }
      }

      if (showRationale) {
        await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                title: const CommonText(text: 'Permissions Required'),
                content: const CommonText(
                  text: 'Please grant the required permissions to continue.',
                ),
                actions: [
                  CommonTextButton(
                    title: 'OK',
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await _requestPermissions(permissions);
                    },
                  ),
                ],
              ),
        );
      } else {
        await _requestPermissions(permissions);
      }
    } finally {
      _isRequestingPermissions = false;
    }
  }

  static Future<void> _requestPermissions(List<Permission> permissions) async {
    try {
      await permissions.request();
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting permissions: $e');
      }
    }
  }

  /// Platform-aware Bluetooth permissions
  static Future<List<Permission>> _getBluetoothPermissions() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 31) {
        return [
          Permission.bluetooth,
          Permission.bluetoothConnect,
          Permission.bluetoothScan,
          Permission.location,
        ];
      } else {
        return [Permission.bluetooth, Permission.location];
      }
    } else if (Platform.isIOS) {
      return [Permission.bluetooth];
    } else {
      return [];
    }
  }
}
