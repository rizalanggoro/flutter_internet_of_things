import 'package:get/get.dart';
import 'package:internet_of_things/data/enums/mqtt_state.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';
import 'package:internet_of_things/data/values/device_data.dart';

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
