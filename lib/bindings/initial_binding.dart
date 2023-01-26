import 'package:get/get.dart';

import '../data/repositories/mqtt_repository.dart';
import '../services/mqtt_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MqttService(), permanent: true);
    Get.put(MqttRepository(), permanent: true);
  }
}
