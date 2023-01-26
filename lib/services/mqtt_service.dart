import 'package:get/get.dart';

import '../data/enums/mqtt_state.dart';
import '../data/models/device_model.dart';
import '../data/repositories/mqtt_repository.dart';
import '../data/values/device_data.dart';

class MqttService extends GetxService {
  final Rx<MqttState> mqttState = Rx(MqttState.disconnected);
  final RxList<DeviceModel> listDevice = RxList();
  final RxList<String> publishQueue = RxList([]);

  @override
  void onReady() {
    Get.find<MqttRepository>().openConnection();

    // todo: init first value list device config
    listDevice.addAll(DeviceData.listDevices);
  }
}
