import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _createNotificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _notifications.show(
        id, title, body, await _createNotificationDetails(),
        payload: payload);
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    var scheduledTime,
  }) async {
    scheduledTime = DateTime.now().add(Duration(seconds: 5));
    _notifications.schedule(
        id, title, body, scheduledTime, await _createNotificationDetails());
  }

  static Future showDailyScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    var time,
  }) async {
    var time = Time(14, 25, 0);
    _notifications.showDailyAtTime(
        id, title, body, time, await _createNotificationDetails(),
        payload: payload);
  }

  static void cancelNotification(int id) => _notifications.cancel(id);
}
