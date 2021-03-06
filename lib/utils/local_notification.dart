import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  final String icono;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotification(this.icono) {
    _init();
  }

  _init() async {
    var initializationSettingsAndroid = AndroidInitializationSettings(icono);
    var initSetttings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: $payload');
        }
      },
    );
  }

  void notification({required String title, required String msg, required bool sound}) async {
    var android = AndroidNotificationDetails('id', 'Wifi Records ', 'description',
        playSound: sound,
        //enableLights: true,
        priority: Priority.high,
        importance: Importance.max);
    var platform = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(0, title, msg, platform);
    //, payload: 'Welcome to the Local Notification demo');
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
