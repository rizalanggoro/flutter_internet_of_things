import 'package:get/get.dart';
import 'package:internet_of_things/modules/device/device_controller.dart';

class DeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceController());
  }
}
