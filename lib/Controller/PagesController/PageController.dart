import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyatPageController extends GetxController {
  final PageController pageController = PageController();
  var ayatdata = <Map<String, dynamic>>[].obs;
  var taqdeemData = <Map<String, dynamic>>[].obs;
  var quranData = <Map<String, dynamic>>[].obs;

  RxDouble fontSize = 11.0.obs;

  RxDouble pagefontSize = 0.0.obs;
  @override
  void onInit() {
    loadSurahs();
    loadTakdeem();
    loadQuranData();
    super.onInit();
  }

  Future<void> loadSurahs() async {
    ayatdata.value = await DatabaseHelper().addTableName('Surahs');
    print("Sura data is  $ayatdata");
  }

  Future<void> loadTakdeem() async {
    taqdeemData.value = await DatabaseHelper().addTableName('Takdeem');
    print("taqdeem data is   $taqdeemData");
  }

  Future<void> loadQuranData() async {
    quranData.value = await DatabaseHelper().addTableName('Qurantable');
    print("Quran table data is   $quranData");
  }

  String highlightMatches(String text, String query) {
    if (query.isEmpty) return text;

    final matches = RegExp(query, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) return text;

    final highlightedText = StringBuffer();
    var lastIndex = 0;
    for (var match in matches) {
      highlightedText.write(text.substring(lastIndex, match.start));
      highlightedText.write('<span style="background-color: yellow;">');
      highlightedText.write(text.substring(match.start, match.end));
      highlightedText.write('</span>');
      lastIndex = match.end;
    }
    highlightedText.write(text.substring(lastIndex));

    return highlightedText.toString();
  }
}
