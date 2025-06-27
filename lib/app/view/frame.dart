import 'package:flutter/material.dart';
import 'package:project_official/app/view/account.dart';
import 'package:project_official/app/view/home.dart';
import 'package:project_official/app/view/setting.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _HomeState();
}

class _HomeState extends State<Frame> {
  int pageIndex = 1;

  final List<Widget> page = [const Account(), const Home(), const Setting()];

  @override
  Widget build(BuildContext context) {
    final Color navBgColor =
        Theme.of(context).appBarTheme.backgroundColor ?? Colors.white;
    final Color navTextColor =
        Theme.of(context).appBarTheme.foregroundColor ?? Colors.black;

    return Scaffold(
      body: page[pageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: navBgColor,
          indicatorColor: navTextColor.withOpacity(0.1),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: navTextColor),
          ),
          iconTheme: MaterialStateProperty.all(
            IconThemeData(color: navTextColor),
          ),
        ),
        child: NavigationBar(
          selectedIndex: pageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Account',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
