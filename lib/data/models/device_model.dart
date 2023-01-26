import 'package:flutter/widgets.dart';

import '../enums/device_type.dart';
import 'device_config_model.dart';

class DeviceModel {
  final String id;
  final String name;
  final IconData iconData;
  final DeviceType deviceType;
  final DeviceConfigModel config;

  DeviceModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.deviceType,
    required this.config,
  });
}
