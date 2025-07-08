// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_official/app/view/frame.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _obscureText = true;

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      // สร้างบัญชี Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      String uid = userCredential.user!.uid;

      // บันทึกข้อมูลเพิ่มเติมลง Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'lastname': lastnameController.text.trim(),
        'email': emailController.text.trim(),
        'dob': _dobController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ย้ายไปหน้า Home (Frame)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Frame()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'email-already-in-use') {
        message = "อีเมลนี้ถูกใช้แล้ว";
      } else if (e.code == 'weak-password') {
        message = "รหัสผ่านควรมีอย่างน้อย 6 ตัวอักษร";
      } else {
        message = e.message ?? "เกิดข้อผิดพลาด";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("เกิดข้อผิดพลาด")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 11, 101, 52),
                  const Color.fromARGB(255, 30, 16, 16),
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Center(
                child: Text(
                  'Let’s Sign you in',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  children: [
                    Text(
                      "ยินดีต้อนรับสู่ระบบของเรา ใช้บริการฟรี",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "ทุกฟังก์ชั่น เพียงเข้าสู่ระบบตอนนี้",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "แล้วเริ่มต้นการเดินทางฮาลาลของคุณ!",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 650,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFFD9D9D9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Register",
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          _buildTextField("Email", emailController),
                          _buildTextField("Name", nameController),
                          _buildTextField("Lastname", lastnameController),
                          _buildPasswordField("Password", passwordController),
                          _buildPasswordField(
                            "Confirm Password",
                            confirmPasswordController,
                          ),
                          _buildDateField(),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: register,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          labelText: label,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: _dobController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              _dobController.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            });
          }
        },
        decoration: InputDecoration(
          labelText: "Date of Birth",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
