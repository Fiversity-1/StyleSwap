import 'package:clothing_swap/features/clothing/presentation/add_clothing_item.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';
import 'package:clothing_swap/features/signup/presentation/signup.dart';
import 'package:clothing_swap/features/profile/presentation/profile.dart';
import 'package:clothing_swap/features/clothing/presentation/search.dart';
import 'package:clothing_swap/features/clothing/presentation/swipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(255, 87, 87, 1),
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const StartPage(title: 'StartPage'),
      routes: {
        '/signup': (context) => const SignUp(title: 'SignUp'),
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/profile': (context) => const Profile(title: 'profile'),
        '/search': (context) => const SearchPage(),
        '/message': (context) => const SwipePage(title: 'SwipePage'),
        '/add_clothing_item': (context) => AddClothingItemPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
