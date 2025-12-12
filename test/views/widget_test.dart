import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('Switching sandwich length toggles switch value', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final Finder switchFinder = find.byKey(const Key('sandwich_type_switch'));
    expect(switchFinder, findsOneWidget);

    // Verify initial value is true (footlong)
    Switch s = tester.widget<Switch>(switchFinder);
    expect(s.value, isTrue);

    // Toggle the switch
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    // Verify the switch value changed
    s = tester.widget<Switch>(switchFinder);
    expect(s.value, isFalse);
  });
}
