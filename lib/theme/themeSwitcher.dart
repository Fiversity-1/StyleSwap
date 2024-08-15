import 'package:clothing_swap/theme/theme.dart';
import 'package:flutter/material.dart';

//https://www.youtube.com/watch?v=-jdtfJe_sII Mitch Koko code modified
class ThemeSwitcher with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
