import 'package:contoh/gender_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WelcomePage extends StatelessWidget {
  final String email; // Terima email dari RegisterPage

  WelcomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    Future<void> submitName() async {
      final url = Uri.parse('http://127.0.0.1:8000/save-name/'); // Ganti sesuai dengan endpoint API Anda
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({'email': email, 'name': nameController.text});

      try {
        final response = await http.put(url, headers: headers, body: body); // Menggunakan metode PUT
        if (response.statusCode == 200) {
          print('Name updated successfully!');
          // Lanjutkan ke halaman berikutnya atau tampilkan pesan sukses
        } else {
          print('Failed to update name: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF111332),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di Sleepy Panda!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kita kenalan dulu yuk! Siapa nama kamu?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF2C2E43),
                hintText: 'Nama kamu',
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF48C9B0),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    submitName().then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenderPage(email: email, name: nameController.text.trim(),), // Kirim email dan nama ke GenderPage
                        ),
                      );
                    });
                  } else {
                    print('Nama tidak boleh kosong');
                  }
                },
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
