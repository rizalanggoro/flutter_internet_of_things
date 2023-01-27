import 'package:get/get.dart';

import 'reset_controller.dart';

class ResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetController());
  }
}
