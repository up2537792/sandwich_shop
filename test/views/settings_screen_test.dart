import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/models/app_settings.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/settings_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('SettingsScreen displays font size slider', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    expect(find.byKey(const Key('font_size_slider')), findsOneWidget);
    expect(find.byKey(const Key('font_size_display')), findsOneWidget);
    expect(find.textContaining('16'), findsWidgets);
  });

  testWidgets('SettingsScreen displays dark theme switch', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    expect(find.byKey(const Key('dark_theme_switch')), findsOneWidget);
    expect(find.text('Light theme enabled'), findsOneWidget);
  });

  testWidgets('Adjusting font size slider updates display', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    // Find slider and drag it to increase font size
    final slider = find.byKey(const Key('font_size_slider'));
    await tester.drag(slider, const Offset(50, 0));
    await tester.pumpAndSettle();

    expect(settings.fontSize, greaterThan(16.0));
  });

  testWidgets('Dark theme switch toggles theme', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    expect(settings.isDarkTheme, false);
    expect(find.text('Light theme enabled'), findsOneWidget);

    // Tap the switch
    await tester.tap(find.byKey(const Key('dark_theme_switch')));
    await tester.pumpAndSettle();

    expect(settings.isDarkTheme, true);
    expect(find.text('Dark theme enabled'), findsOneWidget);
  });

  testWidgets('Reset button shows confirmation dialog', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    await tester.tap(find.byKey(const Key('reset_settings_button')));
    await tester.pumpAndSettle();

    expect(find.text('Reset Settings?'), findsOneWidget);
    expect(find.text('This will reset all settings to defaults.'), findsOneWidget);
  });

  testWidgets('Confirming reset resets settings to defaults', (WidgetTester tester) async {
    final settings = AppSettings();
    await settings.init();
    await settings.setFontSize(20.0);
    await settings.setDarkTheme(true);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => settings),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    // Open reset dialog
    await tester.tap(find.byKey(const Key('reset_settings_button')));
    await tester.pumpAndSettle();

    // Tap reset button in dialog
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();

    expect(settings.fontSize, 16.0);
    expect(settings.isDarkTheme, false);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
