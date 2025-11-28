import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('Profile form validation and save shows SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Navigate to Profile screen via Order bottom button
    final Finder profileButton = find.byKey(const Key('open_profile_button'));
    expect(profileButton, findsOneWidget);
    await tester.tap(profileButton);
    await tester.pumpAndSettle();

    // Save with empty name -> validation error
    await tester.tap(find.byKey(const Key('profile_save')));
    await tester.pump();
    expect(find.text('Name is required'), findsOneWidget);

    // Provide name but invalid email -> email validation error
    await tester.enterText(find.byKey(const Key('profile_name')), 'Alice');
    await tester.enterText(find.byKey(const Key('profile_email')), 'not-an-email');
    await tester.tap(find.byKey(const Key('profile_save')));
    await tester.pump();
    expect(find.text('Enter a valid email'), findsOneWidget);

    // Provide valid email and save -> SnackBar appears
    await tester.enterText(find.byKey(const Key('profile_email')), 'alice@example.com');
    await tester.tap(find.byKey(const Key('profile_save')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Profile saved'), findsOneWidget);
  });
}
