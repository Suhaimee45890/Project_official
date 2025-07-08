import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohochat_address/ohochat_address.dart' as address;
import 'package:project_official/app/sevices/notifications.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  late List<Map<String, String>> prayerTimesList = [];
  Position? pos;
  final notification = Notifications();

  String location = "Loading...";
  String upcomingPrayer = "Loading...";
  String timeToGo = "";
  String sunriseTime = "--:--";
  String sunsetTime = "--:--";

  Future<void> determinePosition() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) return Future.error("Location services are disabled");

    LocationPermission permission = await Geolocator.checkPermission();
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
            '${results.first.districtName}, ${results.first.provinceName}';
      } else {
        location = '${placemarks[1].locality}, ${placemarks[1].isoCountryCode}';
      }
    } catch (e) {
      location = "Unable to fetch location";
    }

    final today = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final getConnect = GetConnect();
    final response = await getConnect.get(
      'https://api.aladhan.com/v1/timings/$today?latitude=${pos?.latitude}&longitude=${pos?.longitude}&method=3',
    );

    final data = response.body['data'];
    final timings = data['timings'];

    sunriseTime = timings['Sunrise'];
    sunsetTime = timings['Sunset'];

    prayerTimesList.add({
      'Fajr': timings['Fajr'],
      'Sunrise': timings['Sunrise'],
      'Dhuhr': timings['Dhuhr'],
      'Asr': timings['Asr'],
      'Maghrib': timings['Maghrib'],
      'Isha': timings['Isha'],
    });

    computeUpcomingPrayer(prayerTimesList[0]);
    setState(() {});
  }

  void computeUpcomingPrayer(Map<String, String> times) {
    DateTime now = DateTime.now();
    Map<String, DateTime> prayerDateTime = {};

    times.forEach((name, time) {
      final parts = time.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      prayerDateTime[name] = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );
    });

    for (var name in ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]) {
      if (prayerDateTime[name]!.isAfter(now)) {
        final diff = prayerDateTime[name]!.difference(now);
        setState(() {
          upcomingPrayer = name;
          timeToGo =
              "${diff.inHours} hours ${diff.inMinutes % 60} minutes to go";
        });
        return;
      }
    }

    final nextFajr = prayerDateTime["Fajr"]!.add(const Duration(days: 1));
    final diff = nextFajr.difference(now);
    setState(() {
      upcomingPrayer = "Fajr (Tomorrow)";
      timeToGo =
          "${diff.inHours} hours and ${diff.inMinutes % 60} minutes to go";
    });
  }

  IconData getPrayerIcon(String name) {
    switch (name) {
      case 'Fajr':
        return Icons.wb_twilight;
      case 'Sunrise':
        return Icons.wb_sunny;
      case 'Dhuhr':
        return Icons.wb_sunny_outlined;
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

  @override
  void initState() {
    super.initState();
    determinePosition();
    notification.notiRequest();
  }

  @override
  Widget build(BuildContext context) {
    final times = (prayerTimesList.isNotEmpty) ? prayerTimesList[0] : {};

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        title: Text(
          "เวลาละหมาด",
          style: GoogleFonts.sahitya(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF1B5E20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "UPCOMING PRAYER",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$upcomingPrayer  •  $timeToGo",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.brightness_5,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "sunset\n$sunsetTime",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.wb_sunny, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(
                                "sunrise\n$sunriseTime",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 🔔 PRAYER TIMES CONTAINER
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFECFCD4), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 14,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: times.entries.map((entry) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100, // ✅ วงกลมไอคอน
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  getPrayerIcon(entry.key),
                                  size: 24,
                                  color: Colors.amber.shade800, // ✅ สีไอคอน
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1B5E20),
                                  ),
                                ),
                              ),
                              Text(
                                entry.value,
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20, thickness: 0.8),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // 📣 NOTIFICATION SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stay Connected",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Never miss a prayer! You can enable notifications to alert you before each prayer time.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.green.shade900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            notification.showNotification(
                              "Next Prayer at: $upcomingPrayer",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.notifications_active),
                          label: const Text("Enable Prayer Alerts"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
