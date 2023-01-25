import 'package:get/get.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/models/mode_model.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';
import 'package:internet_of_things/data/values/device_data.dart';

class DeviceController extends GetxController {
  final listMode = DeviceData.listModeLedStrip;
  final MqttRepository _mqttRepository = Get.find();

  final Rx<double> brightness = Rx(100);
  final Rx<ModeModel?> mode = Rx(null);

  @override
  void onInit() {
    super.onInit();

    mode.value = listMode[0];
  }

  void changeBrightness(value) => brightness.value = value;

  bool isModeSelected(
    ModeModel model,
  ) =>
      model.id == (mode.value?.id ?? -1);

  void changeMode(ModeModel model) {
    mode.value = model;
    Get.back();
  }

  void publish({
    required DeviceModel model,
  }) {
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'mode',
      payload: '${mode.value?.id ?? -1}',
    );
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'brightness',
      payload: '${brightness.value.toInt()}',
    );
  }
}
