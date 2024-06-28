// ignore_for_file: must_be_immutable

import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/View/Ayat/AyatTranslation/AyatTranslation.dart';
import 'package:bayanulquran/View/DrawerData/Drawerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ayatnumbers extends StatelessWidget {
  Ayatnumbers({
    super.key,
    required this.title,
    required this.suratnumber,
    required this.surahData,
    required this.pageTitle,
    required this.surahId,
  });

  String pageTitle;
  final List<String> title;
  final List<String> suratnumber;
  final List<String> surahData;
  final int surahId;

  final AyatPageController controller = Get.find<AyatPageController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (title.length == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Ayattranslation(
                    surahID: surahId,
                    title: pageTitle,
                    suratNum: suratnumber,
                    pagesdata: surahData,
                    initialPage: 0,
                  )),
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mainColor,
          title: Center(
            child: Text(
              pageTitle,
              style: TextStyle(color: Colors.white, fontFamily: noorehuda),
            ),
          ),
        ),
        endDrawer: const Drawerdata(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => Ayattranslation(
                              surahID: surahId,
                              title: pageTitle,
                              suratNum: suratnumber,
                              pagesdata: surahData,
                              initialPage: index,
                            ));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.article_outlined, color: mainColor),
                              const SizedBox(width: 4),
                              Text(
                                title[index],
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
