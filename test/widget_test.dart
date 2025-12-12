// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('App has title and Add button', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // AppBar title
    expect(find.text('Sandwich Counter'), findsOneWidget);

    // Add to Cart button exists and can be tapped
    final addFinder = find.text('Add to Cart');
    expect(addFinder, findsOneWidget);

    await tester.tap(addFinder);
    await tester.pump();

    // Tapping should not crash and button still present
    expect(addFinder, findsOneWidget);
  });
}
