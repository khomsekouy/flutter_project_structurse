// test home features
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/features/home/presentation/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeScreen has a title and a text', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Home Screen'), findsOneWidget);
  });
}
