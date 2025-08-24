import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/news_portal.dart';

class ViewArticle extends StatefulWidget {
  final Article article;

  const ViewArticle({super.key, required this.article});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  bool _showFullContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar berita
            Image.network(widget.article.imageUrl),

            const SizedBox(height: 16.0),

            // Informasi penulis dan waktu posting
            Text(
              'By ${widget.article.author} \u2022 ${widget.article.postedOn}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16.0),

            // Konten berita
            Text(
              _showFullContent ? widget.article.content : _getTrimmedContent(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),

            // Tombol "Show more"
            if (widget.article.content.length > 100)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showFullContent = !_showFullContent;
                  });
                },
                child: Text(
                  _showFullContent ? 'Show less' : 'Show more',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTrimmedContent() {
    if (widget.article.content.length > 100 && !_showFullContent) {
      return '${widget.article.content.substring(0, 100)}...';
    }
    return widget.article.content;
  }
}
