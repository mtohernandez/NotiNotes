import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;


class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    tzData.initializeTimeZones();
  }

  static TimeZone? _this;

  Future<String> getTimeZoneName() async => FlutterNativeTimezone.getLocalTimezone();

  Future<tz.Location> getLocation([String? timeZoneName]) async {
    if(timeZoneName == null || timeZoneName.isEmpty){
      timeZoneName = await getTimeZoneName();
    }
    return tz.getLocation(timeZoneName);
  }
}



class LocalNotificationService {
  // Initialize the notifications plugin
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize for every platform
  Future<void> setup() async {
    // Step #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    // const iosSetting = IOSInitializationSettings(); These does not work for some reason

    // Step #2
    const initSettings = InitializationSettings(android: androidSetting);

    // Step #3
    await _localNotificationsPlugin
        .initialize(initSettings)
        .then((_) => {debugPrint('setupPlugin: setup complete')})
        .catchError((Object error) => {debugPrint('Error: $error')});
  }

  void addNotification(
    String title,
    String body,
    DateTime endTime, {
    String sound = '',
    String channel = 'default',
  }) async {
    // #1

    String timeZoneName = await TimeZone().getTimeZoneName();

    final location = tz.getLocation(timeZoneName);

    final scheduleTime = tz.TZDateTime.from(endTime, location);

    // Sound file
    var soundFile = sound.replaceAll('.mp3', '');

    // #2
    final notificationSound =
        sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);

    // #2
    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel,
        playSound: true,
        sound: notificationSound // channel Name
        );

    // final iosDetail = IOSNotificationDetails();

    final noticeDetail = NotificationDetails(
      // iOS: iosDetail,
      android: androidDetail,
    );

    // #3
    const id = 0;

    // #4
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  void cancelNotification() async {
    await _localNotificationsPlugin.cancelAll();
  }
}
