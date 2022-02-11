import 'package:chatkuy/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.white : kContentColorLightTheme,
        body: Center(
          child: Container(
            child: Image.asset(
              isDarkMode
                  ? "assets/logo/logo_dark.png"
                  : "assets/logo/logo_light.png",
            ),
          ),
        ),
      ),
    );
  }
}
