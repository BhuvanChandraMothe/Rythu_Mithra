import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:rythu_mithra/pages/login_page.dart';
import 'package:rythu_mithra/components/my_button.dart';
import 'package:rythu_mithra/components/my_textfield.dart';
import 'package:rythu_mithra/components/square_tile.dart';
import 'package:rythu_mithra/services/auth_service.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  Widget createLoginPage() {
    return MaterialApp(
      home: LoginPage(onTap: () {}),
    );
  }

  testWidgets('LoginPage has essential UI elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginPage());

    expect(find.byType(Lottie), findsOneWidget);
    expect(find.byType(MyTextField), findsNWidgets(2));
    expect(find.byType(MyButton), findsOneWidget);
    expect(find.byType(SquareTile), findsNWidgets(2));
  });
}
