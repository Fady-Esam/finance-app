import 'package:finance_flutter_app/core/funcs/is_same_date.dart';
import 'package:finance_flutter_app/features/home/data/enums/recurrence_type_enum.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/funcs/calculate_next_occurence.dart';
import 'notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      final box = Hive.box<FinanceItemModel>('finance');
      final List<FinanceItemModel> raw = box.values.toList();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      for (final item in raw) {
        if (item.recurrence == RecurrenceType.none) continue;

        if (item.recurrenceEndDate != null &&
            today.isAfter(item.recurrenceEndDate!)) {
          continue;
        }
        final nextDate = calculateNextOccurrence(
          item.dateTime,
          item.recurrence,
        );
        if (!isSameDate(nextDate, today)) continue;
        await showRecurrenceNotification(
          id: item.key is int ? item.key as int : item.hashCode,
          title: 'Upcoming transaction',
          body: 'Your "${item.title}" is due today.',
        );
      }

      return Future.value(true);
    });
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: androidInit,
    );
    await _plugin.initialize(settings);
  }

  static Future<void> showRecurrenceNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'recurring_channel_id',
          'Recurring Notifications',
          channelDescription: 'Reminder for recurring transactions',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(id, title, body, details);
  }
}
