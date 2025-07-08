import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_official/app/view/decoration/barcode.dart';

class Title1 extends StatefulWidget {
  const Title1({super.key});

  @override
  State<Title1> createState() => _Title1();
}

class _Title1 extends State<Title1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        // ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/Login5.jpg", fit: BoxFit.cover),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0x80000000),
          ),
          BarcodeScanner(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 11, 101, 52),
                          const Color.fromARGB(255, 30, 16, 16),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          "What you gonna do!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Scan your Halal Product ?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Check your Prayer Time ?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Check The Qiblat ?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   "scan your product !",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 20, color: Colors.black),
                        // ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(300, 60),
                            backgroundColor: const Color.fromARGB(
                              255,
                              253,
                              253,
                              253,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed("/login"); // <-- ใช้ GetX
                          },
                          child: Text(
                            "Let’s Start >",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: Colors.black,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
}
