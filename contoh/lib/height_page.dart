import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weight_page.dart'; // Pastikan WeightPage diimpor

class HeightPage extends StatefulWidget {
  final String email; // Terima email dari halaman sebelumnya

  HeightPage({required this.email});

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int selectedHeight = 165; // Default tinggi badan

  Future<void> submitHeight() async {
    final url = Uri.parse('http://127.0.0.1:8000/save-height/');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': widget.email,
      'height': selectedHeight, // Kirim tinggi badan yang dipilih
    });

    try {
      print('Sending data: $body'); // Debug log
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Height saved successfully!');
        // Navigasi ke halaman berikutnya (WeightPage)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeightPage(email: widget.email), // Kirim email ke WeightPage
          ),
        );
      } else {
        print('Failed to save height: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1F47),
      appBar: AppBar(
        title: Text('Enter Your Height', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E1F47),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selanjutnya,',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Berapa tinggi badan mu?',
                style: TextStyle(fontSize: 16, color: Colors.white54),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D2E5E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<int>(
                      value: selectedHeight,
                      dropdownColor: Color(0xFF2D2E5E),
                      items: List.generate(141, (index) => 100 + index)
                          .map((height) => DropdownMenuItem(
                                value: height,
                                child: Text(
                                  '$height',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedHeight = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Cm',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  submitHeight();
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
