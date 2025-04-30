import 'package:flutter/material.dart';

Color getColorfromHex(String hex) {
  hex = hex.replaceFirst('#', '');
  int value = int.parse(hex, radix: 16);
  return Color(value);
}
String getHexStringFromColor(Color color) {
  return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}



final List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.pink,
  Colors.brown,
  Colors.indigo,
];
