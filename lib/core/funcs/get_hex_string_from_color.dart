import 'package:flutter/material.dart';

String getHexStringFromColor(Color color) {
  return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}
