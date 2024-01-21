import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPortalWidget extends StatelessWidget {
  final List<Map<String, String>> newsLinks;

  const NewsPortalWidget(this.newsLinks, {super.key});

  void _launchURL(BuildContext context, String newsLink) async {
    if (await canLaunch(newsLink)) {
      await launch(newsLink);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Gagal membuka link.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: newsLinks.map((news) {
        return GestureDetector(
          onTap: () {
            _launchURL(context, news['link'] ?? '');
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news['title'] ?? 'Portal Berita',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Klik di sini untuk membuka portal berita',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
