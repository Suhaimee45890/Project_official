import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyMosqueMap extends StatelessWidget {
  const NearbyMosqueMap({super.key});

  Future<void> _openGoogleMaps() async {
    try {
      // ขอสิทธิ์ location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return;
        }
      }

      // หาตำแหน่ง
      final pos = await Geolocator.getCurrentPosition();
      final lat = pos.latitude;
      final lon = pos.longitude;

      // ลิงก์ Google Maps ค้นหา "มัสยิด" ใกล้พิกัดนั้น
      final url = Uri.parse(
        'https://www.google.com/maps/search/มัสยิด/@$lat,$lon,15z',
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('ไม่สามารถเปิดลิงก์ได้: $url');
      }
    } catch (e) {
      debugPrint('เกิดข้อผิดพลาด: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ค้นหามัสยิด')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _openGoogleMaps,
          icon: const Icon(Icons.map),
          label: const Text('เปิด Google Maps'),
        ),
      ),
    );
  }
}
