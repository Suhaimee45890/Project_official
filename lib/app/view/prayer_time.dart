import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final List<Map<String, String>> prayerTimesList = [
    {
      'day': 'Today',
      'Fajr': '05:00 AM',
      'Dhuhr': '12:15 PM',
      'Asr': '03:45 PM',
      'Maghrib': '06:30 PM',
      'Isha': '08:00 PM',
    },
    {
      'day': 'Tomorrow',
      'Fajr': '05:01 AM',
      'Dhuhr': '12:16 PM',
      'Asr': '03:46 PM',
      'Maghrib': '06:31 PM',
      'Isha': '08:01 PM',
    },
    {
      'day': 'Next Day',
      'Fajr': '05:02 AM',
      'Dhuhr': '12:17 PM',
      'Asr': '03:47 PM',
      'Maghrib': '06:32 PM',
      'Isha': '08:02 PM',
    },
  ];

  void _changeDay(int direction) {
    setState(() {
      currentDayIndex = (currentDayIndex + direction) % prayerTimesList.length;
      if (currentDayIndex < 0) currentDayIndex += prayerTimesList.length;
    });
    _controller.forward(from: 0);
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = prayerTimesList[currentDayIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Prayer Time",
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0f2027),
                  Color(0xFF203a43),
                  Color(0xFF2c5364),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // วันที่
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wednesday, June 18",
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "22 Dhu Hijrah 1446 AH",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // กล่องเวลา
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Prayer Time",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ปุ่มเลือกวัน
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => _changeDay(-1),
                              child: ScaleTransition(
                                scale: _scaleAnimation,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            Text(
                              currentDay['day']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _changeDay(1),
                              child: ScaleTransition(
                                scale: _scaleAnimation,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // แสดงเวลาละหมาด
                        ...["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].map((
                          name,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  currentDay[name]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // กล่องอธิบาย
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "นี่คือหน้าแจ้งเตือนเวลาละหมาด",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "คุณสามารถตั้งค่าการเตือนในเวลาที่เหมาะสม และเปิด/ปิดเสียงได้ตามต้องการ เพื่อไม่พลาดเวลาสำคัญของคุณ",
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
