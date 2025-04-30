import 'package:flutter/material.dart';

IconData getIconFromName(String name) {
  switch (name) {
    case 'shopping_cart':
      return Icons.shopping_cart;
    case 'food_bank':
      return Icons.food_bank;
    case 'home':
      return Icons.home;
    // Add your own icons here
    default:
      return Icons.help_outline;
  }
}
