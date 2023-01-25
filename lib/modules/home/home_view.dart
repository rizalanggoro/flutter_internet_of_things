import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_of_things/data/enums/mqtt_state.dart';
import 'package:internet_of_things/data/models/device_config_model.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/values/mqtt_data.dart';
import 'package:internet_of_things/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Get.textTheme;
    var colorScheme = Get.theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo: safe area
            SafeArea(child: Container()),

            Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 32,
              ),
              child: Text(
                'Internet of Things',
                style: TextStyle(
                  fontSize: textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // todo: card connection status
            Container(
              margin: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 32,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 8)
                ],
              ),
              child: Container(
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
                                color:
                                    colorScheme.onBackground.withOpacity(.64),
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
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 32,
                right: 32,
                left: 32,
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

                  return _listItemDevice(
                    index: index,
                    model: model,
                  );
                },
                itemCount: listDevice.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
              ),
              controller.mqttService.listDevice,
            ),
          ],
        ),
      ),
    );
  }

  Container _listItemDevice({
    required int index,
    required DeviceModel model,
  }) {
    var colorScheme = Get.theme.colorScheme;
    var textTheme = Get.textTheme;
    var isOnline = model.config?.status == 'on';

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        left: 32,
        right: 32,
        top: index == 0 ? 16 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.showDevice(model),
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
