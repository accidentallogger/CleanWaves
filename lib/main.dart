import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const BeachCleanupApp());
}

class BeachCleanupApp extends StatelessWidget {
  const BeachCleanupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanWaves',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Colors.blueAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: const HomePage(),
    );
  }
}
