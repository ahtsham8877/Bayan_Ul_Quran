import 'package:bayanulquran/Controller/BookMarkController.dart/BookMarkCntrl.dart';
import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
import 'package:bayanulquran/Model/BookMarksModel.dart';
import 'package:bayanulquran/Model/FolderModel.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';
import 'package:bayanulquran/Utilties/Widgets/CsutomDialog.dart';
import 'package:bayanulquran/Utilties/Widgets/ShowTost.dart';
import 'package:bayanulquran/View/Ayat/AyatView/AyatsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class Ayattranslation extends StatefulWidget {
  final List<String> pagesdata;
  final List<String> suratNum;
  final int initialPage;
  final dynamic title;
  final int surahID;
  final String? serchingContent;
  final bool showTranslation;
  final bool showmore;

  Ayattranslation({
    super.key,
    required this.pagesdata,
    this.showmore = true,
    required this.suratNum,
    this.showTranslation = true,
    required this.initialPage,
    required this.title,
    required this.surahID,
    this.serchingContent,
  });

  @override
  _AyattranslationState createState() => _AyattranslationState();
}

class _AyattranslationState extends State<Ayattranslation> {
  late PageController pageController;
  int setIndex = 0;
  bool isBookmarked = false;
  int? bookmarkId;

  final BookmarksController bookmarksController =
      Get.put(BookmarksController());

