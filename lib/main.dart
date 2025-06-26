import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project_official/app/view/titile1.dart' hide Preview;
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
        GetPage(name: "/", page: () => Title1()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/", page: () => Login()),
      ],
    );
  }
}
