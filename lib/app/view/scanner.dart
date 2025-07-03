import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final scanBorderSize = screenSize.width * 0.7;
    final scanTop = screenSize.height * 0.25;
    const double scanLinePadding = 16.0;

    final scanLeft = (screenSize.width - scanBorderSize) / 2;

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

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('พบรหัส: ${barcode.rawValue}')),
                  );
                  Get.toNamed("/afterScan", arguments: this.barcode);
                }
              }
            },
          ),

          // ชั้น Mask สีดำรอบกรอบสแกน
          Positioned.fill(
            child: Stack(
              children: [
                // Top Mask
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: scanTop,
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
                // Bottom Mask
                Positioned(
                  top: scanTop + scanBorderSize,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
                // Left Mask
                Positioned(
                  top: scanTop,
                  left: 0,
                  width: scanLeft,
                  height: scanBorderSize,
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
                // Right Mask
                Positioned(
                  top: scanTop,
                  right: 0,
                  width: scanLeft,
                  height: scanBorderSize,
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),

          // กรอบสแกน
          Positioned(
            top: scanTop,
            left: scanLeft,
            child: Container(
              width: scanBorderSize,
              height: scanBorderSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),

          // เส้นสแกนวิ่ง
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Positioned(
                top:
                    scanTop +
                    (_animation.value *
                        (scanBorderSize - scanLinePadding * 2)) +
                    scanLinePadding,
                left: scanLeft + scanLinePadding,
                child: Container(
                  width: scanBorderSize - scanLinePadding * 2,
                  height: 2,
                  color: Colors.greenAccent,
                ),
              );
            },
          ),

          // ข้อความใต้กรอบ
          Positioned(
            top: scanTop + scanBorderSize + 16,
            width: screenSize.width,
            child: Center(
              child: Text(
                'Scanning barcode...',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // ข้อความด้านล่างสุด
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Text(
                barcode == null
                    ? 'กรุณานำกล้องไปยังบาร์โค้ดหรือ QR Code'
                    : 'สแกนสำเร็จ: $barcode',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
