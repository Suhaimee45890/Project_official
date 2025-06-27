import 'package:flutter/material.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prayer Time")), // ✅ แก้ชื่อให้ถูกต้อง
      body: Center(
        child: Text(
          "This is Prayer Time Page", // ✅ ข้อความตรงกับหน้า
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
