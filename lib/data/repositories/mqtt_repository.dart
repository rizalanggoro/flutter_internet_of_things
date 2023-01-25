import 'dart:math';

import 'package:get/get.dart';
import 'package:internet_of_things/data/enums/mqtt_state.dart';
import 'package:internet_of_things/data/values/mqtt_data.dart';
import 'package:internet_of_things/services/mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttRepository {
  late MqttServerClient client;
  final MqttService _mqttService = Get.find();

  void publish({
    required String deviceId,
    required String specificTopic,
    required String payload,
  }) {
    if (_mqttService.mqttState.value == MqttState.connected) {
      var topic = '${MqttData.prefix}-$deviceId/$specificTopic';
      var data = MqttClientPayloadBuilder();
      data.addString(payload);

      client.publishMessage(
        topic,
        MqttQos.exactlyOnce,
        data.payload!,
      );
    }
  }

  void openConnection() {
    var randNum = DateTime.now().toIso8601String();
    var clientId = '${MqttData.prefix}-$randNum';

    client = MqttServerClient(MqttData.broker, clientId);
    client.setProtocolV311();
    client.autoReconnect = true;

    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onAutoReconnect = _onAutoReconnect;
    client.onAutoReconnected = _onAutoReconnected;

    // todo: open connection
    try {
      _mqttService.mqttState.value = MqttState.connecting;
      client.connect();
    } catch (error) {
      _mqttService.mqttState.value = MqttState.disconnected;
      client.disconnect();

      print(error.toString());
    }
  }

  void _onConnected() {
    _mqttService.mqttState.value = MqttState.connected;
  }

  void _onDisconnected() {
    _mqttService.mqttState.value = MqttState.disconnected;
  }

  void _onAutoReconnect() {
    _mqttService.mqttState.value = MqttState.connecting;
  }

  void _onAutoReconnected() {
    _mqttService.mqttState.value = MqttState.connected;
  }
}
