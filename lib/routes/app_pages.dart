import 'package:get/get.dart';

import '../modules/device/device_binding.dart';
import '../modules/device/device_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/pick_mode/pick_mode_binding.dart';
import '../modules/pick_mode/pick_mode_view.dart';

class Routes {
  static const home = '/';
  static const device = '/device';
  static const pickMode = '/pick-mode';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.device,
      page: () => const DeviceView(),
      binding: DeviceBinding(),
    ),
    GetPage(
      name: Routes.pickMode,
      page: () => const PickModeView(),
      binding: PickModeBinding(),
    ),
  ];
}
