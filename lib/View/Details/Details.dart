// ignore_for_file: must_be_immutable

import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/View/DrawerData/Drawerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.addUrl, required this.padding});
  String addUrl;
  double padding;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: mainColor,
              title: Center(
                child: Image.asset(
                  "${baseURl}top_logo.png",
                  height: 40,
                ),
              )),
          endDrawer: const Drawerdata(),
          backgroundColor: const Color.fromARGB(234, 255, 250, 207),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(padding),
                child: Image.asset("$baseURl$addUrl"),
              ),
            ],
          )),
    );
  }
}

class intro extends StatelessWidget {
  const intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: mainColor,
              title: Center(
                child: Image.asset(
                  "${baseURl}top_logo.png",
                  height: 40,
                ),
              )),
          endDrawer: const Drawerdata(),
          backgroundColor: const Color.fromARGB(234, 255, 250, 207),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("${baseURl}bab_1.png"),
                const SizedBox(
                  height: 60,
                ),
                Image.asset("${baseURl}bab_2.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_3.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_4.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_5.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_6.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_7.png"),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("${baseURl}bab_8.png"),
              ],
            ),
          )),
    );
  }
}

class Taqdeem extends StatelessWidget {
  Taqdeem({super.key});
  final AyatPageController controller = Get.find<AyatPageController>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text(
              "تقدیم",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
            backgroundColor: mainColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          endDrawer: const Drawerdata(),
          backgroundColor: bgColor,
          body: ListView.builder(
              itemCount: controller.taqdeemData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    controller.taqdeemData[index]["ArabicName"],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              })),
    );
  }
}
