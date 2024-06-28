import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/View/Ayat/AyatNumbers/AyatNumbers.dart';
import 'package:bayanulquran/View/Ayat/AyatView/AyatsView.dart';

import 'package:bayanulquran/View/DrawerData/Drawerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ayatnames extends StatelessWidget {
  Ayatnames({super.key, required this.ShowAyats});
  final bool ShowAyats;
  final AyatPageController controller = Get.find<AyatPageController>();

  Map<String, List<String>> getData(int suratID) {
    List<String> listofIDs = [];
    List<String> surahNum = [];
    List<String> surahData = [];
    List<String> suratnumber = [];

    for (var element in controller.quranData) {
      if (element["surah_id"] == suratID) {
        listofIDs.add(element["Arabic_"]);
        surahNum.add(element["Urdu"]);
        surahData.add(element["Arabic"]);
        suratnumber.add(element["ayah_location"]);
      }
    }

    return {
      'listofIDs': listofIDs,
      'surahNum': surahNum,
      'surahData': surahData,
      'suratnumber': suratnumber,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mainColor,
          title: Center(
            child: Image.asset(
              "${baseURl}top_logo.png",
              height: 40,
            ),
          ),
        ),
        endDrawer: const Drawerdata(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.ayatdata.length,
                itemBuilder: (context, index) {
                  final ayatNames = controller.ayatdata[index];
                  final suratID = ayatNames["SurahNo"];
                  final suratName = ayatNames["SurahName"];

                  final data = getData(suratID);

                  return InkWell(
                    onTap: () {
                      print(
                          "Surata data ${data['surahNum']!} surata id   $suratID ");
                      print(
                          "Ayat names in view ${data['listofIDs']} and surah num ${data['suratnumber']} ");
                      if (ShowAyats) {
                        Get.to(() => Ayatnumbers(
                              surahId: suratID,
                              pageTitle: suratName,
                              surahData: data['surahData']!,
                              suratnumber: data['suratnumber']!,
                              title: data['surahNum']!,
                            ));
                      } else {
                        Get.to(() => Ayatsview(
                              surahId: suratID,
                              title: suratName,
                              inputext: data['listofIDs']!,
                              surahData: data['surahData']!,
                              suratnumber: data['suratnumber']!,
                            ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: mainColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(64, 129, 66, 7),
                                  child: Text("${index + 1}"),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                ayatNames["SurahName"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: noorehuda),
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
