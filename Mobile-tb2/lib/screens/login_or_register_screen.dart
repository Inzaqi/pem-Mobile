import 'package:flutter/material.dart';
import 'RegisterPage.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E2A47),
        title: Text('Sleepy Panda', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/sleepy2.png', width: 150),
            SizedBox(height: 20),
            Text(
              'Sleepy Panda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Mulai dengan masuk atau mendaftar untuk melihat analisa tidurmu.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E2A47),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Masuk', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Daftar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}