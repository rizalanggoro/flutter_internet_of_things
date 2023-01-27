import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';
import 'package:internet_of_things/data/values/device_data.dart';

class ResetController extends GetxController {
  final listDevice = DeviceData.listDevices;
  final MqttRepository _mqttRepository = Get.find();

  void reset(DeviceModel model) {
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'mode',
      payload: '0',
    );
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'brightness',
      payload: '100',
    );
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'speed',
      payload: '2048',
    );

    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'color',
      payload: '0.0.255',
    );

    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'status',
      payload: 'off',
    );

    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'auto',
      payload: '0',
    );

    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'auto_delay',
      payload: '8192',
    );

    var autoValues = {
      'n': 0,
      'v': [],
    };
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'auto_values',
      payload: jsonEncode(autoValues),
    );

    Get.back();
  }
}
