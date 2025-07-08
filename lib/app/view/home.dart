import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Halal Scanner',
        'subtitle': 'สแกนฮาลาล',
        'icon': Icons.qr_code_scanner,
        'route': '/scanner',
      },
      {
        'title': 'Prayer Time',
        'subtitle': 'เวลาละหมาด',
        'icon': Icons.access_time,
        'route': '/prayerTime',
      },
      {
        'title': 'Compass',
        'subtitle': 'เข็มทิศหากิบลัต',
        'icon': Icons.explore,
        'route': '/compass',
      },
      {
        'title': 'มัสยิดใกล้เคียง',
        'subtitle': 'Coming Soon',
        'icon': Icons.location_on,
        'route': "/nearbyMosqueMap",
      },
      {
        'title': 'ข่าวสาร/บทความ',
        'subtitle': 'Coming Soon',
        'icon': Icons.article,
        'route': "/islamicArticlesPage",
      },
      {
        'title': 'ปฏิทินอิสลาม',
        'subtitle': 'Coming Soon',
        'icon': Icons.calendar_month,
        'route': "/islamicArticlesPage",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Our Services",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 11, 101, 52),
                const Color.fromARGB(255, 11, 101, 52),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, service['route']),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 11, 101, 52),

                      radius: 26,
                      child: Icon(
                        service['icon'],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      service['title'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['subtitle'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
