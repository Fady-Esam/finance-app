// import 'dart:developer';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:finance_flutter_app/features/notification/data/repos/notification_repo.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../../../../core/funcs/is_same_date.dart';
// import '../../../home/data/enums/recurrence_type_enum.dart';
// import '../../../home/data/models/finance_item_model.dart';
// // import 'package:flutter_timezone/flutter_timezone.dart' as ftz;
// // import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart' as ftz;

// class NotificationRepoImpl implements NotificationRepo {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initNotifications() async {
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(android: androidInit);
//     await _plugin.initialize(initSettings);
//   }

//   static Future<void> initializeTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await ftz.FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }
// @pragma('vm:entry-point')

//   static Future<void> checkRecurringTransactions() async {
//     final box = Hive.box<FinanceItemModel>('finance');
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     for (final item in box.values) {
//       if (item.recurrence == RecurrenceType.none) {
//         continue;
//       }
//       log("Initialize Time Zone");
//       if (item.recurrenceEndDate != null &&
//           today.isAfter(item.recurrenceEndDate!)) {
//         continue;
//       }

//       // final nextDate = calculateNextOccurrence(item.dateTime, item.recurrence);
//       // if (!isSameDate(nextDate, today)) {
//       //   continue;
//       // }
//       if (isSameDate(item.dateTime, today)) {
//         await showRecurrenceNotification(
//           id: item.key is int ? item.key as int : item.hashCode,
//           title: 'Upcoming transaction',
//           body: 'Your "${item.title}" is due today.',
//         );
//       }
//     }
//   }

//   static Future<void> showRecurrenceNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     // Ensure timezone is initialized BEFORE calling this (in main)
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     final tz.TZDateTime scheduledDate = now.add(
//       const Duration(seconds: 1),
//     ); // test in 10s

//     // tz.TZDateTime scheduledDate = tz.TZDateTime(
//     //   tz.local,
//     //   now.year,
//     //   now.month,
//     //   now.day,
//     //   now.hour,
//     //   now.minute,
//     // );

//     // if (scheduledDate.isBefore(now)) {
//     //   // If time already passed today, schedule for tomorrow
//     //   scheduledDate = scheduledDate.add(Duration(days: 1));
//     // }

//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           'recurring_channel_id',
//           'Recurring Notifications',
//           channelDescription: 'Reminder for recurring transactions',
//           importance: Importance.max,
//           priority: Priority.high,
//         );

//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     await _plugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       notificationDetails,
//       androidScheduleMode:
//           AndroidScheduleMode.exactAllowWhileIdle, // ✅ Required
//       matchDateTimeComponents: null, // ✅ For daily
//       // matchDateTimeComponents: DateTimeComponents.time, // ✅ For daily
//     );
//   }

// }
