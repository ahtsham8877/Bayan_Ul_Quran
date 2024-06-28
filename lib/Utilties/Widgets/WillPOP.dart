import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WillPOP {
  Future<bool?> showMyDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(""),
            content: Text(
              "کیا آپ اس ایپ کو بند کر رہے ہیں؟ ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: mainfont),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "نہیں",
                    style: TextStyle(
                        fontFamily: mainfont, fontSize: 20, color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    "جی ہاں",
                    style: TextStyle(fontFamily: mainfont, fontSize: 20),
                  )),
            ],
          );
        });
  }
}
