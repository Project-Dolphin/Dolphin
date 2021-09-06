import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:oceanview/pages/bus/bus_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future dailyAtTimeNotification(
    int id, String title, String description, int minute) async {
  final notiTitle = title;
  final notiDesc = description;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
      true;

  var android = AndroidNotificationDetails('id', notiTitle, notiDesc,
      importance: Importance.max, priority: Priority.max);
  var ios = IOSNotificationDetails();
  var detail = NotificationDetails(android: android, iOS: ios);
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  var isExist = false;
  Get.put(BusController());

  pendingNotificationRequests.forEach((element) {
    if (element.id == id) {
      isExist = true;
    }
  });

  if (isExist) {
    await flutterLocalNotificationsPlugin.cancel(id);
    Get.find<BusController>().setNotificationEach(id, false);
  } else {
    if (result) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannelGroup('id');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        notiTitle,
        notiDesc,
        _setNotiTime(minute),
        detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.time,
      );
      Get.find<BusController>().setNotificationEach(id, true);
    }
  }
}

tz.TZDateTime _setNotiTime(int minute) {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate = now.add(Duration(minutes: minute));
  var newScheduledDate = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      0);

  return newScheduledDate;
}
