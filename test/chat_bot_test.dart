import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:mockito/mockito.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:rythu_mithra/pages/gemini_chat_bot.dart';

// Mock classes
class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late MockImagePicker mockImagePicker;

  setUp(() {
    mockImagePicker = MockImagePicker();
  });

  Widget createChatBotPage() {
    return MaterialApp(
      home: ChatBotPage(),
    );
  }

  testWidgets('ChatBotPage has AppBar with title', (WidgetTester tester) async {
    await tester.pumpWidget(createChatBotPage());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text(' R y t h u   C h a t   B o t '), findsAny);
  });

  testWidgets('ChatBotPage has DashChat input field',
      (WidgetTester tester) async {
    await tester.pumpWidget(createChatBotPage());

    expect(find.byType(DashChat), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Send a text message updates the chat',
      (WidgetTester tester) async {
    await tester.pumpWidget(createChatBotPage());

    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('Send a media message updates the chat',
      (WidgetTester tester) async {
    final mockImage = XFile('path/to/fake/image.png');
    when(mockImagePicker.pickImage(source: ImageSource.gallery))
        .thenAnswer((_) async => mockImage);

    await tester.pumpWidget(createChatBotPage());

    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}
