import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_page.dart';


class WeightPage extends StatefulWidget {
  final String email;

  WeightPage({required this.email});

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int selectedWeight = 50;
  bool isSaving = false;

  Future<void> saveWeight() async {
    final url = Uri.parse('http://127.0.0.1:8000/save-weight/');
    setState(() {
      isSaving = true;
    });

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': widget.email,
          'weight': selectedWeight,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        print(data['message']);

        Navigator.push(
          context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        print('Failed to save weight: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save weight')),
        );
      }
    } catch (e) {
      print('Error saving weight: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1F47),
      appBar: AppBar(
        title: Text('Enter Your Weight', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E1F47),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Terakhir,\nBerapa berat badan mu?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 100,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedWeight = index + 30;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${index + 30}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      childCount: 120, // Range dari 30kg sampai 150kg
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Kg',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isSaving ? null : saveWeight,
              child: isSaving
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSaving ? Colors.grey : Colors.teal,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
