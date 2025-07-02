import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'AuthScreen.dart';

void main() {
  runApp(const BeachCleanupApp());
}

class BeachCleanupApp extends StatelessWidget {
  const BeachCleanupApp({super.key});

  Future<bool> _hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token') != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanWaves',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(primary: Colors.blueAccent),
      ),
      home: FutureBuilder<bool>(
        future: _hasToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }
          return snapshot.data! ? const HomePage() : const AuthScreen();
        },
      ),
    );
  }
}
