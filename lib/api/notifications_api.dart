import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'dart:math';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    tz_data.initializeTimeZones();
  }

  static TimeZone? _this;

  Future<String> getTimeZoneName() async {
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    return timezoneInfo.identifier;
  }

  Future<tz.Location> getLocation([String? timeZoneName]) async {
    if (timeZoneName == null || timeZoneName.isEmpty) {
      timeZoneName = await getTimeZoneName();
    }
    return tz.getLocation(timeZoneName);
  }
}

class LocalNotificationService {

  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> setup(Function(NotificationResponse) notificationResponse) async {
    const androidSetting = AndroidInitializationSettings('@mipmap/launcher_icon');

    const initSettings = InitializationSettings(android: androidSetting);

    await _localNotificationsPlugin
        .initialize(
          settings: initSettings,
          onDidReceiveNotificationResponse: notificationResponse,
        )
        .then((_) => {debugPrint('setupPlugin: setup complete')})
        .catchError((Object error) => {debugPrint('Error: $error')});
  }

  String notificationMessage(String body, String userName) {
    var messages = [
      'Hey! $body is waiting.',
      'Reminder about $body',
      '$body is waiting for you',
      body,
      'One more thing to do: $body',
      'You have a task: $body',
      'You have a reminder: $body',
      'Please tell me you did not forget $body',
      'URGENT: $body',
      'Now or never: $body',
      'Mmmm... $body',
      '$userName you left something behind: $body',
      '$userName return to noti NOW!',
      '$userName you have a task: $body',
      '$userName you have a reminder: $body',
      '$userName did you fall as sleep or what?',
    ];

    var random = Random();
    var element = messages[random.nextInt(messages.length)];
    return element;
  }

  void addNotification(
    int id,
    String title,
    String body,
    DateTime endTime,
    String noteId, {
    String sound = '',
    String channel = 'default',
  }) async {
    String timeZoneName = await TimeZone().getTimeZoneName();

    final location = tz.getLocation(timeZoneName);

    final scheduleTime = tz.TZDateTime.from(endTime, location);

    var soundFile = sound.replaceAll('.mp3', '');

    final notificationSound =
        sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);

    final androidDetail = AndroidNotificationDetails(
      channel,
      channel,
      playSound: true,
      sound: notificationSound,
      enableVibration: true,
    );

    final noticeDetail = NotificationDetails(
      android: androidDetail,
    );

    await _localNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduleTime,
      notificationDetails: noticeDetail,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: noteId,
    );
  }

  static void cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id: id);
  }
}
