import 'package:get/get.dart';
import 'package:internet_of_things/data/enums/mqtt_state.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/routes/app_pages.dart';
import 'package:internet_of_things/services/mqtt_service.dart';

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
