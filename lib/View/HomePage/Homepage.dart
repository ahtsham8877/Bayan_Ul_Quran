import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/Utilties/Widgets/WillPOP.dart';
import 'package:bayanulquran/View/Ayat/AyatNames/AyatNames.dart';
import 'package:bayanulquran/View/BookMarks/BookMarks.dart';
import 'package:bayanulquran/View/Details/Details.dart';
import 'package:bayanulquran/View/Search/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final AyatPageController controller = Get.find<AyatPageController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          final willPop = await WillPOP().showMyDialog(context);
          return willPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: mainColor,
              title: Center(
                child: Image.asset(
                  "${baseURl}top_logo.png",
                  height: 40,
                ),
              )),
          backgroundColor: bgColor,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "${baseURl}bg.png",
                    ),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        controller.update();
                        Get.to(() => Ayatnames(
                              ShowAyats: false,
                            ));
                      },
                      child: Image.asset("${baseURl}ni2.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        controller.update();
                        Get.to(() => Ayatnames(
                              ShowAyats: true,
                            ));
                      },
                      child: Image.asset("${baseURl}ni1.png")),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => Details(
                                addUrl: "feed.png",
                                padding: 20,
                              ));
                        },
                        child: Image.asset(
                          "${baseURl}m3.png",
                          height: 90,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => Taqdeem());
                        },
                        child: Image.asset(
                          "${baseURl}m2.png",
                          height: 90,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => Details(
                                addUrl: "arze_screen.png",
                                padding: 0,
                              ));
                        },
                        child: Image.asset(
                          "${baseURl}m1.png",
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const intro());
                        },
                        child: Image.asset(
                          "${baseURl}m.png",
                          height: 90,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SearchPage());
                        },
                        child: Image.asset(
                          "${baseURl}ni3.png",
                          height: 90,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => Bookmarks());
                        },
                        child: Image.asset(
                          "${baseURl}m4.png",
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "شعبہ تحقیق اسلامی\n انجمن خدام القرآن \n 36-k ماڈل ٹاؤن لاہور ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: mainfont,
                          fontSize: 24,
                          color: mainColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
