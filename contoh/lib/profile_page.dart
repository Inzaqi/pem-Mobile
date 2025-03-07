import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';


class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token, required String email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final url = Uri.parse("http://127.0.0.1:8000/user-profile/");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${widget.token}",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        _showErrorDialog("Gagal", "Gagal mengambil profil: ${response.statusCode}");
      }
    } catch (e) {
      _showErrorDialog("Error", "Terjadi kesalahan: $e");
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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
    return WillPopScope(
    onWillPop: () async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Halaman login
        (route) => false, // Menghapus semua rute sebelumnya
      );
      return false; // Cegah aksi back default
    },

    child: Scaffold(
      backgroundColor: Color(0xFF1E1F47),
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E1F47),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/sleepy2.png"),
                  ),
                  SizedBox(height: 16),
                  buildInfoTile("Nama", userData["name"], Icons.person),
                  buildInfoTile("Email", userData["email"], Icons.email),
                  buildInfoTile("Gender", userData["gender"] == 0 ? "Female" : "Male", Icons.transgender),
                  buildInfoTile("Date of birth", userData["date_of_birth"], Icons.calendar_today),
                  buildInfoTile("Height", "${userData["height"]} Cm", Icons.height),
                  buildInfoTile("Weight", "${userData["weight"]} Kg", Icons.monitor_weight),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF48C9B0),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1E1F47),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white,
        currentIndex: 2, // Profile tab aktif
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Jurnal Tidur',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    ),
    );
  }

  Widget buildInfoTile(String title, dynamic value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: title,
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Color(0xFF2C2E43),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
        initialValue: value?.toString() ?? "Not set",
      ),
    );
  }
}