  @override
  void initState() {
    super.initState();
    setIndex = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);
    checkBookmarkStatus();
    _loadFolders();
  }

  void _loadFolders() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Folder> folders = await databaseHelper.getFolders();

    setState(() {
      bookmarksController.folderNames.clear();
      folders.forEach((folder) {
        bookmarksController.folderNames.add(folder.name);
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final AyatPageController controller = Get.find<AyatPageController>();

  Future<void> checkBookmarkStatus() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Bookmark> bookmarks = await databaseHelper.getBookmarks();
    String content = widget.suratNum[setIndex];
    String mainContent = widget.pagesdata[setIndex];
    setState(() {
      isBookmarked = false;
      bookmarkId = null;
      for (var bookmark in bookmarks) {
        if (bookmark.content == content &&
            bookmark.mainContent == mainContent &&
            bookmark.surahID == widget.surahID) {
          isBookmarked = true;
          bookmarkId = bookmark.id;
          break;
        }
      }
    });
  }

  Future<void> saveBookmark(int folderId, String folderName) async {
    String content = widget.suratNum[setIndex];
    String mainContent = widget.pagesdata[setIndex];
    String bookmarkTitle =
        widget.title is List ? widget.title[setIndex] : widget.title;

    Bookmark bookmark = Bookmark(
      title: bookmarkTitle,
      content: content,
      timestamp: DateTime.now(),
      folderId: folderId,
      mainContent: mainContent,
      surahID: widget.surahID,
    );

    DatabaseHelper databaseHelper = DatabaseHelper();

    await databaseHelper.insertBookmark(bookmark);

    setState(() {
      isBookmarked = true;
    });
    ShowToast().showToastMessage(
        context, 'یہ بک مارک اس فولڈر میں محفوظ ہیں :$folderName۔',
        color: mainColor);
    await checkBookmarkStatus();
  }

  Future<void> removeBookmark() async {
    if (bookmarkId != null) {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.deleteBookmark(bookmarkId!);

      setState(() {
        isBookmarked = false;
        bookmarkId = null;
      });
      ShowToast().showToastMessage(context, "بک مارک ہٹا دیا گیا۔");
      await checkBookmarkStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(width: 90),
              Text(
                widget.title is List ? widget.title[setIndex] : widget.title,
                style: TextStyle(color: Colors.white, fontFamily: noorehuda),
              ),
            ],
          ),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 255, 242, 183)),
          backgroundColor: mainColor,
          actions: [
            const SizedBox(width: 16),
            InkWell(
              onTap: () async {
                if (isBookmarked) {
                  await removeBookmark();
                } else {
                  if (bookmarksController.folderNames.isEmpty) {
                    ShowToast().showToastMessage(
                        context, 'براہ کرم پہلے فولڈر بنائیں۔');
                  } else {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomFolderDialog(
                        folderNames: bookmarksController.folderNames,
                        onFolderSelected: (folderId) {
                          saveBookmark(folderId + 1,
                              bookmarksController.folderNames[folderId]);
                        },
                        onCreateNewFolder: () {
                          print(
                              'Create new folder logic here'); // Create folder logic here
                        },
                      ),
                    );
                  }
                }
              },
              child: Image.asset(
                isBookmarked
                    ? "${baseURl}red_marker_full.png"
                    : "${baseURl}bookmark_empty.png",
                height: 20,
              ),
            ),
            const SizedBox(width: 23),
            widget.showTranslation
                ? InkWell(
                    onTap: () {
                      List<String> arabicData = [];

                      controller.quranData.forEach((element) {
                        if (element["surah_id"] == widget.surahID) {
                          arabicData.add(element["Arabic_"]);
                        }
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ayatsview(
                                showMore: widget.showmore,
                                surahId: widget.surahID,
                                inputext: arabicData,
                                surahData: widget.pagesdata,
                                suratnumber: widget.suratNum,
                                title: widget.title)),
                      );
                    },
                    child: const Icon(
                      Icons.menu_book,
                      size: 28,
                    ),
                  )
                : SizedBox(),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        checkBookmarkStatus();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.suratNum[setIndex],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        checkBookmarkStatus();
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: widget.pagesdata.length,
                  itemBuilder: (context, index) {
                    String content = widget.pagesdata[index];

                    if (widget.serchingContent != null) {
                      content = controller.highlightMatches(
                          content, widget.serchingContent!);
                    }

                    final helitedtext =
                        '<div style="text-align: justify;">$content</div>';

                    return SingleChildScrollView(
                      child: HtmlWidget(
                        helitedtext,
                        customStylesBuilder: (element) {
                          return {
                            'line-height': '2.1',
                          };
                        },
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      setIndex = index;
                    });
                    checkBookmarkStatus();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




 // IconButton(
            //           onPressed: () {
            //             Get.defaultDialog(
            //               title: "",
            //               contentPadding: const EdgeInsets.all(0),
            //               titlePadding: const EdgeInsets.all(0),
            //               content: Obx(() => Directionality(
            //                     textDirection: TextDirection.rtl,
            //                     child: Column(
            //                       children: [
            //                         Text(
            //                             "FontSize: ${controller.pagefontSize.value.toInt()}"),
            //                         Slider(
            //                           value: controller.pagefontSize.value,
            //                           min: 0,
            //                           max: 10,
            //                           onChanged: (newValue) {
            //                             controller.pagefontSize(newValue);
            //                           },
            //                         ),
            //                       ],
            //                     ),
            //                   )),
            //             );
            //           },
            //           icon: const Icon(Icons.text_fields),
            //         ),




                    // dom.Document document = html_parser.parse(content);

                    // document.body!.querySelectorAll('*').forEach((element) {
                    //   final currentFontSize =
                    //       element.attributes['style']?.contains('font-size') ??
                    //           false;
                    //   if (currentFontSize) {
                    //     final style = element.attributes['style']!;
                    //     final fontSizeRegex = RegExp(r'font-size:\s*(\d+)px');
                    //     final match = fontSizeRegex.firstMatch(style);
                    //     if (match != null) {
                    //       final fontSizeValue =
                    //           double.tryParse(match.group(1)!) ?? 0;
                    //       final newFontSize =
                    //           (fontSizeValue + controller.pagefontSize.value)
                    //               .toInt();
                    //       element.attributes['style'] = style.replaceAll(
                    //         fontSizeRegex,
                    //         'font-size: ${newFontSize}px',
                    //       );
                    //     }
                    //   }
                    // });

                    // final modifiedContent = document.body!.outerHtml;