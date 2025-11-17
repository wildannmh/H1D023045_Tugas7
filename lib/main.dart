import 'package:flutter/material.dart';
import 'package:h1d023045_tugas7/pages/auth_check_page.dart';
import 'package:h1d023045_tugas7/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedTheme = prefs.getString('theme_mode');

  if (savedTheme == 'dark') {
    themeNotifier.value = ThemeMode.dark;
  } else if (savedTheme == 'light') {
    themeNotifier.value = ThemeMode.light;
  } else {
    themeNotifier.value = ThemeMode.system;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'H1D023045 Tugas 7',

          theme: ThemeData.light(useMaterial3: true).copyWith(
            primaryColor: Colors.teal,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            primaryColor: Colors.teal,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
            ),
          ),

          themeMode: currentMode,

          debugShowCheckedModeBanner: false,
          home: AuthCheckPage(),
        );
      },
    );
  }
}
