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
    Get.offAllNamed("/frame"); // ✅ เปลี่ยนหน้าและล้าง history
  } on FirebaseException catch (e) {
    String message = "";
    if (e.code == "user-not-found") {
      message = "No user found for that email";
    } else if (e.code == "wrong-password") {
      message = "Wrong Password";
    } else {
      message = e.message ?? "an error occurred";
    }
    Get.snackbar(
      "Login Failed",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
    );
  }
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255), // พื้นหลังปุ่ม
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/login.jpg", fit: BoxFit.cover),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0x90000000),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(
                child: Image.asset("assets/images/appLogo1.png", width: 250),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: 600,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber,
                          const Color.fromARGB(255, 167, 21, 21),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Welcome Back!",

                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Please sign in to continue."
                                  "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text(
                                //   "via this app directly and confidence !",
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: Colors.black,
                                //     fontSize: 20,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            obscureText: false,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
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
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 30),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          "Login ",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "or continue with",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google login
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // กำหนดมุมโค้ง
                            child: InkWell(
                              onTap: () {
                                login();
                              },
                              child: Image.asset(
                                'assets/images/Google.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // ทำให้รูปภาพเต็มพื้นที่และไม่เบี้ยว
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // กำหนดมุมโค้ง
                            child: InkWell(
                              onTap: () {
                                Get.toNamed("/");
                              },
                              child: Image.asset(
                                'assets/images/X.jpeg',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // ทำให้รูปภาพเต็มพื้นที่และไม่เบี้ยว
                              ),
                            ),
                          ),
                          SizedBox(width: 20),

                          // Facebook login
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // กำหนดมุมโค้ง
                            child: InkWell(
                              onTap: () {
                                Get.toNamed("/");
                              },
                              child: Image.asset(
                                'assets/images/faceboook.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // ทำให้รูปภาพเต็มพื้นที่และไม่เบี้ยว
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ), // ไปหน้านี้
                          );
                        },
                        child: Text(
                          'Create a new account ?',
                          style: TextStyle(
                            decoration: TextDecoration.underline, // เส้นใต้
                            color: Colors.white, // สีเหมือนลิงก์
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
