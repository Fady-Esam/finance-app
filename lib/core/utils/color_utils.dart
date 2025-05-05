import 'package:flutter/material.dart';

Color getColorfromHex(String? hex) {
  if (hex == null) return Colors.grey;
  hex = hex.replaceFirst('#', '');
  int value = int.parse(hex, radix: 16);
  return Color(value);
}

String getHexStringFromColor(Color? color) {
  if (color == null)  return "#9e9e9e";
  return '#${color.toARGB32().toRadixString(16).substring(2).toLowerCase()}';
}

final List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.grey,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.pink,
  Colors.brown,
  Colors.indigo,
  Colors.yellow,
  Colors.cyan,
];
