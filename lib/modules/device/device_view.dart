import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_of_things/data/models/device_model.dart';
import 'package:internet_of_things/data/values/mqtt_data.dart';
import 'package:internet_of_things/modules/device/device_controller.dart';
import 'package:internet_of_things/widgets/custom_card.dart';

class DeviceView extends GetView<DeviceController> {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Get.arguments as DeviceModel;

    var colorScheme = Get.theme.colorScheme;
    var textTheme = Get.textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    left: 32,
                    top: 32,
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
                    left: 32,
                    right: 32,
                    top: 32,
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
                    left: 32,
                    right: 32,
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
                    left: 32,
                    right: 32,
                  ),
                  child: Text(
                    '${MqttData.prefix}-${model.id}',
                    style: TextStyle(
                      color: colorScheme.onBackground.withOpacity(.64),
                      fontSize: textTheme.bodySmall!.fontSize,
                    ),
                  ),
                ),

                // todo: mode
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 32,
                  ),
                  body: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _showBottomSheetPickMode(),
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
                                    (mode) => Text(
                                      mode.value?.name ?? 'No data',
                                      style: TextStyle(
                                        color: colorScheme.onBackground
                                            .withOpacity(.64),
                                      ),
                                    ),
                                    controller.mode,
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

                // todo: brightness
                CustomCard(
                  margin: const EdgeInsets.only(
                    left: 32,
                    right: 32,
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
              ],
            ),
          ),

          // todo: button apply
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(32),
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
                child: InkWell(
                  onTap: () => controller.publish(
                    model: model,
                  ),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_rounded,
                          color: colorScheme.onPrimary,
                          size: textTheme.bodyLarge!.fontSize,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Publish',
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
        ],
      ),
    );
  }

  void _showBottomSheetPickMode() {
    var textTheme = Get.textTheme;
    var colorScheme = Get.theme.colorScheme;

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 32,
                ),
                child: Text(
                  'Select mode',
                  style: TextStyle(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: textTheme.headlineSmall!.fontSize,
                  ),
                ),
              ),

              // todo: list mode
              ListView.builder(
                itemBuilder: (context, index) {
                  var model = controller.listMode[index];
                  var isSelected = controller.isModeSelected(model);

                  return Column(
                    children: [
                      // todo: divider
                      if (index != 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          color: colorScheme.onBackground.withOpacity(.08),
                          width: double.infinity,
                          height: 1.32,
                        ),

                      Container(
                        margin: EdgeInsets.only(
                          top: index == 0 ? 16 : 0,
                          bottom:
                              index == controller.listMode.length - 1 ? 32 : 0,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => controller.changeMode(model),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 32,
                                      right: 16,
                                    ),
                                    child: Icon(
                                      isSelected
                                          ? Icons.radio_button_checked_rounded
                                          : Icons
                                              .radio_button_unchecked_rounded,
                                      color: isSelected
                                          ? colorScheme.primary
                                          : colorScheme.primary
                                              .withOpacity(.32),
                                    ),
                                  ),
                                  Text(
                                    model.name,
                                    style: TextStyle(
                                      color: colorScheme.onBackground,
                                      fontSize: textTheme.bodyLarge!.fontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: controller.listMode.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        );
      },
    );
  }
}
