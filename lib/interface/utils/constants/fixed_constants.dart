import 'package:flutter/material.dart';

fixedVerticalSpace(double h) => SizedBox(
      height: h,
    );
fixedHorzSpace(double w) => SizedBox(
      width: w,
    );

const smallIconSize = 20;
const medIconSize = 30;
const largelIconSize = 40;

Size getSize(BuildContext context) => MediaQuery.of(context).size;
double smallBorderRadius = 10;
double medBorderRadius = 16;
double largelBorderRadius = 20;
