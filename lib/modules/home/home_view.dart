import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/enums/mqtt_state.dart';
import '../../data/models/device_model.dart';
import '../../data/values/mqtt_data.dart';
import '../../routes/app_pages.dart';
import '../../widgets/custom_card.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Get.textTheme;
    var colorScheme = context.theme.colorScheme;
    var isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo: safe area
            SafeArea(child: Container()),

            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Text(
                'Internet of Things',
                style: TextStyle(
                  fontSize: textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
            ),

            // todo: card dark mode
            CustomCard(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: colorScheme.primaryContainer,
                      ),
                      child: Icon(
                        Icons.wb_sunny_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Dark mode',
                        style: TextStyle(
                          color: colorScheme.onBackground,
                          fontSize: textTheme.bodyLarge!.fontSize,
                        ),
                      ),
                    ),
                    ObxValue(
                      (isDark) => Switch(
                        value: isDark.value,
                        onChanged: (value) =>
                            controller.changeAppBrightness(value),
                      ),
                      controller.isDark,
                    ),
                  ],
                ),
              ),
            ),

            // todo: card connection status
            CustomCard(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 8,
              ),
              padding: const EdgeInsets.all(16),
              body: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: colorScheme.primaryContainer,
                    ),
                    child: ObxValue(
                      (state) => Icon(
                        state.value == MqttState.connected
                            ? Icons.wifi_rounded
                            : state.value == MqttState.connecting
                                ? Icons.wifi_protected_setup_rounded
                                : Icons.wifi_off,
                        color: colorScheme.primary,
                      ),
                      controller.mqttService.mqttState,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connection status',
                          style: TextStyle(
                            fontSize: textTheme.bodyLarge!.fontSize,
                            color: colorScheme.onBackground,
                          ),
                        ),
                        ObxValue(
                          (state) => Text(
                            state.value == MqttState.connected
                                ? 'Connected!'
                                : state.value == MqttState.connecting
                                    ? 'Connecting...'
                                    : 'Disconnected!',
                            style: TextStyle(
                              color: colorScheme.onBackground.withOpacity(.64),
                            ),
                          ),
                          controller.mqttService.mqttState,
                        ),
                        Text(
                          '${MqttData.broker}:${MqttData.port}',
                          style: TextStyle(
                            fontSize: textTheme.bodySmall!.fontSize,
                            color: colorScheme.onBackground.withOpacity(.64),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                right: 24,
                left: 24,
              ),
              child: Text(
                'Devices',
                style: TextStyle(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: textTheme.bodyLarge!.fontSize,
                ),
              ),
            ),

            // todo: list devices
            ObxValue(
              (listDevice) => ListView.builder(
                itemBuilder: (context, index) {
                  var model = listDevice[index];
                  var enabled = model.config.isReady;

                  return Opacity(
                    opacity: enabled ? 1 : .64,
                    child: _listItemDevice(
                      enabled: enabled,
                      index: index,
                      model: model,
                    ),
                  );
                },
                itemCount: listDevice.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
              ),
              controller.mqttService.listDevice,
            ),

            // todo: card reset device
            CustomCard(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 48,
                bottom: 48,
              ),
              body: Material(
                color: Colors.transparent,
                child: InkWell(
                  onLongPress: () => Get.toNamed(Routes.reset),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: colorScheme.errorContainer,
                          ),
                          child: Icon(
                            Icons.restore_rounded,
                            color: colorScheme.error,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reset device',
                                style: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: textTheme.bodyLarge!.fontSize,
                                ),
                              ),
                              Text(
                                'This action is irreversible',
                                style: TextStyle(
                                  color: colorScheme.error.withOpacity(.64),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: colorScheme.onBackground.withOpacity(.32),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _listItemDevice({
    required bool enabled,
    required int index,
    required DeviceModel model,
  }) {
    var colorScheme = Get.theme.colorScheme;
    var textTheme = Get.textTheme;
    var isOnline = model.config.status == 'on';

    return CustomCard(
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        top: index == 0 ? 16 : 8,
      ),
      body: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? () => controller.showDevice(model) : null,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Icon(
                    model.iconData,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          color: colorScheme.onBackground,
                          fontSize: textTheme.bodyLarge!.fontSize,
                        ),
                      ),
                      Text(
                        model.id,
                        style: TextStyle(
                          color: colorScheme.onBackground.withOpacity(.64),
                        ),
                      ),

                      // todo: device status
                      Container(
                        margin: const EdgeInsets.only(
                          top: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? colorScheme.primary
                              : colorScheme.error,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: Text(
                          isOnline ? 'online' : 'offline',
                          style: TextStyle(
                            fontSize: textTheme.bodySmall!.fontSize,
                            color: isOnline
                                ? colorScheme.onPrimary
                                : colorScheme.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onBackground.withOpacity(.32),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
