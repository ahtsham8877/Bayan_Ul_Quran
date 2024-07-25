import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/View/Ayat/AyatTranslation/AyatTranslation.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/Widgets/CustomTextFeild.dart';
import 'package:bayanulquran/View/DrawerData/Drawerdata.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredNames = [];
  final AyatPageController controller = Get.find<AyatPageController>();
  bool isLoading = false;
  bool hasSearched = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mainColor,
        ),
        endDrawer: const Drawerdata(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(
                controller: _searchController,
                onSubbmitted: _filterNames,
                hintText: "الفاظ کی مدد سے تلاش کریں۔۔۔۔",
                suffixIcon: SizedBox(
                  width: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 151, 116, 73),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 107, 75, 26),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _filterNames(_searchController.text);
                        },
                        child: isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: !isLoading,
                  child: hasSearched && filteredNames.isEmpty
                      ? Center(
                          child: Text(
                            'کوئی نتیجہ نہیں ملا',
                            style: TextStyle(fontSize: 20, color: mainColor),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                List<String> pageData = [];
                                List<String> suratName = [];
                                List<String> title = [];

                                for (var element in filteredNames) {
                                  element["pageData"];
                                  pageData.add(element["pageData"]!);
                                  suratName.add(element["SurahNo"]!);
                                  title.add(element["SurahName"]!);
                                }
                                print(
                                    "Surat id ${filteredNames[index]['surahId']!} ");
                                Get.to(Ayattranslation(
                                  surahID: int.parse(
                                      filteredNames[index]['surahId']!),
                                  serchingContent: _searchController.text,
                                  title: title,
                                  pagesdata: pageData,
                                  suratNum: suratName,
                                  initialPage: index,
                                  showTranslation: false,
                                ));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.article_outlined,
                                              color: mainColor,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${filteredNames[index]['SurahName']}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: noorehuda),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          filteredNames[index]['Urdu']!,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
              if (isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
///// i have change searching senario direcet query is not getting id correctly now this approch is working correctly

  void _filterNames(String searchText) {
    if (searchText.isEmpty || searchText.length <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: mainColor,
          content: const Text('براہ کرم 4 یا اس سے زیادہ حروف درج کریں۔'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
      hasSearched = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      filteredNames = controller.quranData
          .where(
        (Map<String, dynamic> data) => data['Arabic']
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase()),
      )
          .map<Map<String, String>>(
        (Map<String, dynamic> data) {
          int surahId = int.parse(data['surah_id'].toString());
          String surahName = controller.ayatdata
              .firstWhere((surah) => surah['SurahNo'] == surahId)['SurahName']
              .toString();
          return {
            'Urdu': data['Urdu'].toString(),
            'pageData': data['Arabic'].toString(),
            'SurahNo': data['ayah_location'].toString(),
            'SurahName': surahName,
            'surahId': surahId.toString()
          };
        },
      ).toList();

      setState(() {
        isLoading = false;
      });
    });
  }
}
