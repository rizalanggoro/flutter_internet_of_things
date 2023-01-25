import 'package:flutter/widgets.dart';
import 'package:internet_of_things/data/enums/device_type.dart';

class DeviceModel {
  final String id;
  final String name;
  final IconData iconData;
  final DeviceType deviceType;

  DeviceModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.deviceType,
  });
}
