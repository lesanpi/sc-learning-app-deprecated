import 'package:e_learning_sc/model/App.dart';
import 'package:flutter/material.dart';

class MyThemes extends ChangeNotifier {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: const ColorScheme.light(),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ));
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: App.myBlack,
    colorScheme: const ColorScheme.dark(),
  );
}
