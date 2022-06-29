import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _userNotifications = FlutterLocalNotificationsPlugin();
  static final onNotificationsCallback = BehaviorSubject<String?>();

  static Future _createUserNotificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'id',
        'name',
        'description',
        autoCancel: true,
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);

    await _userNotifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotificationsCallback.add(payload);
    });
  }

  static Future showNotification({
    String? title,
    String? body,
    String? payload,
  }) async {
    await _userNotifications.show(
        0, title, body, await _createUserNotificationDetails(),
        payload: payload);
  }

  static Future showScheduledNotification({
    String? title,
    String? body,
    String? payload,
    var scheduledTime,
  }) async {
    scheduledTime = DateTime.now().add(Duration(seconds: 5));
    _userNotifications.schedule(
        0, title, body, scheduledTime, await _createUserNotificationDetails());
  }

  static Future showDailyScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    var time,
  }) async {
    var time = Time(12, 00, 0);
    _userNotifications.showDailyAtTime(
        id, title, body, time, await _createUserNotificationDetails(),
        payload: payload);
  }

  static void cancelUserNotification(int id) async =>
      await _userNotifications.cancel(id);
  static void cancelAllUserNotifications() => _userNotifications.cancelAll;
}
