import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins()),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              trailing: Switch(
                value: isDarkMode,
                onChanged: (val) {
                  setState(() {
                    isDarkMode = val;
                  });
                  // ส่งค่าไปที่ ThemeProvider หรือใช้ callback
                  // ในตัวอย่างนี้ใช้ simple approach: ThemeController (ดูด้านล่าง)
                  ThemeSwitcher.of(context).changeTheme(val);
                },
              ),
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
              onTap: () {
                Get.toNamed("/");
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget สำหรับเปลี่ยน Theme
class ThemeSwitcher extends InheritedWidget {
  final _ThemeSwitcherState data;

  const ThemeSwitcher({super.key, required this.data, required super.child});

  static _ThemeSwitcherState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>()!.data;

  @override
  bool updateShouldNotify(ThemeSwitcher oldWidget) => true;
}

class ThemeController extends StatefulWidget {
  final Widget child;

  const ThemeController({super.key, required this.child});

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeController> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      data: this,
      child: MaterialApp(
        themeMode: _themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey.shade100,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: widget.child,
      ),
    );
  }
}
