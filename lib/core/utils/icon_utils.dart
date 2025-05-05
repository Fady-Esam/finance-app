import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

const iconList = [
  'category',
  'food',
  'shopping',
  'home',
  'transport',
  'salary',
  'entertainment',
  'health',
  'bills',
  'travel',
];

final Map<String, IconData> iconsMap = {
  'food': Icons.restaurant,
  'shopping': Icons.shopping_cart,
  'home': Icons.home,
  'transport': Icons.directions_car,
  'salary': Icons.attach_money,
  'entertainment': Icons.movie,
  'health': Icons.healing,
  'bills': Icons.receipt_long,
  'travel': Icons.flight,
  'category': Icons.category,
};

IconData getIconFromName(String? name) {
  switch (name) {
    case 'food':
      return Icons.food_bank;
    case 'shopping':
      return Icons.shopping_cart;
    case 'home':
      return Icons.home;
    case 'transport':
      return Icons.directions_car;
    case 'salary':
      return Icons.attach_money;
    case 'entertainment':
      return Icons.movie;
    case 'health':
      return Icons.healing;
    case 'bills':
      return Icons.receipt_long;
    case 'travel':
      return Icons.flight;
    case 'category':
      return Icons.category;
    default:
      return Icons.help_outline;
  }
}

String getIconLabel(String iconName, BuildContext context) {
  // A map for icon labels associated with their localized strings
  final Map<String, String> iconLabels = {
    'food': S.of(context).icon_food,
    'shopping': S.of(context).icon_shopping,
    'home': S.of(context).icon_home,
    'transport': S.of(context).icon_transport,
    'salary': S.of(context).icon_salary,
    'entertainment': S.of(context).icon_entertainment,
    'health': S.of(context).icon_health,
    'bills': S.of(context).icon_bills,
    'travel': S.of(context).icon_travel,
    'category': S.of(context).icon_category,
  };

  // Returning the icon label, defaulting to 'category' if the icon name is not found
  return iconLabels[iconName] ?? S.of(context).icon_category;
}
