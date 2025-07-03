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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
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
              ),
            ),
            Text(
              'Siaberm@gmail.com',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone", style: GoogleFonts.poppins()),
              subtitle: Text("+66 812345678", style: GoogleFonts.poppins()),
            ),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text("Birthday", style: GoogleFonts.poppins()),
              subtitle: Text("January 1, 1990", style: GoogleFonts.poppins()),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
