import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_official/storage/storage.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar สีขาว
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            color: Colors.black, // Text สีดำ
            fontWeight: FontWeight.bold, // ตัวหนา
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black), // ปุ่ม back สีดำ
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSettingCard(
                  icon: Icons.lock,
                  title: "Privacy Policy",
                  onTap: () {
                    // TODO: ใส่หน้าหรือฟังก์ชันเมื่อกด
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.info,
                  title: "About App",
                  onTap: () {
                    // TODO: ใส่หน้าหรือฟังก์ชันเมื่อกด
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Storage().storageBox.remove("userId");
                    Storage().storageBox.remove("isLogin");
                    Get.offAllNamed("/");
                  },
                  color: Colors.white,
                  iconColor: Colors.red.shade600,
                  textColor: Colors.red.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.white,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
  }) {
    return Card(
      elevation: 3,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }
}
