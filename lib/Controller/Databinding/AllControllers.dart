import 'package:bayanulquran/Controller/PagesController/PageController.dart';
import 'package:get/get.dart';

class DateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AyatPageController(), fenix: true);
  }
}
