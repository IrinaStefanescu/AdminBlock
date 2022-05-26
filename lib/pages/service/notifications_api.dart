import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    final largeIconPath = "lib/assets/images/logo.png";
    final bigPicturePath = "lib/assets/images/logo.png";

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        styleInformation: styleInformation,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
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
    await _notifications.show(id, title, body, await _notificationDetails(),
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
        id, title, body, scheduledTime, await _notificationDetails());
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
        id, title, body, time, await _notificationDetails(),
        payload: payload);
  }

  static void cancelNotification(int id) => _notifications.cancel(id);
}