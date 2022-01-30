import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme(
        primary: Colors.grey.shade900,
        primaryVariant: Colors.black,
        secondary: Colors.blue.shade300,
        secondaryVariant: Colors.grey.shade200,
        surface: Colors.grey.shade600,
        background: Colors.grey.shade900,
        error: Colors.red,
        onPrimary: Colors.grey.shade100,
        onSecondary: Colors.grey.shade900,
        onSurface: Colors.white,
        onBackground: Colors.grey.shade100,
        onError: Colors.yellow,
        brightness: Brightness.dark),
  );

  static final lightTheme = ThemeData(
      colorScheme: ColorScheme(
          primary: Colors.white,
          primaryVariant: Colors.grey.shade100,
          secondary: Colors.blue,
          secondaryVariant: Colors.grey.shade400,
          surface: Colors.grey.shade50,
          background: Colors.grey.shade50,
          error: Colors.red,
          onPrimary: Colors.grey.shade900,
          onSecondary: Colors.grey.shade900,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.yellow,
          brightness: Brightness.light));

  ThemeMode themeMode = ThemeMode.light;
  ThemeData themeData = lightTheme;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    themeData = isOn ? darkTheme : lightTheme;
    notifyListeners();
  }
}
