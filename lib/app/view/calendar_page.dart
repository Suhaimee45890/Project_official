import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IslamicCalendarPage extends StatelessWidget {
  const IslamicCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hijriYear = "1446";
    final hijriMonth = "Muharram";
    final nextMonth = "Safar";

    final upcomingEvents = [
      {"date": "1", "day": "Ahad", "event": "Islamic New Year"},
    ];

    final upcomingFasting = [
      {"day": "Monday and Thursday fasting", "date": ""},
      {"day": "Tasu’a fasting", "date": "9", "color": Colors.purple},
      {"day": "Asyura fasting", "date": "10-11", "color": Colors.orange},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Islamic Calendar"),
        backgroundColor: const Color(0xFF0B6534),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hijri header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hijriYear,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$hijriMonth → $nextMonth",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Simple static calendar
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(35, (index) {
                final dayNum = index - 2;
                return Center(
                  child: dayNum > 0 && dayNum <= 30
                      ? Text(
                          "$dayNum",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: dayNum == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: dayNum == 1 ? Colors.brown : Colors.black87,
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Upcoming Events
            Text(
              "Upcoming events",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...upcomingEvents.map(
              (e) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(e["day"]!, style: const TextStyle(fontSize: 12)),
                        Text(
                          e["date"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Text(
                  e["event"]!,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "Upcoming fasting",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...upcomingFasting.map(
              (f) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: f["date"] == ""
                    ? const Icon(Icons.star_border, color: Color(0xFF0B6534))
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "date",
                          style: GoogleFonts.poppins(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                title: Text("d", style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),

      // Bottom Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {},
            ),
            IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            const SizedBox(width: 40), // space for FAB
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add event
        },
        backgroundColor: const Color(0xFF0B6534),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
