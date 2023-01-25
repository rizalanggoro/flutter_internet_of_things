import 'package:get/get.dart';
import 'package:internet_of_things/modules/device/device_binding.dart';
import 'package:internet_of_things/modules/device/device_view.dart';
import 'package:internet_of_things/modules/home/home_binding.dart';
import 'package:internet_of_things/modules/home/home_view.dart';

class Routes {
  static const home = '/';
  static const device = '/device';
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
  ];
}
