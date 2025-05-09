class UserSetupModel {
  final String name;
  final double? balance;
  final DateTime startDateTime;

  UserSetupModel({
    required this.name,
    this.balance = 0.0,
    DateTime? startDateTime,
  }) : startDateTime = startDateTime ?? DateTime.now();
}
