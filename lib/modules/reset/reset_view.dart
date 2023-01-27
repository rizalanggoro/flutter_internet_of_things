import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_of_things/widgets/custom_card.dart';

import 'reset_controller.dart';

class ResetView extends GetView<ResetController> {
  const ResetView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo: safe area
            SafeArea(child: Container()),

            ListView.builder(
              itemBuilder: (context, index) {
                var model = controller.listDevice[index];

                return CustomCard(
                  margin: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: index == 0 ? 24 : 8,
                  ),
                  body: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onLongPress: () => controller.reset(model),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.listDevice.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
