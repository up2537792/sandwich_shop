import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/models/app_settings.dart';

void main() {
  group('AppSettings Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('AppSettings initializes with default values', () async {
      final settings = AppSettings();
      await settings.init();

      expect(settings.fontSize, 16.0);
      expect(settings.isDarkTheme, false);
      expect(settings.isInitialized, true);
    });

    test('setFontSize updates and persists fontSize', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.setFontSize(18.0);
      expect(settings.fontSize, 18.0);

      // Create new instance to verify persistence
      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.fontSize, 18.0);
    });

    test('setDarkTheme updates and persists isDarkTheme', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.setDarkTheme(true);
      expect(settings.isDarkTheme, true);

      // Create new instance to verify persistence
      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.isDarkTheme, true);
    });

    test('toggleDarkTheme toggles isDarkTheme value', () async {
      final settings = AppSettings();
      await settings.init();

      expect(settings.isDarkTheme, false);
      await settings.toggleDarkTheme();
      expect(settings.isDarkTheme, true);
      await settings.toggleDarkTheme();
      expect(settings.isDarkTheme, false);
    });

    test('resetToDefaults clears all saved settings', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.setFontSize(20.0);
      await settings.setDarkTheme(true);
      expect(settings.fontSize, 20.0);
      expect(settings.isDarkTheme, true);

      await settings.resetToDefaults();
      expect(settings.fontSize, 16.0);
      expect(settings.isDarkTheme, false);

      // Verify persistence
      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.fontSize, 16.0);
      expect(settings2.isDarkTheme, false);
    });

    test('AppSettings notifies listeners on changes', () async {
      final settings = AppSettings();
      await settings.init();

      bool notified = false;
      settings.addListener(() {
        notified = true;
      });

      await settings.setFontSize(18.0);
      expect(notified, true);
    });
  });
}
