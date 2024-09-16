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
    headlineLarge: GoogleFonts.poppins(),
    headlineMedium: GoogleFonts.poppins(),
    headlineSmall: GoogleFonts.poppins(),
    bodyLarge: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
    bodySmall: GoogleFonts.poppins(),
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
        seedColor: Colors.blue,
        primary: Colors.blue,
        surface: const Color.fromRGBO(18, 18, 18, 1),
        brightness: Brightness.dark),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    hoverColor: Colors.blue,
    listTileTheme: ListTileThemeData(
      tileColor: Colors.black.withOpacity(0.25),
      leadingAndTrailingTextStyle: const TextStyle(color: Colors.white),
      iconColor: Colors.white,
      selectedTileColor: Colors.blue,
      selectedColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(),
      headlineMedium: GoogleFonts.poppins(),
      headlineSmall: GoogleFonts.poppins(),
      bodyLarge: GoogleFonts.poppins(),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.poppins(),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
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
