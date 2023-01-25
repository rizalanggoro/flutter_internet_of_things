import 'package:flutter/material.dart';
import 'package:internet_of_things/data/enums/device_type.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/models/mode_model.dart';

class DeviceData {
  static final List<DeviceModel> listDevices = [
    DeviceModel(
      id: 'desk_led',
      name: 'Desk LED',
      iconData: Icons.emoji_objects_rounded,
      deviceType: DeviceType.ledStrip,
    ),
    DeviceModel(
      id: 'desk_led',
      name: 'Desk LED',
      iconData: Icons.emoji_objects_rounded,
      deviceType: DeviceType.ledStrip,
    ),
    DeviceModel(
      id: 'desk_led',
      name: 'Desk LED',
      iconData: Icons.emoji_objects_rounded,
      deviceType: DeviceType.ledStrip,
    ),
  ];

  static final List<ModeModel> _listBaseMode = [
    ModeModel(name: 'Static', id: 0),
    ModeModel(name: 'Blink', id: 1),
    ModeModel(name: 'Breath', id: 2),
    ModeModel(name: 'Color wipe', id: 3),
    ModeModel(name: 'Random color', id: 9),
    ModeModel(name: 'Rainbow', id: 11),
    ModeModel(name: 'Rainbow cycle', id: 12),
    ModeModel(name: 'Scan', id: 13),
    ModeModel(name: 'Dual scan', id: 14),
    ModeModel(name: 'Running random', id: 42),
    ModeModel(name: 'Fire flicker', id: 49),
    ModeModel(name: 'Twinkle fox', id: 55),
  ];

  static final List<ModeModel> listModeLedStrip = [
    ..._listBaseMode,
  ];
}
