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
    final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings(
        "angelus.png");
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
  }

  }