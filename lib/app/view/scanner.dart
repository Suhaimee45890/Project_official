import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with SingleTickerProviderStateMixin {
  String? barcode;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanBorderSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Scan Product',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (this.barcode != barcode.rawValue) {
                  setState(() {
                    this.barcode = barcode.rawValue;
                  });

                  // Optional: แสดง dialog หรือ navigate ไปหน้าอื่น
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('พบรหัส: ${barcode.rawValue}')),
                  );
                }
              }
            },
          ),
          // กรอบสแกน
          Center(
            child: Container(
              width: scanBorderSize,
              height: scanBorderSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          // เส้นแสกนวิ่ง
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.2 +
                    (_animation.value * scanBorderSize),
                left: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  width: scanBorderSize,
                  height: 2,
                  color: Colors.greenAccent,
                ),
              );
            },
          ),
          // ข้อความด้านล่าง
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Text(
                barcode == null
                    ? 'กรุณานำกล้องไปยังบาร์โค้ดหรือ QR Code'
                    : 'สแกนสำเร็จ: $barcode',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
