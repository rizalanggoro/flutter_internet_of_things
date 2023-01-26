import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/device_model.dart';
import '../../data/models/mode_model.dart';
import '../../data/repositories/mqtt_repository.dart';
import '../../data/values/device_data.dart';
import '../../data/values/mqtt_data.dart';
import '../../services/mqtt_service.dart';

class DeviceController extends GetxController {
  final listMode = DeviceData.listModeLedStrip;
  final MqttRepository _mqttRepository = Get.find();
  final MqttService mqttService = Get.find();

  final Rx<double> brightness = Rx(100);
  final Rx<ModeModel?> mode = Rx(null);
  final Rx<Color> color = Rx(Colors.red);
  final RxInt speed = RxInt(1024);

  @override
  void onInit() {
    super.onInit();

    var model = Get.arguments as DeviceModel;
    var configModel = model.config;

    // todo: set mode from server
    mode.value = listMode[0];
    var serverMode = configModel.mode;
    if (serverMode != null) {
      mode.value = listMode.firstWhere(
        (element) => element.id == int.parse(serverMode),
      );
    }

    // todo: set brightness from server
    var serverBrightness = configModel.brightness;
    if (serverBrightness != null) {
      brightness.value = double.parse(serverBrightness);
    }

    // todo: set speed from server
    var serverSpeed = configModel.speed;
    if (serverSpeed != null) {
      speed.value = int.parse(serverSpeed);
    }

    // todo: set color from server
    var serverColor = configModel.color;
    if (serverColor != null) {
      var colors = serverColor.split('.');
      var r = int.parse(colors[0]);
      var g = int.parse(colors[1]);
      var b = int.parse(colors[2]);
      color.value = Color.fromARGB(255, r, g, b);
    }
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

  void increaseSpeed() {
    speed.value *= 2;
  }

  void decreaseSpeed() {
    if (speed.value > 2) {
      speed.value ~/= 2;
    }
  }

  void changeColor(Color color) => this.color.value = color;

  bool get isPublishing => mqttService.publishQueue.isNotEmpty;

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
    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'speed',
      payload: '${speed.value}',
    );

    var colorValue = color.value;
    var r = colorValue.red;
    var g = colorValue.green;
    var b = colorValue.blue;

    _mqttRepository.publish(
      deviceId: model.id,
      specificTopic: 'color',
      payload: '$r.$g.$b',
    );

    // todo: add publish queue
    var listTopics = [
      'mode',
      'brightness',
      'speed',
      'color',
    ];
    listTopics = listTopics
        .map(
          (e) => '${MqttData.prefix}-${model.id}/$e',
        )
        .toList();
    mqttService.publishQueue.addAll(listTopics);
  }
}
