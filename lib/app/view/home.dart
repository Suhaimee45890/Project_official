import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Our Services', style: GoogleFonts.poppins()),
=======
        // automaticallyImplyLeading: false,
        title: Text('Home', style: GoogleFonts.poppins()),
>>>>>>> 7e6d58d885c4fce0aca87463c90cf9ce52bcd8b2
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, const Color.fromARGB(255, 252, 99, 43)],
                begin: Alignment.topLeft,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 750,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      "Select Services",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  _buildServiceItem("Halal Scanner", "/scanner"),
                  SizedBox(height: 70),
                  _buildServiceItem("Prayer Time", "/prayerTime"),
                  SizedBox(height: 70),
                  _buildServiceItem("Compass", "/compass"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildServiceItem(String label, String route) {
  return Column(
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      InkWell(
        onTap: () {
          // print(route);
          Get.toNamed(route);
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // You can replace this Text "Icon" with an actual Icon widget if you want
                Text(" Icon ", style: GoogleFonts.poppins(color: Colors.white)),
                SizedBox(width: 10),
                Text(label, style: GoogleFonts.poppins(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
