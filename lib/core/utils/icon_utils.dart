import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

const iconList = [
  'food_bank',
  'shopping_cart',
  'home',
  'directions_car',
  'attach_money',
  'movie',
  'healing',
  'receipt_long',
  'flight',
  'category',
];

final Map<String, IconData> iconsMap = {
  'food_bank': Icons.restaurant,
  'shopping_cart': Icons.shopping_cart,
  'home': Icons.home,
  'directions_car': Icons.directions_car,
  'attach_money': Icons.attach_money,
  'movie': Icons.movie,
  'healing': Icons.healing,
  'receipt_long': Icons.receipt_long,
  'flight': Icons.flight,
  'category': Icons.category,
};



IconData getIconFromName(String name) {
  switch (name) {
    case 'food_bank':
      return Icons.food_bank;
    case 'shopping_cart':
      return Icons.shopping_cart;
    case 'home':
      return Icons.home;
    case 'directions_car':
      return Icons.directions_car;
    case 'attach_money':
      return Icons.attach_money;
    case 'movie':
      return Icons.movie;
    case 'healing':
      return Icons.healing;
    case 'receipt_long':
      return Icons.receipt_long;
    case 'flight':
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
    'food_bank': S.of(context).icon_food,
    'shopping_cart': S.of(context).icon_shopping,
    'home': S.of(context).icon_home,
    'directions_car': S.of(context).icon_transport,
    'attach_money': S.of(context).icon_salary,
    'movie': S.of(context).icon_entertainment,
    'healing': S.of(context).icon_health,
    'receipt_long': S.of(context).icon_bills,
    'flight': S.of(context).icon_travel,
    'category': S.of(context).icon_category,
  };

  // Returning the icon label, defaulting to 'category' if the icon name is not found
  return iconLabels[iconName] ?? S.of(context).icon_category;
}
