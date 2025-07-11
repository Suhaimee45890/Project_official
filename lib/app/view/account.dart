import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_official/storage/storage.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AState();
}

class _AState extends State<Account> {
  late String name;
  late String lastname;
  late String email;
  late String birthday;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    final data = Storage().readAllData();
    name = data["name"] ?? "";
    lastname = data["lastname"] ?? "";
    email = data["email"] ?? "";
    birthday = data["birthday"] ?? "";
    imageUrl = Storage().readSingleData("imageUrl");
  }

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    String? uploadedUrl = await _uploadToCloudinary(imageFile);

    if (uploadedUrl != null) {
      setState(() {
        imageUrl = uploadedUrl;
      });

      Storage().saveSingleData("imageUrl", uploadedUrl);
    }
  }

  Future<String?> _uploadToCloudinary(File imageFile) async {
    const cloudName = 'your_cloud_name'; // TODO: เปลี่ยนเป็นของคุณ
    const uploadPreset =
        'your_unsigned_upload_preset'; // TODO: เปลี่ยนเป็นของคุณ

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resData = await response.stream.bytesToString();
      final jsonResponse = json.decode(resData);
      return jsonResponse['secure_url'];
    } else {
      print("Upload failed: ${response.statusCode}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Account', style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // แสดงรูปถ้ามี ถ้าไม่มีแสดงไอคอน account_circle
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? ClipOval(
                        child: Image.network(
                          imageUrl!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 120,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 120,
                        color: Colors.grey,
                      ),
              ),

              const SizedBox(height: 20),

              Text(
                '$name $lastname',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              Text(
                email,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
              ),

              Text(
                birthday,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _pickAndUploadImage,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: GoogleFonts.poppins(fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
