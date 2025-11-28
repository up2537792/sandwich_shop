import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Order bottom Profile button navigates to Profile screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Find the profile button in the bottom bar
    final Finder profileButton = find.byKey(const Key('open_profile_button'));
    expect(profileButton, findsOneWidget);
    await tester.tap(profileButton);
    await tester.pumpAndSettle();

    // Verify profile screen content
    expect(find.byKey(const Key('profile_name')), findsOneWidget);
    expect(find.byKey(const Key('profile_save')), findsOneWidget);
  });
}
