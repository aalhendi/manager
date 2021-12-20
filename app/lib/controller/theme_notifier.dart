import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  static final darkTheme = ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: const ColorScheme.dark());

  static final lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      colorScheme: const ColorScheme.light());

  ThemeMode themeMode = ThemeMode.light;
  ThemeData themeData = lightTheme;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
