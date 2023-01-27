import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_of_things/widgets/custom_card.dart';

import 'pick_mode_controller.dart';

class PickModeView extends GetView<PickModeController> {
  const PickModeView({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = context.theme.colorScheme;
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

                // todo: button back
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(
                    left: 24,
                    top: 24,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),

                // todo: title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 24,
                    right: 24,
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

                // todo: list
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    var model = controller.listMode[index];

                    return CustomCard(
                      margin: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: index == 0 ? 24 : 8,
                      ),
                      body: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.isSingle
                              ? () => controller.selectSingle(model)
                              : () => controller.selectMultiple(model),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Obx(
                                  () {
                                    if (controller.isSingle) {
                                      var isSelected =
                                          controller.isSingleSelected(model);

                                      return Icon(
                                        isSelected
                                            ? Icons.radio_button_checked_rounded
                                            : Icons
                                                .radio_button_unchecked_rounded,
                                        color: isSelected
                                            ? colorScheme.primary
                                            : colorScheme.primaryContainer,
                                      );
                                    } else {
                                      var isMultipleSelected =
                                          controller.isMultipleSelected(model);

                                      return Icon(
                                        isMultipleSelected
                                            ? Icons.check_box_rounded
                                            : Icons
                                                .check_box_outline_blank_rounded,
                                        color: isMultipleSelected
                                            ? colorScheme.primary
                                            : colorScheme.primaryContainer,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    model.name,
                                    style: TextStyle(
                                      color: colorScheme.onBackground
                                          .withOpacity(.64),
                                      fontSize: textTheme.bodyLarge!.fontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.listMode.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),

                // todo: spacer
                const SizedBox(height: 48 * 2),
              ],
            ),
          ),

          // todo: button done
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
                child: InkWell(
                  onTap: () => controller.done(),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done_rounded,
                          color: colorScheme.onPrimary,
                          size: textTheme.bodyLarge!.fontSize,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Done',
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
}
