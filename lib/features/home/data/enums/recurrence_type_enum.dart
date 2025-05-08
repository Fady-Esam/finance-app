import 'package:hive/hive.dart';

part 'recurrence_type_enum.g.dart'; // Needed for codegen

@HiveType(typeId: 2)
enum RecurrenceType  {
  @HiveField(0)
  none,
  @HiveField(1)
  daily,
  @HiveField(2)
  weekly,
  @HiveField(3)
  monthly,
  @HiveField(4)
  yearly,
}
