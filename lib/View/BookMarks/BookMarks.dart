import 'package:bayanulquran/Controller/BookMarkController.dart/BookMarkCntrl.dart';
import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/Utilties/Widgets/ShowTost.dart';
import 'package:bayanulquran/View/Ayat/AyatTranslation/AyatTranslation.dart';
import 'package:bayanulquran/View/DrawerData/Drawerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
import 'package:bayanulquran/Model/BookMarksModel.dart';
import 'package:bayanulquran/Model/FolderModel.dart';
import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:bayanulquran/Utilties/ImagesURls/ImagesUrl.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  BookmarksController bookmarksController = Get.put(BookmarksController());
  final AyatPageController controller = Get.find<AyatPageController>();
  int subIndexs = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  void _loadFolders() async {
    setState(() {
      _isLoading = true; // Set loading to true before starting the load
    });

    List<Folder> folders = await _databaseHelper.getFolders();
    List<Bookmark> bookmarks = await _databaseHelper.getBookmarks();

    setState(() {
      bookmarksController.folderNames.clear();
      bookmarksController.isFolderOpen.clear();
      bookmarksController.folderItems.clear();

      for (Folder folder in folders) {
        bookmarksController.folderNames.add(folder.name);
        bookmarksController.isFolderOpen.add(false);
        bookmarksController.folderItems.add(bookmarks
            .where((bookmark) => bookmark.folderId == folder.id)
            .toList());
      }

      _isLoading = false; // Set loading to false after finishing the load
    });
  }

  void addNewFolder(String folderName) async {
    if (folderName.isNotEmpty) {
      Folder newFolder = Folder(name: folderName, createdDate: DateTime.now());
      await _databaseHelper.insertFolder(newFolder);
      _loadFolders();
    }
  }

  void deleteFolder(int index) async {
    List<Folder> folders = await _databaseHelper.getFolders();
    int folderIdToDelete = folders[index].id!;
    List<Bookmark> bookmarksToDelete = bookmarksController.folderItems[index];
    for (var bookmark in bookmarksToDelete) {
      await _databaseHelper.deleteBookmark(bookmark.id!);
    }

    await _databaseHelper.deleteFolder(folderIdToDelete);

    setState(() {
      _loadFolders();
    });
  }

  void toggleFolderState(int index) {
    setState(() {
      bookmarksController.isFolderOpen[index] =
          !bookmarksController.isFolderOpen[index];
    });
  }

  void deleteItem(int folderIndex, int itemIndex) async {
    Bookmark bookmark = bookmarksController.folderItems[folderIndex][itemIndex];
    await _databaseHelper.deleteBookmark(bookmark.id!);
    _loadFolders();
  }

  void _showNewFolderDialog(BuildContext context) {
    final TextEditingController folderNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('نیا فولڈر بنائیں'),
            content: TextField(
              controller: folderNameController,
              decoration:
                  const InputDecoration(hintText: "فولڈر کا نام درج کریں۔"),
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () {
                    if (folderNameController.text.isEmpty) {
                      ShowToast()
                          .showToastMessage(context, "فولڈر کا نام درج کریں۔");
                    }
                    addNewFolder(folderNameController.text);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 140,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Center(
                        child: const Text(
                      'نیا فولڈر بنائیں',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Center(
            child: const Text(
              'بک مارکس',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          backgroundColor: mainColor,
        ),
        endDrawer: Drawerdata(),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            _showNewFolderDialog(context);
          },
          child: Container(
            color: mainColor,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  "${baseURl}new_folder.png",
                  height: 20,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "نیا فولڈر بنائیں",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Obx(() {
                return bookmarksController.folderNames.isEmpty
                    ? const Center(
                        child: Text('یہاں کوئی فولڈرز نہیں ہیں۔'),
                      )
                    : ListView.builder(
                        itemCount: bookmarksController.folderNames.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                color: mainColor.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        toggleFolderState(index);
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            bookmarksController
                                                    .isFolderOpen[index]
                                                ? "${baseURl}folder_open.png"
                                                : "${baseURl}folder_close.png",
                                            height: 35,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            bookmarksController
                                                .folderNames[index],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!bookmarksController
                                        .isFolderOpen[index])
                                      InkWell(
                                        onTap: () {
                                          deleteFolder(index);
                                        },
                                        child: Image.asset(
                                          "${baseURl}delete.png",
                                          height: 30,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (bookmarksController.isFolderOpen[index])
                                Container(
                                  color: Colors.grey[200],
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: bookmarksController
                                            .folderItems[index].length,
                                        itemBuilder: (context, subIndex) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                onTap: () {
                                                  final surahnumbers =
                                                      bookmarksController
                                                          .folderItems[index]
                                                              [subIndex]
                                                          .content;
                                                  final id = bookmarksController
                                                      .folderItems[index]
                                                          [subIndex]
                                                      .surahID;
                                                  final title =
                                                      bookmarksController
                                                          .folderItems[index]
                                                              [subIndex]
                                                          .title;
                                                  print(
                                                      "surah id is in bookmarks $id");
                                                  Get.to(() => Ayattranslation(
                                                      showTranslation: true,
                                                      showmore: false,
                                                      surahID: id,
                                                      pagesdata: [
                                                        bookmarksController
                                                            .folderItems[index]
                                                                [subIndex]
                                                            .mainContent
                                                      ],
                                                      suratNum: [surahnumbers],
                                                      initialPage: 0,
                                                      title: title));
                                                },
                                                title: Text(
                                                  bookmarksController
                                                      .folderItems[index]
                                                          [subIndex]
                                                      .title,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: noorehuda),
                                                ),
                                                subtitle: Text(
                                                  ' آیات  ${bookmarksController.folderItems[index][subIndex].content} ',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                trailing: InkWell(
                                                  onTap: () {
                                                    deleteItem(index, subIndex);
                                                  },
                                                  child: Image.asset(
                                                    "${baseURl}delete.png",
                                                    height: 30,
                                                  ),
                                                ),
                                                leading: Image.asset(
                                                  "${baseURl}red_marker_full.png",
                                                  height: 26,
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      );
              }),
      ),
    );
  }
}
