import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> notiRequest() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Bangkok"));

    const androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher", // ensure the icon exists
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(initializationSettings);

    // ✅ Request permission if needed (Android 13+)
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> showNotification(List<String> timeList) async {
    print("notification set");
    print(tz.TZDateTime.now(tz.local));
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          "channel_id_AllHalal_01",
          "prayyer_time",
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
          // sound: RawResourceAndroidNotificationSound('')
        );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    tz.TZDateTime setNotiTime(String time) {
      final now = tz.TZDateTime.now(tz.local);
      final parts = time.split(":");
      final hr = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      return tz.TZDateTime(tz.local, now.year, now.month, now.day, hr, minute);
    }

    final sketchtime1 = setNotiTime(timeList[0]);

    final sketchtime2 = setNotiTime(timeList[1]);

    final sketchtime3 = setNotiTime(timeList[2]);

    final sketchtime4 = setNotiTime(timeList[3]);

    final sketchtime5 = setNotiTime(timeList[4]);

    print(sketchtime1);
    print(sketchtime2);
    print(sketchtime3);
    print(sketchtime4);
    print(sketchtime5);

    await notificationsPlugin.zonedSchedule(
      1,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime1,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    await notificationsPlugin.zonedSchedule(
      2,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime2,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    await notificationsPlugin.zonedSchedule(
      3,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime3,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    await notificationsPlugin.zonedSchedule(
      4,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime4,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    await notificationsPlugin.zonedSchedule(
      5,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime5,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNoti() async {
    await notificationsPlugin.cancel(1);
    await notificationsPlugin.cancel(2);
    await notificationsPlugin.cancel(3);
    await notificationsPlugin.cancel(4);
    await notificationsPlugin.cancel(5);
  }
}
