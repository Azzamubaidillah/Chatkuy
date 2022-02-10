import 'package:chatkuy/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    colorScheme: ColorScheme.light(
        primary: kPrimaryColor, secondary: kSecondaryColor, error: kErrorColor),
  );
}
