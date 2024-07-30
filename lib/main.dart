import 'package:flutter/material.dart';
import 'package:clothing_swap/pages/startpage.dart';
import 'package:clothing_swap/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 42,
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromRGBO(255, 87, 87, 1),
                backgroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 18)),
          ),
        ),
        home: const StartPage(title: 'StartPage'),
        routes: {
          '/signup': (context) => SignUp(title: 'SignUp'),
          '/startpage': (context) => StartPage(title: 'StartPage')
        });
  }
}
