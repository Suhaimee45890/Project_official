import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_bar/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 1;
  final _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
          print("Page changed to index: $index");
        },
        children: [_buildAccountPage(), _buildHomePage(), _buildSettingsPage()],
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
          print("Bottom bar tapped: $index");
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.black,
          ),
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.black,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }

  /// Account page
  Widget _buildAccountPage() {
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
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
              'johndoe@example.com',
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Home page
  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: GoogleFonts.poppins()),
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
                      SizedBox(height: 80),
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
        ],
      ),
    );
  }

  /// Service item widget with navigation
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
            print(route);
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
                  Text(
                    " Icon ",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
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

  /// Settings page
  Widget _buildSettingsPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Language", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Mode", style: GoogleFonts.poppins()),
              trailing: Switch(value: false, onChanged: (val) {}),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Privacy Policy", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About App", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
