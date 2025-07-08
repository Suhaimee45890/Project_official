import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_official/app/view/register.dart';
import 'package:project_official/storage/storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passWordlController = TextEditingController();

Future<void> login() async {
  try {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passWordlController.text.trim(),
    );
    Storage().saveData(user.user?.uid ?? "");
    Get.offAllNamed("/frame");
  } on FirebaseException catch (e) {
    String message = "";
    if (e.code == "user-not-found") {
      message = "No user found for that email";
    } else if (e.code == "wrong-password") {
      message = "Wrong Password";
    } else {
      message = e.message ?? "An error occurred";
    }
    Get.snackbar(
      "Login Failed",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ป้องกัน overflow
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, bottom: 8),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,
      ),
      body: Stack(
        children: [
          // พื้นหลัง
          SizedBox.expand(
            child: Image.asset("assets/images/Login5.jpg", fit: BoxFit.cover),
          ),
          Container(color: const Color(0x90000000)),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 100,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/appLogo1.png",
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Password
                  TextField(
                    controller: passWordlController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 45),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      login();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // or continue with
                  Text(
                    "or continue with",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Social Logins
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton("assets/images/Google.jpg", () {
                        login(); // หรือเพิ่มฟังก์ชัน Google Login
                      }),
                      const SizedBox(width: 15),
                      _buildSocialButton("assets/images/X.jpeg", () {
                        Get.toNamed("/");
                      }),
                      const SizedBox(width: 15),
                      _buildSocialButton("assets/images/faceboook.jpg", () {
                        Get.toNamed("/");
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Register Link
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create a new account ?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String imagePath, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
      ),
    );
  }
}
