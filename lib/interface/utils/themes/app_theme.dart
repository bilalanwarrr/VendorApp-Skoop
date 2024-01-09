import 'package:flutter/material.dart';

import '../constants/fixed_constants.dart';

class AppTheme {
  static ThemeData apptheme() => ThemeData(
        textTheme: const TextTheme(),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(
        //         foregroundColor: Colors.black,
        //         backgroundColor: Colors.white,
        //         shape: RoundedRectangleBorder(
        //             side: const BorderSide(color: Colors.black),
        //             borderRadius: BorderRadius.circular(smallBorderRadius)))),
        inputDecorationTheme: const InputDecorationTheme(

            // fillColor: backgroundDullWhite.withOpacity(0.3),
            hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontStyle: FontStyle.italic),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),

        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 30,
            )),
        primaryColor: primaryColor,

        // primarySwatch: generateMaterialColor(purplePrimary),
        scaffoldBackgroundColor: Colors.white,
      );
}

var cursorColor = Colors.blueGrey;
var primaryColor = const Color(0xffFDA800);
