import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
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
  List page = [Account(), Home(), Setting()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[pageIndex],
      bottomNavigationBar: BottomBar(
        selectedIndex: pageIndex,
        onTap: (int value) {
          pageIndex = value;
          setState(() {});
          print(value);
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
}
