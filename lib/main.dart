import 'package:flutter/material.dart';
import 'package:clothing_swap/pages/startpage.dart';
import 'package:clothing_swap/pages/signup.dart';
import 'package:clothing_swap/pages/profile.dart';

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
        ),
      ),
      home: const StartPage(title: 'StartPage'),
      routes: {
        '/signup': (context) => const SignUp(title: 'SignUp'),
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/profile': (context) => const Profile(title: 'profile'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
