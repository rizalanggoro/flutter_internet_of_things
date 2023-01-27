import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/device_model.dart';
import '../../routes/app_pages.dart';
import '../../services/mqtt_service.dart';

class HomeController extends GetxController {
  final MqttService mqttService = Get.find();
  final RxBool isDark = RxBool(false);

  @override
  void onReady() {
    super.onReady();

    isDark.value = GetStorage().read('isDark') ?? false;
  }

  void showDevice(DeviceModel deviceModel) => Get.toNamed(
        Routes.device,
        arguments: deviceModel,
      );

  void changeAppBrightness(bool value) {
    isDark.value = value;
    if (isDark.value) {
      Get.changeThemeMode(ThemeMode.dark);
      GetStorage().write('isDark', true);
    } else {
      Get.changeThemeMode(ThemeMode.light);
      GetStorage().write('isDark', false);
    }
  }
}
