import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double _direction = 0;

  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _compassSubscription = FlutterCompass.events?.listen((CompassEvent event) {
      if (event.heading != null) {
        setState(() {
          _direction = event.heading!;
        });
      }
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTargetDirection = (_direction >= 275 && _direction <= 285);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          "Compass",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [Icon(Icons.menu, color: Colors.white)],
      ),
      backgroundColor: isTargetDirection ? Colors.green : Colors.blueGrey[900],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // วงกลม
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white54, width: 6),
              ),
            ),

            // เข็มหมุน
            Transform.rotate(
              angle: ((_direction) * (pi / 180) * -1),
              child: Icon(Icons.navigation, color: Colors.white, size: 120),
            ),

            // แสดงองศา
            Positioned(
              bottom: 60,
              child: Text(
                "${_direction.toStringAsFixed(0)}°",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // คำเตือนเมื่อถึงเป้า
            if (isTargetDirection)
              Positioned(
                top: 80,
                child: Text(
                  "คุณกำลังชี้ไปที่ 280°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
