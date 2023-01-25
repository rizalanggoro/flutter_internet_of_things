import 'package:get/get.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/values/device_data.dart';
import 'package:internet_of_things/routes/app_pages.dart';
import 'package:internet_of_things/services/mqtt_service.dart';

class HomeController extends GetxController {
  final listDevice = DeviceData.listDevices;
  final MqttService mqttService = Get.find();

  void showDevice(DeviceModel deviceModel) => Get.toNamed(
        Routes.device,
        arguments: deviceModel,
      );
}
