import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/app_settings.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';

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
                // Font Size Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Font Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                  ),
                ),
                const SizedBox(height: 16),

                // Theme Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dark Theme',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              key: const Key('dark_theme_switch'),
                              value: settings.isDarkTheme,
                              onChanged: (value) {
                                context.read<AppSettings>().setDarkTheme(value);
                              },
                            ),
                          ],
                        ),
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
                  ),
                ),
                const SizedBox(height: 16),

                // Reset Button
                ElevatedButton(
                  key: const Key('reset_settings_button'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Reset Settings?'),
                        content: const Text('This will reset all settings to defaults.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppSettings>().resetToDefaults();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings reset to defaults'),
                                ),
                              );
                            },
                            child: const Text('Reset'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reset to Defaults'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
