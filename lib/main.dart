import 'package:bayanulquran/Controller/Databinding/AllControllers.dart';
import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:bayanulquran/View/Ayat/AyatTranslation/AyatTranslation.dart';
import 'package:bayanulquran/View/SaplashSc/SaplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: mainfont),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', binding: DateBinding(), page: () => SaplashScreen()),
      ],
    );
  }
}
