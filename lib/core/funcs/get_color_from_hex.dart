import 'package:flutter/material.dart';

Color getColorfromHex(String hex) {
  hex = hex.replaceFirst('#', '');
  int value = int.parse(hex, radix: 16);
  return Color(value);
}
