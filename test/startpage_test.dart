// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';
import 'package:provider/provider.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';

void main() {
  testWidgets('Buttons navigate to the correct pages', (WidgetTester tester) async {
    // Set up the providers needed for StartPage
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeSwitcher()), 
        ],
        child: MaterialApp(
          home: const StartPage(title: 'Test Title'),
          routes: {
            '/login': (context) => const Scaffold(body: Text('Login Page')),
            '/signup': (context) => const Scaffold(body: Text('Sign Up Page')),
          },
        ),
      ),
    );

    // Verify StartPage is displayed
    expect(find.byType(StartPage), findsOneWidget);

    // Check "Log in" button functionality
    final logInButton = find.widgetWithText(ElevatedButton, 'Log in');
    expect(logInButton, findsOneWidget);
    await tester.tap(logInButton);
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify navigation to the login page
    expect(find.text('Login Page'), findsOneWidget);

  });
}
