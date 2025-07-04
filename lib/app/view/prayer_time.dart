import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohochat_address/ohochat_address.dart' as address;

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime>
    with SingleTickerProviderStateMixin {
  int currentDayIndex = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late List<Map<String, String>> prayerTimesList = [];
  Position? pos;

  String currentDate = "Loading...";
  String hijriDate = "Loading...";
  String location = "กำลังดึงข้อมูล...";

  Future<void> determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    pos = await Geolocator.getCurrentPosition();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos!.latitude,
        pos!.longitude,
      );
      final postC = placemarks[1].postalCode;
      if (placemarks[1].isoCountryCode == "TH") {
        final locationTH = address.Location();
        List<address.DatabaseSchema> results = locationTH.execute(
          address.DatabaseSchemaQuery(postalCode: postC),
        );

        location =
            ' ${results.first.districtName} ,${results.first.provinceName}';
      } else {
        location =
            ' ${placemarks[1].thoroughfare} ,${placemarks[1].isoCountryCode}';
      }
    } catch (e) {
      location = "ไม่สามารถดึงข้อมูลพิกัดได้";
    }

    int today = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int tomorrow =
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000;
    int nextTomorrow =
        DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch ~/ 1000;
    final getConnect = GetConnect();
    List day = [today, tomorrow, nextTomorrow];
    List dayTitle = ["วันนี้", "พรุ่งนี้", "มะรืนนี้"];

    for (int i = 0; i < 3; i++) {
      final response = await getConnect.get(
        'https://api.aladhan.com/v1/timings/${day[i]}?latitude=${pos?.latitude}&longitude=${pos?.longitude}&method=3',
      );
      final data = response.body['data'];
      final timings = data['timings'];
      if (i == 0) {
        final date = data["date"];
        currentDate = date['gregorian']['date'];
        hijriDate =
            "${date['hijri']['day']} ${date['hijri']['month']['en']} ${date['hijri']['year']} AH";
      }
      prayerTimesList.add({
        'day': dayTitle[i],
        'Fajr': timings['Fajr'],
        'Subhi': timings['Sunrise'],
        'Dhuhr': timings['Dhuhr'],
        'Asr': timings['Asr'],
        'Maghrib': timings['Maghrib'],
        'Isha': timings['Isha'],
      });
    }

    setState(() {});
  }

  void _changeDay(int direction) {
    setState(() {
      currentDayIndex = (currentDayIndex + direction) % prayerTimesList.length;
      if (currentDayIndex < 0) currentDayIndex += prayerTimesList.length;
    });
    _controller.forward(from: 0);
  }

  IconData getPrayerIcon(String name) {
    switch (name) {
      case 'Fajr':
        return Icons.wb_twilight;
      case 'Subhi':
        return Icons.wb_sunny_sharp;
      case 'Dhuhr':
        return Icons.wb_sunny;
      case 'Asr':
        return Icons.brightness_medium;
      case 'Maghrib':
        return Icons.wb_twilight_outlined;
      case 'Isha':
        return Icons.nightlight_round;
      default:
        return Icons.access_time;
    }
  }

  Widget roundArrowButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.orange.shade800, size: 24),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    determinePosition();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = (prayerTimesList.isNotEmpty)
        ? prayerTimesList[currentDayIndex]
        : {
            'day': 'Loading',
            'Fajr': '--:--',
            'Subhi': '--:--',
            'Dhuhr': '--:--',
            'Asr': '--:--',
            'Maghrib': '--:--',
            'Isha': '--:--',
          };

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE57F), Color(0xFFFFC107)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDate,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        hijriDate,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Prayer Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          location,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            roundArrowButton(
                              Icons.chevron_left,
                              () => _changeDay(-1),
                            ),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: Text(
                                currentDay['day']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            roundArrowButton(
                              Icons.chevron_right,
                              () => _changeDay(1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(),
                        const SizedBox(height: 10),
                        ...[
                          "Fajr",
                          "Subhi",
                          "Dhuhr",
                          "Asr",
                          "Maghrib",
                          "Isha",
                        ].map(
                          (name) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    getPrayerIcon(name),
                                    size: 22,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  currentDay[name]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Notification Box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "แจ้งเตือนเวลาละหมาด",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "คุณสามารถตั้งค่าการเตือนในเวลาที่เหมาะสม และเปิด/ปิดเสียงได้ตามต้องการ เพื่อไม่พลาดเวลาสำคัญของคุณ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
