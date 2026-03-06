import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData WarmTheme(){
    final theme =ThemeData.dark().copyWith(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark, primary: Colors.grey, 
        onPrimary: Colors.amber, secondary: Colors.black26, 
        onSecondary: Colors.redAccent, error: Colors.red, 
        onError: Colors.red, surface: Colors.orange, onSurface: Colors.black)
    );
    return theme;
  }
}