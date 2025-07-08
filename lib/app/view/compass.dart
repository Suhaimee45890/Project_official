import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double? _heading;

  static const double targetAngle = 286.0; // ทิศที่ต้องการ (286°)
  static const double tolerance = 5.0; // ±5°

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading;
      });
    });
  }

  bool isAligned() {
    if (_heading == null) return false;
    double heading = (_heading! + 360) % 360; // normalize 0-360
    double diff = (heading - targetAngle).abs();
    if (diff > 180) diff = 360 - diff; // ปรับหามุมที่สั้นที่สุด
    return diff <= tolerance;
  }

  @override
  Widget build(BuildContext context) {
    final aligned = isAligned();

    // คำนวณมุมหมุน (normalized 0-360 องศา แปลงเป็นเรเดียน)
    double angleInDegrees = ((_heading ?? 0) - targetAngle) % 360;
    double angleInRadians = angleInDegrees * (math.pi / 180);

    return Scaffold(
      backgroundColor: aligned ? Colors.green.shade100 : Colors.white,
      appBar: AppBar(
        title: const Text('เข็มทิศ 286° ±5°'),
        backgroundColor: const Color.fromARGB(255, 11, 101, 52),

        centerTitle: true,
      ),
      body: Center(
        child: _heading == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: angleInRadians,
                    child: Icon(
                      Icons.navigation,
                      size: 200,
                      color: aligned ? Colors.green.shade800 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Heading: ${_heading!.toStringAsFixed(2)}°',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Target: $targetAngle° ±$tolerance°',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  if (aligned)
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        '✅ ชี้ถูกต้อง!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
