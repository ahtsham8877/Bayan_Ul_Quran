// ignore_for_file: must_be_immutable

import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:flutter/material.dart';

class Drawertext extends StatelessWidget {
  Drawertext({
    super.key,
    required this.addText,
    required this.addURl,
    required this.ontap,
  });
  String addText;
  String addURl;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Row(
            children: [
              Image.asset(
                "${baseURl}$addURl",
                height: 25,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                addText,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
