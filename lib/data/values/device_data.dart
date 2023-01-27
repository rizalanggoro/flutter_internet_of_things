import 'package:flutter/material.dart';

import '../enums/device_type.dart';
import '../models/device_config_model.dart';
import '../models/device_model.dart';
import '../models/mode_model.dart';

class DeviceData {
  static final List<DeviceModel> listDevices = [
    DeviceModel(
      id: 'desk_led',
      name: 'Desk LED',
      iconData: Icons.emoji_objects_rounded,
      deviceType: DeviceType.ledStrip,
      config: DeviceConfigModel(),
    ),
    DeviceModel(
      id: 'bedroom_led',
      name: 'Bedroom LED',
      iconData: Icons.emoji_objects_rounded,
      deviceType: DeviceType.ledStrip,
      config: DeviceConfigModel(),
    ),
  ];

  static final List<ModeModel> _listBaseMode = [
    const ModeModel(name: 'Static', id: 0),
    const ModeModel(name: 'Blink', id: 1),
    const ModeModel(name: 'Breath', id: 2),
    const ModeModel(name: 'Color Wipe', id: 3),
    const ModeModel(name: 'Color Wipe Inverse', id: 4),
    const ModeModel(name: 'Color Wipe Reverse', id: 5),
    const ModeModel(name: 'Color Wipe Reverse Inverse', id: 6),
    const ModeModel(name: 'Color Wipe Random', id: 7),
    const ModeModel(name: 'Random Color ', id: 8),
    const ModeModel(name: 'Random Color', id: 9),
    const ModeModel(name: 'Multi Dynamic', id: 10),
    const ModeModel(name: 'Rainbow', id: 11),
    const ModeModel(name: 'Rainbow Cycle', id: 12),
    const ModeModel(name: 'Scan', id: 13),
    const ModeModel(name: 'Dual Scan', id: 14),
    const ModeModel(name: 'Fade', id: 15),
    const ModeModel(name: 'Theater Chase', id: 16),
    const ModeModel(name: 'Theater Chase Rainbow', id: 17),
    const ModeModel(name: 'Running Lights', id: 18),
    const ModeModel(name: 'Twinkle', id: 19),
    const ModeModel(name: 'Twinkle Random', id: 20),
    const ModeModel(name: 'Twinkle Fade', id: 21),
    const ModeModel(name: 'Twinkle Fade Random', id: 22),
    const ModeModel(name: 'Sparkle', id: 23),
    const ModeModel(name: 'Flash Sparkle', id: 24),
    const ModeModel(name: 'Hyper Sparkle', id: 25),
    const ModeModel(name: 'Strobe', id: 26),
    const ModeModel(name: 'Strobe Rainbow', id: 27),
    const ModeModel(name: 'Multi Strobe', id: 28),
    const ModeModel(name: 'Blink Rainbow', id: 29),
    const ModeModel(name: 'Chase White', id: 30),
    const ModeModel(name: 'Chase Color', id: 31),
    const ModeModel(name: 'Chase Random', id: 32),
    const ModeModel(name: 'Chase Rainbow', id: 33),
    const ModeModel(name: 'Chase Flash', id: 34),
    const ModeModel(name: 'Chase Flash Random', id: 35),
    const ModeModel(name: 'Chase Rainbow White', id: 36),
    const ModeModel(name: 'Chase Blackout', id: 37),
    const ModeModel(name: 'Chase Blackout Rainbow', id: 38),
    const ModeModel(name: 'Color Sweep Random', id: 39),
    const ModeModel(name: 'Running Color', id: 40),
    const ModeModel(name: 'Running Red Blue', id: 41),
    const ModeModel(name: 'Running Random', id: 42),
    const ModeModel(name: 'Larson Scanner', id: 43),
    const ModeModel(name: 'Comet', id: 44),
    const ModeModel(name: 'Fireworks', id: 45),
    const ModeModel(name: 'Fireworks Random', id: 46),
    const ModeModel(name: 'Merry Christmas', id: 47),
    const ModeModel(name: 'Fire Flicker', id: 48),
    const ModeModel(name: 'Fire Flicker (soft)', id: 49),
    const ModeModel(name: 'Fire Flicker (intense)', id: 50),
    const ModeModel(name: 'Circus Combustus', id: 51),
    const ModeModel(name: 'Halloween', id: 52),
    const ModeModel(name: 'Bicolor Chase', id: 53),
    const ModeModel(name: 'Tricolor Chase', id: 54),
    const ModeModel(name: 'TwinkleFOX', id: 55),
  ];

  static final List<ModeModel> listModeLedStrip = [
    ..._listBaseMode,
  ];
}
