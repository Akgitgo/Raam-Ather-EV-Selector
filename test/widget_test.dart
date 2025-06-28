import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ev_selector/main.dart';

void main() {
  testWidgets('App loads with home page', (WidgetTester tester) async {
    await tester.pumpWidget(const EVSelectorApp());
    expect(find.text('Choose Your Ather'), findsOneWidget);
  });
}

