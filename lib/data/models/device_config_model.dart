class DeviceConfigModel {
  String? mode;
  String? brightness;
  String? speed;
  String? color;
  String? status;
  String? autoEnable;
  String? autoDelay;
  String? autoValues;

  DeviceConfigModel({
    this.mode,
    this.brightness,
    this.speed,
    this.color,
    this.status,
    this.autoEnable,
    this.autoDelay,
    this.autoValues,
  });

  bool _notNull(String? a) => a != null;

  bool get isReady =>
      _notNull(mode) &&
      _notNull(brightness) &&
      _notNull(speed) &&
      _notNull(color) &&
      _notNull(status) &&
      _notNull(autoEnable) &&
      _notNull(autoDelay) &&
      _notNull(autoValues);
}
