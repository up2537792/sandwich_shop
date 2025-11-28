import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('Drawer opens and navigates to Profile', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Open the drawer using the menu tooltip
    final Finder menu = find.byTooltip('Open navigation menu');
    expect(menu, findsOneWidget);
    await tester.tap(menu);
    await tester.pumpAndSettle();

    // Tap the Profile item
    final Finder profileTile = find.text('Profile');
    expect(profileTile, findsWidgets); // one in drawer
    await tester.tap(profileTile.first);
    await tester.pumpAndSettle();

    // Should navigate to Profile screen content (check form field exists)
    expect(find.byKey(const Key('profile_name')), findsOneWidget);
  });
}
