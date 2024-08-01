// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clothing_swap/main.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';

void main() {
  testWidgets('Buttons navigate to the correct pages', (WidgetTester tester) async {
    //  Build 
    await tester.pumpWidget(const MyApp());

    // Verify start page displayed.
    expect(find.byType(StartPage), findsOneWidget);
    
    // Check login button functionality. 
    final logInButton = find.widgetWithText(ElevatedButton, 'Log in');
    expect(logInButton, findsOneWidget);
    await tester.tap(logInButton);
    await tester.pumpAndSettle(); // Wait for navigation to complete.

  });
}
