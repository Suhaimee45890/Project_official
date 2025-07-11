import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_official/app/view/IslamicArticleDetailPage.dart';

class IslamicArticlesPage extends StatefulWidget {
  const IslamicArticlesPage({super.key});

  @override
  State<IslamicArticlesPage> createState() => _IslamicArticlesPageState();
}

class _IslamicArticlesPageState extends State<IslamicArticlesPage> {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? articlesFirebase;
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchNews() async {
    final data = await FirebaseFirestore.instance.collection("news").get();

    return data.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articlesFirebase = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ข่าวสารและบทความอิสลาม',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 101, 52),
      ),
      body: FutureBuilder(
        future: articlesFirebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // ❌ เมื่อเกิดข้อผิดพลาด
            return Center(child: Text("เกิดข้อผิดพลาด: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // ℹ️ ไม่มีข้อมูล
            return const Center(child: Text("ยังไม่มีข่าว"));
          } else {
            final articles = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: articles?.length,
              itemBuilder: (context, index) {
                final article = articles?[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            IslamicArticleDetailPage(article: articles?[index]),
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
                            article?['image']!,
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
                                article?['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                article?['date']!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                article?['summary']!,
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
            );
          }
        },
      ),
    );
  }
}
