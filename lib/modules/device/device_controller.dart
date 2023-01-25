import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/models/mode_model.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';
import 'package:internet_of_things/data/values/device_data.dart';
import 'package:internet_of_things/services/mqtt_service.dart';

class DeviceController extends GetxController {
  final listMode = DeviceData.listModeLedStrip;
  final MqttRepository _mqttRepository = Get.find();
  final MqttService _mqttService = Get.find();

  final Rx<double> brightness = Rx(100);
  final Rx<ModeModel?> mode = Rx(null);
  final Rx<Color> color = Rx(Colors.red);
  final RxInt speed = RxInt(1024);

  @override
  void onInit() {
    super.onInit();

    var model = Get.arguments as DeviceModel;
    var deviceId = model.id;
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
  }
}
