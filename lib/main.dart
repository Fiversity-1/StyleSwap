import 'package:clothing_swap/features/messaging/messagechat.dart';
import 'package:clothing_swap/features/messaging/messageinbox.dart';
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 107, 163, 104),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        primary: const Color.fromARGB(255, 107, 163, 104)),
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 42,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      home: const StartPage(title: 'StartPage'),
      routes: {
        '/signup': (context) => const SignUp(title: 'SignUp'),
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/profile': (context) => const Profile(title: 'profile'),
        '/search': (context) => const SearchPage(),
        '/message': (context) => const Message(title: 'Message'),
        '/swipe': (context) => const SwipePage(title: 'SwipePage'),
        '/chat': (context) => const MessageChat(title: 'MessageChat'),
        '/add_clothing_item': (context) => AddClothingItemPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
