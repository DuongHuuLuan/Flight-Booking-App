import 'package:flutter/material.dart';

Color parseHexColor(String? hex) {
  if (hex == null || hex.isEmpty) return Colors.grey;
  return Color(int.parse(hex.replaceFirst('#', '0xFF')));
}
