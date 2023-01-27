import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends GetView {
  final Widget body;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;

  const CustomCard({
    super.key,
    this.color,
    this.padding,
    this.margin,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    var isDark = Get.isDarkMode;

    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white.withOpacity(.08)
                : Colors.black.withOpacity(.08),
            blurRadius: 8,
          ),
        ],
        color: color ??
            (isDark ? const Color.fromARGB(255, 24, 24, 24) : Colors.white),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: body,
    );
  }
}
