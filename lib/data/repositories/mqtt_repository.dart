import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../services/mqtt_service.dart';
import '../enums/mqtt_state.dart';
import '../values/device_data.dart';
import '../values/mqtt_data.dart';

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
        retain: true,
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
    _listenUpdates();
  }

  void _onDisconnected() {
    _mqttService.mqttState.value = MqttState.disconnected;
  }

  void _onAutoReconnect() {
    _mqttService.mqttState.value = MqttState.connecting;
  }

  void _onAutoReconnected() {
    _mqttService.mqttState.value = MqttState.connected;
    _listenUpdates();
  }

  void _listenUpdates() {
    // todo: subscribe to all devices
    for (var model in DeviceData.listDevices) {
      var topic = '${MqttData.prefix}-${model.id}/#';

      client.subscribe(topic, MqttQos.exactlyOnce);
    }

    // todo: listen update from broker
    client.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage?>>? message) {
        final topic = message![0].topic;
        final recMessage = message[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
          recMessage.payload.message,
        );

        var deviceId =
            topic.substring(MqttData.prefix.length + 1, topic.indexOf('/'));
        var configKey = topic.substring(topic.indexOf('/') + 1);
        var listConfigIndex = _mqttService.listDevice
            .indexWhere((element) => element.id == deviceId);

        if (listConfigIndex != -1) {
          if (configKey == 'mode') {
            _mqttService.listDevice[listConfigIndex].config.mode = payload;
          } else if (configKey == 'brightness') {
            _mqttService.listDevice[listConfigIndex].config.brightness =
                payload;
          } else if (configKey == 'speed') {
            _mqttService.listDevice[listConfigIndex].config.speed = payload;
          } else if (configKey == 'color') {
            _mqttService.listDevice[listConfigIndex].config.color = payload;
          } else if (configKey == 'status') {
            _mqttService.listDevice[listConfigIndex].config.status = payload;
          }

          _mqttService.listDevice.refresh();
        }
      },
    );

    // todo: listen publish
    client.published!.listen((MqttPublishMessage message) {
      var topic = message.variableHeader!.topicName;

      if (_mqttService.publishQueue.contains(topic)) {
        _mqttService.publishQueue.remove(topic);
      }
    });
  }
}
