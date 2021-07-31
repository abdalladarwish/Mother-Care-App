import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    var androidInit = AndroidInitializationSettings("app_icon");
    var initialSetting = InitializationSettings(android: androidInit);
    _flutterLocalNotificationsPlugin.initialize(initialSetting, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {}

  Future showNotification({
    String channelId = "channel id",
    String channelName = "channel name",
    String channelDescription = "channel description",
    required String title,
    required String body
  }) async {
    var androidDetails = AndroidNotificationDetails(channelId, channelName, channelDescription);
    var notificationDetails = NotificationDetails(android: androidDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}
