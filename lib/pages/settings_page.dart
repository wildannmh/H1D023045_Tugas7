import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h1d023045_tugas7/theme_notifier.dart';
import 'package:h1d023045_tugas7/widgets/app_side_menu.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _saveThemeToPrefs(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeStr = 'system';
    if (mode == ThemeMode.dark) {
      themeStr = 'dark';
    } else if (mode == ThemeMode.light) {
      themeStr = 'light';
    }
    await prefs.setString('theme_mode', themeStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      drawer: AppSideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, currentMode, child) {
                return SwitchListTile(
                  title: Text('Mode Gelap (Dark Mode)'),
                  value: currentMode == ThemeMode.dark,
                  onChanged: (bool isDark) {
                    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
                    themeNotifier.value = newMode;

                    _saveThemeToPrefs(newMode);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
