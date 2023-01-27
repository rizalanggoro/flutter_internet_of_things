import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/device_model.dart';
import '../../data/models/mode_model.dart';
import '../../data/repositories/mqtt_repository.dart';
import '../../data/values/device_data.dart';
import '../../data/values/mqtt_data.dart';
import '../../routes/app_pages.dart';
import '../../services/mqtt_service.dart';

class DeviceController extends GetxController {
  final listMode = DeviceData.listModeLedStrip;
  final MqttRepository _mqttRepository = Get.find();
  final MqttService mqttService = Get.find();

  final RxBool autoEnable = RxBool(false);
  final RxInt autoDelay = RxInt(1024 * 4);
  final RxMap<String, dynamic> autoValues = RxMap(
    {'n': 0, 'v': []},
  );

  final Rx<ModeModel?> mode = Rx(null);
  final Rx<double> brightness = Rx(100);
  final RxInt speed = RxInt(1024);
  final Rx<Color> color = Rx(const Color.fromARGB(255, 0, 0, 255));

  bool autoEnableFv = false;
  int autoDelayFv = 1024 * 4;
  Map<String, dynamic> autoValuesFv = {'n': 0, 'v': []};
  ModeModel? modeFv;
  double brightnessFv = 100;
  int speedFv = 1024;
  Color colorFv = const Color.fromARGB(255, 0, 0, 255);

  @override
  void onInit() {
    super.onInit();

    var model = Get.arguments as DeviceModel;
    var configModel = model.config;

    // todo: set auto from server
    var serverAutoEnable = configModel.autoEnable;
    if (serverAutoEnable != null) {
      autoEnable.value = serverAutoEnable == '1';
      autoEnableFv = autoEnable.value;
    }

    // todo: set auto delay from server
    var serverAutoDelay = configModel.autoDelay;
    if (serverAutoDelay != null) {
      autoDelay.value = int.parse(serverAutoDelay);
      autoDelayFv = autoDelay.value;
    }

    // todo: set auto values from server
    var serverAutoValues = configModel.autoValues;
    if (serverAutoValues != null) {
      autoValues.value = Map<String, dynamic>.from(
        jsonDecode(serverAutoValues),
      );
      autoValuesFv = autoValues;
    }

    // todo: set mode from server
    mode.value = listMode[0];
    var serverMode = configModel.mode;
    if (serverMode != null) {
      mode.value = listMode.firstWhere(
        (element) => element.id == int.parse(serverMode),
      );
      modeFv = mode.value;
    }

    // todo: set brightness from server
    var serverBrightness = configModel.brightness;
    if (serverBrightness != null) {
      brightness.value = double.parse(serverBrightness);
      brightnessFv = brightness.value;
    }

    // todo: set speed from server
    var serverSpeed = configModel.speed;
    if (serverSpeed != null) {
      speed.value = int.parse(serverSpeed);
      speedFv = speed.value;
    }

    // todo: set color from server
    var serverColor = configModel.color;
    if (serverColor != null) {
      var colors = serverColor.split('.');
      var r = int.parse(colors[0]);
      var g = int.parse(colors[1]);
      var b = int.parse(colors[2]);
      color.value = Color.fromARGB(255, r, g, b);
      colorFv = color.value;
    }
  }

  void changeAutoEnable() => autoEnable.value = !autoEnable.value;

  void increaseAutoDelay() {
    if (autoDelay.value < (1024 * 64)) {
      autoDelay.value *= 2;
    }
  }

  void decreaseAutoDelay() {
    if (autoDelay.value > 1024 * 4) {
      autoDelay.value ~/= 2;
    }
  }

  // bool isModeSelected(
  //   ModeModel model,
  // ) =>
  //     model.id == (mode.value?.id ?? -1);

  // void changeMode(ModeModel model) {
  //   mode.value = model;
  //   Get.back();
  // }

  void selectMode() {
    var isSingle = !autoEnable.value;
    Map<String, dynamic> arguments = {
      'isSingle': isSingle,
      'selected': isSingle ? mode.value?.toJson() : autoValues['v'],
    };

    Get.toNamed(
      Routes.pickMode,
      arguments: arguments,
    )?.then((result) {
      print(result);
      if (result != null) {
        if (isSingle) {
          mode.value = ModeModel.fromJson(result);
        } else {
          autoValues['n'] = (result as List).length;
          autoValues['v'] = result;
        }
      }
    });
  }

  void changeBrightness(value) => brightness.value = value;

  void increaseSpeed() {
    if (speed.value < (1024 * 16)) {
      speed.value *= 2;
    }
  }

  void decreaseSpeed() {
    if (speed.value > 512) {
      speed.value ~/= 2;
    }
  }

  void changeColor(Color color) => this.color.value = color;

  bool get isPublishing => mqttService.publishQueue.isNotEmpty;

  void publish({
    required DeviceModel model,
  }) {
    print('--------------------------------------------');
    mqttService.publishQueue.listen((list) {
      print(list);
    });

    if (modeFv?.id != mode.value?.id) {
      _addTopicQueue(model, 'mode');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'mode',
        payload: '${mode.value?.id ?? -1}',
      );
    }

    if (brightnessFv != brightness.value) {
      _addTopicQueue(model, 'brightness');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'brightness',
        payload: '${brightness.value.toInt()}',
      );
    }

    if (speedFv != speed.value) {
      _addTopicQueue(model, 'speed');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'speed',
        payload: '${speed.value}',
      );
    }

    if (colorFv != color.value) {
      _addTopicQueue(model, 'color');

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

    if (autoEnableFv != autoEnable.value) {
      _addTopicQueue(model, 'auto');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'auto',
        payload: autoEnable.value ? '1' : '0',
      );
    }

    if (autoDelayFv != autoDelay.value) {
      _addTopicQueue(model, 'auto_delay');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'auto_delay',
        payload: autoDelay.value.toString(),
      );
    }

    if (jsonEncode(autoValuesFv) != jsonEncode(autoValues)) {
      _addTopicQueue(model, 'auto_values');

      _mqttRepository.publish(
        deviceId: model.id,
        specificTopic: 'auto_values',
        payload: jsonEncode(autoValues),
      );
    }

    // todo: add publish queue
    // var listTopics = [
    //   'mode',
    //   'brightness',
    //   'speed',
    //   'color',
    //   'auto',
    //   'auto_delay',
    //   'auto_values',
    // ];
    // listTopics = listTopics
    //     .map(
    //       (e) => '${MqttData.prefix}-${model.id}/$e',
    //     )
    //     .toList();
    // mqttService.publishQueue.addAll(listTopics);
  }

  void _addTopicQueue(DeviceModel model, var configKey) {
    var topic = '${MqttData.prefix}-${model.id}/$configKey';
    mqttService.publishQueue.add(topic);
  }
}
