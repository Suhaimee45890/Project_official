import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AState();
}

class _AState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Account")));
  }
}

Widget _buildAccountPage() {
  return Stack(
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
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 750,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "Our Services",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  _buildServiceItem("Halal Scanner", "/halal"),
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
    ],
  );
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
        onTap: () {},
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
