import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  final ToastGravity gravity;
  final Color color;

  ShowToast({
    this.gravity = ToastGravity.BOTTOM,
    this.color = Colors.red,
  });

  void showToastMessage(BuildContext context, String text,
      {Color? color, TextStyle? textStyle}) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color ?? this.color,
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontFamily:mainfont,
            ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
