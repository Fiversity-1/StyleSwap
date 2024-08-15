import 'package:clothing_swap/features/clothing/presentation/advanced_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/clothing/presentation/match_animation.dart';
import 'package:clothing_swap/features/messaging/messagechat.dart';
import 'package:clothing_swap/features/messaging/messageinbox.dart';
import 'package:clothing_swap/features/clothing/presentation/add_clothing_item.dart';
import 'package:clothing_swap/features/profile/presentation/profilegalleryview.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';
import 'package:clothing_swap/features/signup/presentation/signup.dart';
import 'package:clothing_swap/features/profile/presentation/profile.dart';
import 'package:clothing_swap/features/clothing/presentation/search_main.dart';
import 'package:clothing_swap/features/clothing/presentation/swipe.dart';
import 'package:clothing_swap/features/signup/presentation/login.dart';

void main() {
  runApp(const MyApp());
}

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 42,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 26,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
        selectedTileColor: Colors.green,
        selectedColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.black));

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 42,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 26,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const StartPage(title: 'StartPage'),
      routes: {
        '/signup': (context) => const SignUp(title: 'SignUp'),
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/profile': (context) => const Profile(title: 'profile'),
        '/search': (context) => const SearchPage(),
        '/advanced_search': (context) => const AdvancedSearch(),
        '/message': (context) => const Message(title: 'Message'),
        '/swipe': (context) => const SwipePage(),
        '/chat': (context) => const MessageChat(title: 'MessageChat'),
        '/gallery': (context) => ProfileGalleryView(),
        '/login': (context) => const Login(title: 'Login'),
        '/add_clothing_item': (context) => AddClothingItemPage(),
        '/clothing_detail': (context) => const ClothingDetail(),
        '/match_animation': (context) => const MatchAnimation(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
