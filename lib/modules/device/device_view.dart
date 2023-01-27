import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../data/models/device_model.dart';
import '../../data/values/mqtt_data.dart';
import '../../widgets/custom_card.dart';
import 'device_controller.dart';

class DeviceView extends GetView<DeviceController> {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Get.arguments as DeviceModel;

    var colorScheme = Get.theme.colorScheme;
    var textTheme = Get.textTheme;

    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.grey.shade50,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // todo: safe area
                SafeArea(child: Container()),

                // todo: back button
                Container(
                  height: 48,
                  width: 48,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    color: colorScheme.primaryContainer,
                  ),
                  margin: const EdgeInsets.only(
                    left: 24,
                    top: 24,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                // todo: title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                  ),
                  child: Text(
                    model.name,
                    style: TextStyle(
                      color: colorScheme.onBackground,
                      fontSize: textTheme.headlineSmall!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Text(
                    model.id,
                    style: TextStyle(
                      color: colorScheme.onBackground.withOpacity(.64),
                      fontSize: textTheme.bodyLarge!.fontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Text(
                    '${MqttData.prefix}-${model.id}',
                    style: TextStyle(
                      color: colorScheme.onBackground.withOpacity(.64),
                      fontSize: textTheme.bodySmall!.fontSize,
                    ),
                  ),
                ),

                // todo: auto
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                  ),
                  body: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.changeAutoEnable(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                Icons.auto_mode_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Auto',
                                    style: TextStyle(
                                      color: colorScheme.onBackground,
                                      fontSize: textTheme.bodyLarge!.fontSize,
                                    ),
                                  ),
                                  Text(
                                    'The mode will change automatically according to the specified interval',
                                    style: TextStyle(
                                      color: colorScheme.onBackground
                                          .withOpacity(.64),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Obx(
                              () => Switch(
                                value: controller.autoEnable.value,
                                onChanged: (_) => controller.changeAutoEnable(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // todo: auto delay
                ObxValue(
                  (autoEnable) => autoEnable.value
                      ? CustomCard(
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 8,
                          ),
                          padding: const EdgeInsets.all(16),
                          body: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Icon(
                                  Icons.speed_rounded,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Auto interval',
                                      style: TextStyle(
                                        color: colorScheme.onBackground,
                                        fontSize: textTheme.bodyLarge!.fontSize,
                                      ),
                                    ),
                                    ObxValue(
                                      (autoDelay) => Text(
                                        '${autoDelay.value} ms',
                                        style: TextStyle(
                                          color: colorScheme.onBackground
                                              .withOpacity(.64),
                                          fontSize:
                                              textTheme.bodyMedium!.fontSize,
                                        ),
                                      ),
                                      controller.autoDelay,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => controller.decreaseAutoDelay(),
                                icon: Icon(
                                  Icons.remove_rounded,
                                  color: colorScheme.secondary,
                                ),
                              ),
                              IconButton(
                                onPressed: () => controller.increaseAutoDelay(),
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  controller.autoEnable,
                ),

                // todo: mode
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                  ),
                  body: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.selectMode(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                Icons.category_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mode',
                                    style: TextStyle(
                                      color: colorScheme.onBackground,
                                      fontSize: textTheme.bodyLarge!.fontSize,
                                    ),
                                  ),
                                  ObxValue(
                                    (autoEnable) {
                                      var isAuto = autoEnable.value;

                                      if (!isAuto) {
                                        return ObxValue(
                                          (mode) => Text(
                                            mode.value?.name ?? 'No data',
                                            style: TextStyle(
                                              color: colorScheme.onBackground
                                                  .withOpacity(.64),
                                            ),
                                          ),
                                          controller.mode,
                                        );
                                      } else {
                                        return ObxValue(
                                          (autoValues) {
                                            var count = autoValues['n'];
                                            var selectedMultipleMode =
                                                controller.listMode
                                                    .where(
                                                      (element) => (controller
                                                                  .autoValues[
                                                              'v'] as List)
                                                          .contains(element.id),
                                                    )
                                                    .map((e) => e.name)
                                                    .toList();

                                            return Text(
                                              count > 0
                                                  ? selectedMultipleMode
                                                      .toString()
                                                      .replaceAll('[', '')
                                                      .replaceAll(']', '')
                                                  : 'All',
                                              style: TextStyle(
                                                color: colorScheme.onBackground
                                                    .withOpacity(.64),
                                              ),
                                            );
                                          },
                                          controller.autoValues,
                                        );
                                      }
                                    },
                                    controller.autoEnable,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color:
                                    colorScheme.onBackground.withOpacity(.32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // todo: brightness
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Text(
                          'Brightness',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ObxValue(
                        (brightness) => Slider(
                          value: brightness.value,
                          onChanged: (value) =>
                              controller.changeBrightness(value),
                          max: 250,
                          divisions: 10,
                        ),
                        controller.brightness,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            bottom: 16,
                          ),
                          child: ObxValue(
                            (brightness) => Text(
                              '${brightness.value.toInt()}/250',
                              style: TextStyle(
                                fontSize: textTheme.bodySmall!.fontSize,
                                color:
                                    colorScheme.onBackground.withOpacity(.64),
                              ),
                            ),
                            controller.brightness,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // todo: speed
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
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          Icons.speed_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Speed',
                              style: TextStyle(
                                color: colorScheme.onBackground,
                                fontSize: textTheme.bodyLarge!.fontSize,
                              ),
                            ),
                            ObxValue(
                              (speed) => Text(
                                '${speed.value} ms',
                                style: TextStyle(
                                  color:
                                      colorScheme.onBackground.withOpacity(.64),
                                  fontSize: textTheme.bodyMedium!.fontSize,
                                ),
                              ),
                              controller.speed,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.decreaseSpeed(),
                        icon: Icon(
                          Icons.remove_rounded,
                          color: colorScheme.secondary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.increaseSpeed(),
                        icon: Icon(
                          Icons.add_rounded,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // todo: color
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Text(
                          'Color',
                          style: TextStyle(
                            fontSize: textTheme.bodyLarge!.fontSize,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ObxValue(
                        (color) => ColorPicker(
                          pickerColor: color.value,
                          onColorChanged: (value) =>
                              controller.changeColor(value),
                          enableAlpha: false,
                          hexInputBar: false,
                          labelTypes: const [],
                          displayThumbColor: false,
                          pickerAreaBorderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        controller.color,
                      ),
                    ],
                  ),
                ),

                // todo: spacer
                const SizedBox(
                  height: 48 + 48,
                ),
              ],
            ),
          ),

          // todo: button apply
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.16),
                    blurRadius: 8,
                  ),
                ],
                color: colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Obx(
                  () => InkWell(
                    onTap: controller.isPublishing
                        ? null
                        : () => controller.publish(model: model),
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.isPublishing
                                ? Icons.sync_rounded
                                : Icons.upload_rounded,
                            color: colorScheme.onPrimary,
                            size: textTheme.bodyLarge!.fontSize,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            controller.isPublishing
                                ? 'Publishing...'
                                : 'Publish',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // todo: container publish
          Obx(
            () => controller.isPublishing
                ? Container(
                    width: double.infinity,
                    color: colorScheme.onBackground.withOpacity(.84),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Publishing',
                          style: TextStyle(
                            color: colorScheme.background,
                            fontSize: textTheme.headlineSmall!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Please wait a moment...',
                          style: TextStyle(
                            color: colorScheme.background.withOpacity(.64),
                            fontSize: textTheme.bodyLarge!.fontSize,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
