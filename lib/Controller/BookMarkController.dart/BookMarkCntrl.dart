import 'package:bayanulquran/Model/BookMarksModel.dart';
import 'package:get/get.dart';

class BookmarksController extends GetxController {
  var folderNames = <String>[].obs;
  var isFolderOpen = <bool>[].obs;
  var folderItems = <List<Bookmark>>[].obs;
}
