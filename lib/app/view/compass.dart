import 'package:flutter/material.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Compass")), // ✅ แก้ชื่อให้ถูกต้อง
      body: Center(
        child: Text(
          "This is Compass Page", // ✅ แก้ข้อความให้ตรงกับหน้าจอ
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
