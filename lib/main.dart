import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project_official/app/view/compass.dart';
import 'package:project_official/app/view/home.dart';
import 'package:project_official/app/view/prayer_time.dart';
import 'package:project_official/app/view/scanner.dart';
import 'package:project_official/app/view/titile1.dart';
import 'package:project_official/app/view/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Selalmat",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => Title1()), // หน้าแรก
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/Home", page: () => Home()),
        GetPage(name: "/scanner", page: () => Scanner()),
        GetPage(name: "/prayerTime", page: () => PrayerTime()),
        GetPage(name: "/compass", page: () => Compass()),
      ],
    );
  }
}
