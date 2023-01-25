import 'package:get/get.dart';
import 'package:internet_of_things/data/enums/mqtt_state.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';

class MqttService extends GetxService {
  final Rx<MqttState> mqttState = Rx(MqttState.disconnected);

  @override
  void onReady() {
    Get.find<MqttRepository>().openConnection();
  }
}
