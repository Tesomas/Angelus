
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  NotificationService._internal();
// following https://blog.logrocket.com/implementing-local-notifications-in-flutter/
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        "@mipmap/ic_launcher");
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings);
  }

  Future<void> showPrayerNotification() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'prayerReminder', 'Prayer Reminder', description: "Prayer reminder",
        importance: Importance.high);
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'prayerReminder',
        'Prayer Reminder',
        playSound: true,
        priority: Priority.high,
        importance: Importance.high);
    const NotificationDetails platformNotificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, "Prayer Reminder", "Pray the Angelus!", platformNotificationDetails);
  }
}