import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dob_page.dart'; 

class GenderPage extends StatelessWidget {
  final String email; // Terima email dari halaman sebelumnya
  final String name; // Terima nama dari halaman sebelumnya

  GenderPage({required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    Future<void> submitGender(int gender) async {
      final url = Uri.parse('http://127.0.0.1:8000/save-gender/');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'email': email,   // Email yang diterima dari halaman sebelumnya
        'gender': gender  // 0 untuk Wanita, 1 untuk Pria
      });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DobPage(email: email), // Kirim email ke halaman DobPage
            ),
          );
        } else {
          print('Failed to update gender: {response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Gender', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E1F47),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF111332),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi $name!', // Tambahkan spasi setelah Hi
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih gender kamu, agar kami bisa mengenal kamu lebih baik.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                submitGender(0); // Kirim nilai 0 untuk Wanita
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF48C9B0), width: 1),
                ),
                child: Row(
                  children: [
                    Text(
                      '👧 Wanita',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                submitGender(1); // Kirim nilai 1 untuk Pria
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF2C2E43),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      '👨 Pria',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
