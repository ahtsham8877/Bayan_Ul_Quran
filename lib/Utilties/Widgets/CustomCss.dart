import 'dart:ui';

import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomCss extends StatelessWidget {
  CustomCss(
      {super.key,
      required this.add_text,
      required this.font_family,
      this.addColor,
      this.addfontWeight,
      required this.font_size,
      this.textAlign,
      this.textDecoration});
  final add_text;
  String font_family;
  int font_size;
  Color? addColor;
  FontWeight? addfontWeight;
  TextDecoration? textDecoration;
  TextAlign? textAlign;
  final controller = Get.find<AyatPageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        add_text,
        textAlign: textAlign,
        style: TextStyle(
            decoration: textDecoration,
            decorationColor: const Color.fromARGB(255, 0, 9, 128),
            fontFamily: font_family,
            height: 2,
            fontSize: font_size + controller.pagefontSize.value.toDouble(),
            fontWeight: addfontWeight,
            color: addColor),
      ),
    );
  }
}
