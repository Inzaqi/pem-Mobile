import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_page.dart'; // Halaman login
import 'forgot_password_page.dart'; // Halaman lupa password
import 'welcome_page.dart'; // Halaman selamat datang

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context, String email, String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/register/'); // Sesuaikan dengan URL backend
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(email: email),
          ),
        );
      } else {
        showErrorDialog(context, 'Gagal Registrasi', 'Error: ${response.body}');
      }
    } catch (e) {
      showErrorDialog(context, 'Error', 'Terjadi kesalahan: $e');
    }
  }

  void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B2F),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset('images/sleepy2.png', height: 100), // Tambahkan ikon tidur
            SizedBox(height: 16),
            Text(
              'Daftar menggunakan email yang valid',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 32),
            // Input Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.white),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF21244A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            // Input Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.white),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF21244A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                ),
                child: Text('Lupa password?', style: TextStyle(color: Colors.teal)),
              ),
            ),
            SizedBox(height: 16),
            // Tombol Daftar
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showErrorDialog(context, 'Validasi Gagal', 'Email dan Password tidak boleh kosong.');
                } else {
                  registerUser(context, email, password);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Daftar', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 16),
            // Navigasi ke Login Page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah memiliki akun?', style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ),
                  child: Text('Masuk sekarang', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
