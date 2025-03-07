import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'height_page.dart';

class DobPage extends StatefulWidget {
  final String email;

  DobPage({required this.email});

  @override
  State<DobPage> createState() => _DobPageState();
}

class _DobPageState extends State<DobPage> {
  DateTime selectedDate = DateTime(2000, 1, 1);

  Future<void> submitDob() async {
    final url = Uri.parse('http://127.0.0.1:8000/save-dob/');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': widget.email,
      'date_of_birth': selectedDate.toIso8601String().split('T')[0],
    });

    try {
      print('Sending data: $body');
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Date of birth saved successfully!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeightPage(email: widget.email),
          ),
        );
      } else {
        print('Failed to save date of birth: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Date of Birth', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E1F47),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1E1F47),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Terima kasih!',
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Sekarang, kapan tanggal lahir mu?',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
              height: 200,
              child: Theme(
                data: Theme.of(context).copyWith(
                  cupertinoOverrideTheme: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
            ),
          ),

              SizedBox(height: 20),
              GestureDetector(
                onTap: submitDob,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2E5E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${selectedDate.day.toString().padLeft(2, '0')} / ${selectedDate.month.toString().padLeft(2, '0')} / ${selectedDate.year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
