import 'package:flutter/material.dart';
import 'login_or_register_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E2A47),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginOrRegisterScreen()));
              },
              child: Text('Mulai', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
