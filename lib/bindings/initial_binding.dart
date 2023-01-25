import 'package:get/get.dart';
import 'package:internet_of_things/data/repositories/mqtt_repository.dart';
import 'package:internet_of_things/services/mqtt_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MqttService(), permanent: true);
    Get.put(MqttRepository(), permanent: true);
  }
}
