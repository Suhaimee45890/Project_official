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

  Future<void> showNotification(String time) async {
    print(time);
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
    final now = tz.TZDateTime.now(tz.local);
    final parts = time.split(":");
    final hr = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final tz.TZDateTime sketchtime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hr,
      minute,
    );

    await notificationsPlugin.zonedSchedule(
      1,
      "เวลาละหมาด",
      "การละหมาดเป็นส่วนหนึ่งของการศรัทธา",
      sketchtime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
