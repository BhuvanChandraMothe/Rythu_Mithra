import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:rythu_mithra/pages/home_page.dart';
import 'package:rythu_mithra/pages/tips_widget.dart';
import 'package:rythu_mithra/pages/weatherwidget.dart';

void main() {
  testWidgets('HomePage builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('HomePage has AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('HomePage has Drawer', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(Drawer), findsOneWidget);
  });

  testWidgets('HomePage has FloatingActionButton', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('HomePage has WeatherContainer', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(WeatherContainer), findsOneWidget);
  });

  testWidgets('HomePage has TipsWidget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(TipsWidget), findsOneWidget);
  });

  testWidgets('HomePage has Lottie animation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester
        .pumpAndSettle(); // Wait for all animations and async operations
    expect(find.byType(Lottie), findsOneWidget);
  });
}
