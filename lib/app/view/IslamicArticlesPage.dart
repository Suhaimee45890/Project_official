import 'package:flutter/material.dart';
import 'package:project_official/app/view/IslamicArticleDetailPage.dart';

class IslamicArticlesPage extends StatelessWidget {
  const IslamicArticlesPage({super.key});

  final List<Map<String, String>> articles = const [
    {
      'title': '5 เสาหลักแห่งอิสลาม',
      'date': '4 กรกฎาคม 2025',
      'image':
          'https://smarthistory.org/wp-content/uploads/2022/01/3343681248_16a178708f_o-scaled.jpg',
      'summary':
          'ทำความเข้าใจหลักการพื้นฐานของอิสลาม ที่เป็นรากฐานของศรัทธาและการปฏิบัติของมุสลิม',
      'content':
          'เสาหลักทั้งห้า ได้แก่ ชะฮาดะฮ์ (การปฏิญาณ), ซอลาฮ์ (การละหมาด), ซะกาต (การบริจาค), ศีลอด (การถือศีลอด) และฮัจญ์ (การแสวงบุญ).',
    },
    {
      'title': 'คุณค่าของการละหมาด 5 เวลา',
      'date': '3 กรกฎาคม 2025',
      'image':
          'https://www.islamic-relief.org.uk/wp-content/smush-webp/2024/07/Salah-hero.jpg.webp',
      'summary':
          'การละหมาดคือเส้นทางสู่การเชื่อมโยงกับอัลลอฮ์ในแต่ละช่วงของวัน',
      'content':
          'ละหมาด 5 เวลาเปรียบเสมือนเครื่องเตือนใจในชีวิตประจำวันที่มุ่งสู่ความสงบ ความมีวินัย และการรำลึกถึงพระผู้เป็นเจ้า.',
    },
    {
      'title': 'เดือนเราะมะฎอน: ความหมายและเป้าหมาย',
      'date': '1 กรกฎาคม 2025',
      'image':
          'https://img.freepik.com/premium-vector/ramadan-kareem-mosque-muslim-arabic-traditional-architecture-islam-eid-mubarak-prayer-iftar-night-with-purple-moon-holiday-fasting-religious-poster-banner-vector-illustration_176516-8460.jpg',
      'summary': 'เราะมะฎอนคือเดือนแห่งความเมตตา การให้อภัย และการละเว้น',
      'content':
          'เป็นช่วงเวลาที่มุสลิมทั่วโลกอดอาหารในช่วงกลางวัน เพื่อฝึกฝนความอดทน การเสียสละ และจิตวิญญาณแห่งความศรัทธา.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข่าวสารและบทความอิสลาม'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => IslamicArticleDetailPage(article: article),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      article['image']!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article['date']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          article['summary']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
