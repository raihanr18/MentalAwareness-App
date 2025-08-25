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
        title: Text(
          widget.article.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar berita
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.article.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16.0),

            // Judul artikel
            Text(
              widget.article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 12.0),

            // Informasi penulis dan waktu posting
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'By ${widget.article.author}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _formatUserFriendlyDate(widget.article.postedOn),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Konten berita
            _buildMarkdownContent(_showFullContent
                ? widget.article.content
                : _getTrimmedContent()),

            const SizedBox(height: 16.0),

            // Tombol "Show more"
            if (widget.article.content.length > 100)
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showFullContent = !_showFullContent;
                    });
                  },
                  icon: Icon(
                    _showFullContent ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  ),
                  label: Text(
                    _showFullContent
                        ? 'Tampilkan lebih sedikit'
                        : 'Tampilkan lebih banyak',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
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

  Widget _buildMarkdownContent(String content) {
    List<Widget> widgets = [];
    List<String> lines = content.split('\n');

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];

      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Headers dengan **text**
      if (line.startsWith('**') && line.endsWith('**') && line.length > 4) {
        String headerText = line.substring(2, line.length - 2);
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              headerText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        );
      }
      // Numbered lists
      else if (RegExp(r'^\d+\.\s').hasMatch(line)) {
        String listText = line.replaceFirst(RegExp(r'^\d+\.\s'), '');
        // Parse **bold** dalam list item
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                Expanded(
                  child: _buildRichText(listText),
                ),
              ],
            ),
          ),
        );
      }
      // Bullet points dengan -
      else if (line.startsWith('- ')) {
        String listText = line.substring(2);
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                Expanded(
                  child: _buildRichText(listText),
                ),
              ],
            ),
          ),
        );
      }
      // Regular paragraphs
      else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildRichText(line),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildRichText(String text) {
    List<TextSpan> spans = [];
    String remaining = text;

    while (remaining.isNotEmpty) {
      int boldStart = remaining.indexOf('**');

      if (boldStart == -1) {
        // No more bold text, add remaining as normal text
        spans.add(TextSpan(
          text: remaining,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ));
        break;
      }

      // Add text before bold
      if (boldStart > 0) {
        spans.add(TextSpan(
          text: remaining.substring(0, boldStart),
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ));
      }

      // Find closing **
      int boldEnd = remaining.indexOf('**', boldStart + 2);
      if (boldEnd == -1) {
        // No closing **, treat as normal text
        spans.add(TextSpan(
          text: remaining.substring(boldStart),
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ));
        break;
      }

      // Add bold text
      String boldText = remaining.substring(boldStart + 2, boldEnd);
      spans.add(TextSpan(
        text: boldText,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ));

      remaining = remaining.substring(boldEnd + 2);
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  String _formatUserFriendlyDate(String dateString) {
    try {
      // Coba parse sebagai DateTime
      DateTime date;

      // Handle berbagai format tanggal
      if (dateString.contains('T')) {
        // Format ISO: 2024-08-25T10:30:00Z
        date = DateTime.parse(dateString);
      } else if (dateString.contains('-') && dateString.length == 10) {
        // Format: 2024-08-25
        date = DateTime.parse(dateString);
      } else {
        // Jika tidak bisa di-parse, return original
        return dateString;
      }

      final now = DateTime.now();
      final difference = now.difference(date);

      // Format berdasarkan waktu relatif
      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes == 0) {
            return 'Baru saja';
          } else {
            return '${difference.inMinutes} menit yang lalu';
          }
        } else {
          return '${difference.inHours} jam yang lalu';
        }
      } else if (difference.inDays == 1) {
        return 'Kemarin';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} hari yang lalu';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? '1 minggu yang lalu' : '$weeks minggu yang lalu';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1 ? '1 bulan yang lalu' : '$months bulan yang lalu';
      } else {
        // Format tanggal lengkap untuk artikel lama
        final months = [
          'Januari',
          'Februari',
          'Maret',
          'April',
          'Mei',
          'Juni',
          'Juli',
          'Agustus',
          'September',
          'Oktober',
          'November',
          'Desember'
        ];
        return '${date.day} ${months[date.month - 1]} ${date.year}';
      }
    } catch (e) {
      // Jika ada error dalam parsing, return format sederhana
      return dateString.split('T')[0]; // Ambil bagian tanggal saja
    }
  }
}
