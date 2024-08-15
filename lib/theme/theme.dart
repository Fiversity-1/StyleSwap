import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: Colors.lightBlue,
  scaffoldBackgroundColor: Colors.grey[300],
  // scaffoldBackgroundColor: Colors.lightBlue,
  // textTheme: const TextTheme(
  //   headlineLarge: TextStyle(
  //     fontSize: 42,
  //     color: Colors.white,
  //   ),
  //   headlineMedium: TextStyle(
  //     fontSize: 26,
  //     color: Colors.white,
  //   ),
  //   headlineSmall: TextStyle(
  //     fontSize: 26,
  //     color: Colors.black,
  //   ),
  //   bodySmall: TextStyle(
  //     fontSize: 22,
  //     color: Colors.white,
  //   ),
  // ),
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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
  // dialogBackgroundColor: Colors.lightBlue,
  // inputDecorationTheme: const InputDecorationTheme(
  //     fillColor: Colors.white,
  //     enabledBorder:
  //         OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
  hoverColor: Colors.lightBlueAccent,
  listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      selectedTileColor: Colors.lightBlue,
      selectedColor: Colors.white),
  // iconTheme: const IconThemeData(color: Colors.black)
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      .copyWith(brightness: Brightness.dark),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black12),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  hoverColor: Colors.lightBlueAccent,
  listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      selectedTileColor: Colors.lightBlue,
      selectedColor: Colors.white),
);

ThemeData accessibilityTheme = ThemeData();
