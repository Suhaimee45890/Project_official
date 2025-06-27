import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halal Scanner")),
      body: Center(
        child: Text("This is the Scanner Page", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
