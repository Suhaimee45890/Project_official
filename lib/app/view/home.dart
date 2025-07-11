import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_official/storage/storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? imageUrl;
  String userName = "Suhaimee"; // ตัวอย่างชื่อ user

  @override
  void initState() {
    super.initState();
    imageUrl = Storage().readSingleData("imageUrl");
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "อัสสลามุอะลัยกุมตอนเช้า ";
    if (hour < 17) return "สุขสันต์ยามบ่าย";
    return "เย็นนี้อย่าลืมละหมาดมัฆริบ";
  }

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
        'title': 'Mosque Nearby',
        'subtitle': 'มัสยิดใกล้เคียง',
        'icon': Icons.location_on,
        'route': "/mosqueNearby",
      },
      {
        'title': 'News',
        'subtitle': 'ข่าวสาร/บทความ',
        'icon': Icons.article,
        'route': "/islamicArticlesPage",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Hi , $userName",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/account"); // ไปหน้าโปรไฟล์
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? NetworkImage(imageUrl!)
                    : null,
                child: (imageUrl == null || imageUrl!.isEmpty)
                    ? const Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
          ),
        ],
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 11, 101, 52),
                Color.fromARGB(255, 11, 101, 52),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Greeting Text
            Text(
              getGreeting(),
              style: GoogleFonts.notoSansThai(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 11, 101, 52),
              ),
            ),
            const SizedBox(height: 16),

            // 🟢 Prayer Time Card
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/prayerTime'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2FDE0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xFF0B6534),
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Prayer: Asr at 15:40",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Tap to view full prayer times",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🟢 Grid Menu
            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                            backgroundColor: const Color.fromARGB(
                              255,
                              11,
                              101,
                              52,
                            ),
                            radius: 26,
                            child: Icon(
                              service['icon'],
                              color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
