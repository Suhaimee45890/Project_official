import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/titile1.jpg", fit: BoxFit.cover),
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
                    height: 300,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
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
                        SizedBox(height: 80),
                        Text(
                          "Scan Halal Product !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "scan your product !",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(300, 60),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Get.toNamed("/login");
                          },
                          child: Text(
                            "Let’s Start >",
                            style: TextStyle(
                              fontSize: 25,
                              color: const Color.fromARGB(255, 255, 255, 255),
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
