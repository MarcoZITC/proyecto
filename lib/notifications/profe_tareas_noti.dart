import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as time_zone;

// Instancia del package
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Método que inicializa el objeto de notificaciones
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icon_app');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Método que muestra la notificación
Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'IDRecor',
    'Recordatorio',
    importance: Importance.max,
    priority: Priority.high,
    icon: 'icon_app'
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  // try {
    await flutterLocalNotificationsPlugin.show(
      1,
      title.isEmpty ? "Tarea" : title,
      body.isEmpty ? "Recordatorio programado." : body,
      notificationDetails,
    );
  // ignore: empty_catches
  // } catch (e) {
    
  // }
}

// Método para programar una notificación en una fecha específica
Future<void> scheduleNotification(
  String title, String body, DateTime scheduledDate) async {
  final AndroidNotificationDetails androidNotificationDetails =
      // ignore: prefer_const_constructors
  AndroidNotificationDetails(
    'IDRecor',
    'Recordatorio',
    importance: Importance.max,
    priority: Priority.high,
  );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  // Programar la notificación en la fecha especificada
  await flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    title,
    body,
    time_zone.TZDateTime.from(scheduledDate, time_zone.local),
    notificationDetails,
    // ignore: deprecated_member_use
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}