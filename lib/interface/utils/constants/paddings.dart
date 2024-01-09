import 'package:flutter/material.dart';

class AppPaddings {
  // Standard paddings
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16.0);
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);

  // Symmetric paddings
  static const EdgeInsets horizontalSymmetricPadding =
      EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets verticalSymmetricPadding =
      EdgeInsets.symmetric(vertical: 16.0);
  static EdgeInsets customSymmetricPadding(
          {required double h, required double v}) =>
      EdgeInsets.symmetric(horizontal: h, vertical: v);

  // Padding for specific sides
  static const EdgeInsets leftPadding = EdgeInsets.only(left: 8.0);
  static const EdgeInsets rightPadding = EdgeInsets.only(right: 8.0);
  static const EdgeInsets topPadding = EdgeInsets.only(top: 8.0);
  static const EdgeInsets bottomPadding = EdgeInsets.only(bottom: 8.0);
  static const EdgeInsets leftlargePadding = EdgeInsets.only(left: 16.0);
  static const EdgeInsets rightlargePadding = EdgeInsets.only(right: 16.0);
  static const EdgeInsets toplargePadding = EdgeInsets.only(top: 16.0);
  static const EdgeInsets bottomlargePadding = EdgeInsets.only(bottom: 16.0);
}
