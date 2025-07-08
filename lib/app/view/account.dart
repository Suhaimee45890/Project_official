import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AState();
}

class _AState extends State<Account> {
  // File? = _image ;
  // String? _uploadedUrl ;
  // final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 33, 86, 57),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 50, 160, 99),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Siaberm@gmail.com',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                "Phone",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                "+66 812345678",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.white),
              title: Text(
                "Birthday",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                "January 1, 1990",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
