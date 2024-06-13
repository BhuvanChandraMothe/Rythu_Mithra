// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:rythu_mithra/pages/tips_widget.dart';

// void main() {
//   testWidgets('TipsWidget builds GridView with correct item count',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(const MaterialApp(home: TipsWidget()));
//     final gridViewFinder = find.byType(GridView);
//     expect(gridViewFinder, findsOneWidget);

//     final GridView gridView = tester.widget(gridViewFinder);
//     expect(gridView.childrenDelegate.estimatedChildCount, infos.length);
//   });

//   testWidgets('TipsWidget builds correct number of info tiles',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(const MaterialApp(home: TipsWidget()));
//     final tileFinder = find.byType(infoTemplate);
//     expect(tileFinder.evaluate().length, infos.length);
//   });

//   testWidgets('TipsWidget applies correct GridView properties',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(const MaterialApp(home: TipsWidget()));
//     final gridViewFinder = find.byType(GridView);
//     final GridView gridView = tester.widget(gridViewFinder);

//     expect(
//         gridView.gridDelegate,
//         const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ));
//   });
// }
