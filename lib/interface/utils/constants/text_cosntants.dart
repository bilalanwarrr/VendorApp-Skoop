import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText {
  static Widget boldText(String text,
      {double fontSize = 16.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
    );
  }

  static Widget extraBoldText(String text,
      {double fontSize = 16.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w900, color: color),
    );
  }

  static Widget normalText(String text,
      {double fontSize = 16.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget largeText(String text,
      {double fontSize = 24, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget smallText(String text,
      {double fontSize = 12.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget bodyText(String text,
      {double fontSize = 16.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget extraLargeText(String text,
      {double fontSize = 32.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget extraBoldHeadingText(String text,
      {double fontSize = 28.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
    );
  }

  static Widget titleText(String text,
      {double fontSize = 20.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
    );
  }

  static Widget subtitleText(String text,
      {double fontSize = 16.0, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontStyle: FontStyle.italic, color: color),
    );
  }
}
