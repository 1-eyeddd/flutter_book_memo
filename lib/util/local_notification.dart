import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends ChangeNotifier {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String title,
        String body,
        String payload,
      ) async {},
    );
    final initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          print('notification payload: ' + payload);
        }
      },
    );
  }

  static Future<void> scheduleAlarm({
    @required String memo,
    @required String title,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    var scheduleNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(
      iOS: iosChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, memo, scheduleNotificationDateTime, platformChannelSpecifics,
        payload: 'Test Payload',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
