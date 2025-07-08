import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_official/app/view/IslamicArticlesPage.dart';
import 'package:project_official/app/view/account.dart';
import 'package:project_official/app/view/after_scan.dart';
import 'package:project_official/app/view/calendar_page.dart';
import 'package:project_official/app/view/compass.dart';
import 'package:project_official/app/view/frame.dart';
import 'package:project_official/app/view/prayer_time.dart';
import 'package:project_official/app/view/scanner.dart';
import 'package:project_official/app/view/titile1.dart';
import 'package:project_official/app/view/login.dart';
import 'package:project_official/app/view/setting.dart' hide ThemeController;
import 'package:project_official/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Selalmat",
      debugShowCheckedModeBanner: false,
      home: Root(), // ✅ ตรวจสอบสถานะล็อกอิน
      getPages: [
        GetPage(name: "/", page: () => Title1()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/frame", page: () => Frame()),
        GetPage(name: "/scanner", page: () => Scanner()),
        GetPage(name: "/prayerTime", page: () => PrayerTime()),
        GetPage(name: "/compass", page: () => CompassPage()),
        GetPage(name: "/setting", page: () => Setting()),
        GetPage(name: "/afterScan", page: () => AfterScan()),
        GetPage(name: "/nearbyMosqueMap", page: () => IslamicArticlesPage()),
        GetPage(name: "/account", page: () => Account()),
        GetPage(
          name: "/islamicCalendarPage",
          page: () => IslamicCalendarPage(),
        ),
        GetPage(
          name: "/islamicArticlesPage",
          page: () => IslamicArticlesPage(),
        ),
      ],
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    if (Storage().isLogin()) {
      return Frame();
    } else {
      return Title1();
    }
  }
}
