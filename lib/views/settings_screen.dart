import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/app_settings.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Settings'),
      ),
      body: Consumer<AppSettings>(
        builder: (context, settings, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SettingCard(
                  title: 'Font Size',
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.text_decrease, size: 20),
                        Expanded(
                          child: Slider(
                            key: const Key('font_size_slider'),
                            value: settings.fontSize,
                            min: 12,
                            max: 24,
                            divisions: 6,
                            label: '${settings.fontSize.toStringAsFixed(0)}',
                            onChanged: (value) {
                              context.read<AppSettings>().setFontSize(value);
                            },
                          ),
                        ),
                        const Icon(Icons.text_increase, size: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current: ${settings.fontSize.toStringAsFixed(0)}pt',
                      key: const Key('font_size_display'),
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SectionDivider(height: 16),

                SettingCard(
                  title: 'Dark Theme',
                  trailing: Switch(
                    key: const Key('dark_theme_switch'),
                    value: settings.isDarkTheme,
                    onChanged: (value) {
                      context.read<AppSettings>().setDarkTheme(value);
                    },
                  ),
                  children: [
                    Text(
                      settings.isDarkTheme
                          ? 'Dark theme enabled'
                          : 'Light theme enabled',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SectionDivider(height: 16),

                PrimaryButton(
                  label: 'Reset to Defaults',
                  backgroundColor: Colors.red,
                  key: const Key('reset_settings_button'),
                  onPressed: () {
                    showConfirmDialog(
                      context,
                      title: 'Reset Settings?',
                      message: 'This will reset all settings to defaults.',
                      confirmButtonText: 'Reset',
                    ).then((confirmed) {
                      if (confirmed) {
                        context.read<AppSettings>().resetToDefaults();
                        SnackBarHelper.showMessage(
                          context,
                          'Settings reset to defaults',
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
