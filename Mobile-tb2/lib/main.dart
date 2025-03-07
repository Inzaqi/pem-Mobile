import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(SleepyPandaApp());

class SleepyPandaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepy Panda',
      theme: ThemeData(
        primaryColor: Color(0xFF0A1128),
        scaffoldBackgroundColor: Color(0xFF0A1128),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: SplashScreen(),
    );
  }
}