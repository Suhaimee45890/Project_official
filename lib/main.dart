import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_official/app/view/compass.dart';
import 'package:project_official/app/view/frame.dart';
import 'package:project_official/app/view/prayer_time.dart';
import 'package:project_official/app/view/scanner.dart';
import 'package:project_official/app/view/theme_controller.dart';
import 'package:project_official/app/view/titile1.dart';
import 'package:project_official/app/view/login.dart';
import 'package:project_official/app/view/setting.dart' hide ThemeController;

void main() {
  // ✅ ติดตั้ง controller ก่อน runApp
  runApp(MyApp()); // ✅ เรียก MyApp
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: "Selalmat",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.theme, // ✅ Theme GetX
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => Title1()),
          GetPage(name: "/login", page: () => Login()),
          GetPage(name: "/frame", page: () => Frame()),
          GetPage(name: "/scanner", page: () => Scanner()),
          GetPage(name: "/prayerTime", page: () => PrayerTime()),
          GetPage(name: "/compass", page: () => Compass()),
          GetPage(name: "/setting", page: () => Setting()),
        ],
      ),
    );
  }
}
