import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.blue,
      surface: Colors.white,
      brightness: Brightness.light),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  //GPT for generating all Text themedata
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.roboto(),
    headlineMedium: GoogleFonts.roboto(),
    headlineSmall: GoogleFonts.roboto(),
    bodyLarge: GoogleFonts.roboto(),
    bodyMedium: GoogleFonts.roboto(),
    bodySmall: GoogleFonts.roboto(),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
  hoverColor: Colors.lightBlueAccent,
  listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      selectedTileColor: Colors.lightBlue,
      selectedColor: Colors.white),
  sliderTheme: const SliderThemeData(
    thumbColor: Colors.black,
    valueIndicatorTextStyle: TextStyle(
      color: Colors.black, // Change the label color here
    ),
  ),
);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        primary: Colors.deepPurple,
        surface: const Color.fromARGB(255, 43, 41, 41),
        brightness: Brightness.dark),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black12),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    hoverColor: Colors.deepPurpleAccent,
    listTileTheme: const ListTileThemeData(
      tileColor: Color.fromARGB(255, 59, 53, 53),
      leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
      iconColor: Colors.white,
      selectedTileColor: Colors.deepPurple,
      selectedColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.lato(),
      headlineMedium: GoogleFonts.lato(),
      headlineSmall: GoogleFonts.lato(),
      bodyLarge: GoogleFonts.roboto(),
      bodyMedium: GoogleFonts.roboto(),
      bodySmall: GoogleFonts.roboto(),
    ),
    sliderTheme: const SliderThemeData(
      thumbColor: Colors.white,
      trackHeight: 10,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white, // Change the label color here
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromARGB(255, 50, 47, 47),
        prefixIconColor: Colors.white),
    hintColor: Colors.white);

ThemeData accessibilityTheme = ThemeData();
