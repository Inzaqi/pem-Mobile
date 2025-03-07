import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang, $username!'),
        backgroundColor: Color(0xFF1E2A47),
      ),
      body: Center(
        child: Text(
          'Halo, $username! Selamat datang di Sleepy Panda!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
