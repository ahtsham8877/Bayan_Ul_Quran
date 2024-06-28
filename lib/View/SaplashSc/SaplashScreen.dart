// ignore_for_file: library_private_types_in_public_api

import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/View/HomePage/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaplashScreen extends StatefulWidget {
  const SaplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SaplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => Homepage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "${baseURl}splash.png",
            fit: BoxFit.cover,
          ),
        ));
  }
}
