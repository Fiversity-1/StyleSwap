import 'package:clothing_swap/theme/theme.dart';
import 'package:flutter/material.dart';

//https://www.youtube.com/watch?v=-jdtfJe_sII Mitch Koko code modified
//used for light and dark theme implementation
class ThemeSwitcher with ChangeNotifier {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(String option, context) {
    //add toggle for accessibility and user device
    switch (option) {
      case "Light":
        themeData = lightTheme;
        break;
      case "Dark":
        themeData = darkTheme;
        break;
      case "High Constrast":
        themeData = accessibilityTheme;
        break;
      case "System":
        var colourMode = MediaQuery.of(context).platformBrightness;
        if (colourMode == Brightness.dark) {
          themeData = darkTheme;
        } else {
          themeData = lightTheme;
        }
        break;
    }
  }
}
