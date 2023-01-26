import 'package:get/get.dart';

import '../../data/enums/mqtt_state.dart';
import '../../data/models/device_model.dart';
import '../../routes/app_pages.dart';
import '../../services/mqtt_service.dart';

class HomeController extends GetxController {
  final MqttService mqttService = Get.find();

  void showDevice(DeviceModel deviceModel) => Get.toNamed(
        Routes.device,
        arguments: deviceModel,
      );

  bool isDeviceEnabled(DeviceModel model) =>
      model.config.status != null &&
      model.config.mode != null &&
      model.config.color != null &&
      model.config.brightness != null &&
      model.config.speed != null &&
      mqttService.mqttState.value == MqttState.connected;
}
