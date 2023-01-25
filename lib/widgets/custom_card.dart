import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends GetView {
  final Widget body;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CustomCard({
    super.key,
    this.padding,
    this.margin,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: body,
    );
  }
}
