import 'package:flutter/material.dart';

class Islamic extends StatefulWidget {
  const Islamic({super.key});

  @override
  State<Islamic> createState() => _IslamicState();
}

class _IslamicState extends State<Islamic> {
  final List<String> islamicMonths = [
    'มุฮัรรอม',
    'ซอฟัร',
    'รอบีอุลเอาวัล',
    'รอบีอุษษานี',
    'ญุมาดาอุลเอาวัล',
    'ญุมาดาอุษษานี',
    'รอญับ',
    'ชะอฺบาน',
    'รอมฎอน',
    'เชาวาล',
    'ซุลกิอฺดะฮฺ',
    'ซุลฮิจญะฮฺ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ปฏิทินอิสลาม 12 เดือน"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: islamicMonths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.green.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Center(
                child: Text(
                  islamicMonths[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
