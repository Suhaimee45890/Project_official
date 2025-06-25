import 'package:flutter/material.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 200),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: 8,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "SCAN ME",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 246, 246, 246),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
