import 'package:get/get.dart';
import 'pick_mode_controller.dart';

class PickModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PickModeController());
  }
}
