
import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  NotificationService._internal();
// following https://blog.logrocket.com/implementing-local-notifications-in-flutter/
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        "@mipmap/ic_launcher");
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings);
  }

  Future<void> showPrayerNotification(SettingsModel settingsModel) async {
    flutterLocalNotificationsPlugin.cancelAll();
    final List<PendingNotificationRequest> pending = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    if (settingsModel.prayerReminders.isNotEmpty) {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
          'prayerReminder', 'Prayer Reminder', description: "Prayer reminder",
          importance: Importance.high);
      const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          'prayerReminder',
          'Prayer Reminder',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high);
      const NotificationDetails platformNotificationDetails = NotificationDetails(
          android: androidNotificationDetails);
      int i = 0;
      for (TimeOfDay reminderTime in settingsModel.prayerReminders) {
        //dont care about the date because it should just match on time
        DateTime dateTime = new DateTime(1969, 1, 1, reminderTime.hour, reminderTime.minute);
        flutterLocalNotificationsPlugin.zonedSchedule(
            i,
            "Prayer Reminder",
            "Pray the Angelus!",
            tz.TZDateTime.from(dateTime, tz.local),
            platformNotificationDetails,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time
        );
        i++;
      }
    }
  }
}