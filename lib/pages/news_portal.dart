import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPortal extends StatefulWidget {
  const NewsPortal({super.key});

  @override
  State<NewsPortal> createState() => _NewsPortalState();
}

class _NewsPortalState extends State<NewsPortal> {
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
      const apiKey = '55d4db72b5a84eb3a0b7aae322058088';

      final List<String> keywords = ['mental%20health', 'psikologi', 'jiwa'];

      Set<Article> uniqueArticles = {};

      for (String keyword in keywords) {
        final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'));

        if (response.statusCode == 200) {
          final Map<String, dynamic>? data = json.decode(response.body);

          if (data != null && data.containsKey('articles')) {
            List<dynamic> articlesData = data['articles'];
            List<Article> articles = articlesData.map((articleData) {
              return Article(
                title: articleData['title'] ?? 'Tidak Ada Judul',
                imageUrl: articleData['urlToImage'] ?? "https://picsum.photos/200/300",
                author: articleData['author'] ?? 'Tidak Diketahui',
                postedOn: articleData['publishedAt'] ?? 'Tidak Diketahui',
              );
            }).toList();

            uniqueArticles.addAll(articles);
          } else {
            print('Data dari salah satu API bernilai null atau tidak memiliki properti "articles".');
          }
        } else {
          print('Gagal memuat berita. Kode status: ${response.statusCode}');
        }
      }

      _articles = uniqueArticles.toList(); 
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _articles[index];
                return Container(
                  height: 136,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text("${item.author} · ${item.postedOn}",
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icons.bookmark_border_rounded,
                                Icons.share,
                                Icons.more_vert
                              ].map((e) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(e, size: 16),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item.imageUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article({
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.postedOn,
  });
}
