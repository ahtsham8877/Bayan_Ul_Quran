import 'package:bayanulquran/Utilties/Widgets/drawertext.dart';
import 'package:bayanulquran/View/Ayat/AyatNames/AyatNames.dart';
import 'package:bayanulquran/View/BookMarks/BookMarks.dart';
import 'package:bayanulquran/View/Details/Details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawerdata extends StatelessWidget {
  const Drawerdata({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: const Color.fromARGB(148, 175, 152, 110),
            child: Center(
              child: Text(
                "فہرست",
                style: TextStyle(
                  fontSize: 60,
                  color: Color.fromARGB(255, 110, 60, 12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                addUrl: "feed.png",
                                padding: 20,
                              )),
                    );
                  },
                  addText: "معلومات اورآرا",
                  addURl: "info_btn.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ayatnames(ShowAyats: false)),
                    );
                  },
                  addText: ' کچھ ہمارے بارے میں',
                  addURl: "biyan_quran_btnn.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ayatnames(ShowAyats: true)),
                    );
                  },
                  addText: "قرآن پڑھیں",
                  addURl: "biyan_quran_btnn_new.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => intro()),
                    );
                  },
                  addText: "تعارف",
                  addURl: "taruf_quran_btn.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                addUrl: "arze_screen.png",
                                padding: 0,
                              )),
                    );
                  },
                  addText: "مراتب",
                  addURl: "arz_btn.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Taqdeem()),
                    );
                  },
                  addText: "تقدیم",
                  addURl: "bookmark_btn.png",
                ),
                Drawertext(
                  ontap: () {
                    Get.back();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Bookmarks()),
                    );
                  },
                  addText: "بک مارکس",
                  addURl: "bookmark_btn.png",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
