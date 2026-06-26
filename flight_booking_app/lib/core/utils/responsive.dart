import 'dart:math' as math;

import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static double size(
    double availableWidth, {
    required double factor,
    required double min,
    required double max,
  }) {
    return math.max(min, math.min(availableWidth * factor, max));
  }

  static double padding(double w) => size(w, factor: 0.04, min: 12, max: 20);

  static double radius(double w) => size(w, factor: 0.03, min: 8, max: 20);

  static double logoSize(double w) => size(w, factor: 0.09, min: 32, max: 50);

  static double iconSize(double w) => size(w, factor: 0.05, min: 18, max: 28);

  static double iconSizeSmall(double w) =>
      size(w, factor: 0.035, min: 12, max: 18);

  static double lineWidth(double w) => size(w, factor: 0.2, min: 50, max: 120);

  static double spacing(double w) => size(w, factor: 0.02, min: 6, max: 16);

  static double cardWidth(double w) =>
      size(w, factor: 0.55, min: 180, max: 320);
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
