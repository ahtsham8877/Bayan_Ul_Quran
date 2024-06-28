import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/View/Ayat/AyatTranslation/AyatTranslation.dart';
import 'package:flutter/material.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:get/get.dart';

class Ayatsview extends StatelessWidget {
  Ayatsview({
    super.key,
    required this.inputext,
    required this.surahData,
    required this.suratnumber,
    required this.title,
    required this.surahId,
    this.showMore = true,
  });

  final List<String> inputext;
  final String title;
  final int surahId;
  final bool showMore;
  final List<String> suratnumber;
  final List<String> surahData;

  final AyatPageController controller = Get.find<AyatPageController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mainColor,
          title: Row(
            children: [
              SizedBox(
                width: 90,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: noorehuda),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "",
                  contentPadding: const EdgeInsets.all(0),
                  titlePadding: const EdgeInsets.all(0),
                  content: Obx(() => Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            Text(
                                "FontSize: ${controller.fontSize.value.toInt()}"),
                            Slider(
                              value: controller.fontSize.value,
                              min: 10,
                              max: 25,
                              onChanged: (newValue) {
                                controller.fontSize(newValue);
                              },
                            ),
                          ],
                        ),
                      )),
                );
              },
              icon: const Icon(Icons.text_fields),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ayattranslation(
                            showTranslation: true,
                            surahID: surahId,
                            title: title,
                            suratNum: suratnumber,
                            pagesdata: surahData,
                            initialPage: 0,
                          )),
                );
              },
              child: Image.asset(
                "${baseURl}page.png",
                height: 30,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        backgroundColor: bgColor,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: inputext.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16),
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          showMore
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Ayattranslation(
                                            showTranslation: true,
                                            surahID: surahId,
                                            title: title,
                                            suratNum: suratnumber,
                                            pagesdata: surahData,
                                            initialPage: index,
                                          )),
                                )
                              : SizedBox();
                        },
                        child: Text(
                          stripHtmlTags(inputext[index]),
                          style: TextStyle(
                            fontFamily: noorehuda,
                            fontSize: controller.fontSize.value + 10,
                          ),
                          textAlign: TextAlign.justify,
                        ),
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

  String stripHtmlTags(String htmlText) {
    const String targetText = 'بِسۡمِ اللّٰہِ الرَّحۡمٰنِ الرَّحِیۡمِ';

    htmlText = htmlText.replaceAll(RegExp(r"<[^>]*>"), '');
    htmlText = htmlText.replaceAll(RegExp(r'&nbsp;'), ' ');
    htmlText = htmlText.replaceAll(RegExp(r'&lsquo;'), "'");
    htmlText = htmlText.replaceAll(RegExp(r'&rsquo;'), "'");

    if (htmlText.contains(targetText)) {
      htmlText = htmlText.replaceFirst(targetText, '$targetText\n\n');
    }

    return htmlText;
  }
}
