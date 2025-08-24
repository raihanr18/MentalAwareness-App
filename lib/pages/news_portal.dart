import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'view_article.dart';

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
    const apiKey = '9962a36ac84d4b498e95bb0959a34c84';
    final List<String> keywords = ['mental%20health', 'psikologi', 'jiwa'];

    Set<Article> uniqueArticles = {};
    int articlesCount = 0;

    for (String keyword in keywords) {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data != null && data.containsKey('articles')) {
          List<dynamic> articlesData = data['articles'];
          List<Article> articles = articlesData.map((articleData) {
            return Article(
              title: articleData['title'] ?? 'Tidak Ada Judul',
              imageUrl:
                  articleData['urlToImage'] ?? "https://picsum.photos/200/300",
              author: articleData['author'] ?? 'Tidak Diketahui',
              postedOn: articleData['publishedAt'] ?? 'Tidak Diketahui',
              content: articleData['content'] ?? '',
            );
          }).toList();

          uniqueArticles.addAll(articles);

          articlesCount += articles.length;

          if (articlesCount >= 5) {
            break;
          }
        } else {
          // print('Data dari salah satu API bernilai null atau tidak memiliki properti "articles".'); // Commented out for production
        }
      } else {
        // print('Gagal memuat berita. Kode status: ${response.statusCode}'); // Commented out for production
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
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _articles[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewArticle(article: item),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text("${item.author} · ${item.postedOn}",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item.imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            item.content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
  final String content;

  Article({
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.postedOn,
    required this.content,
  });
}
