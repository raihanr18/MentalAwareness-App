import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/news_portal.dart';
import 'package:translator/translator.dart';
import '../utils/color_palette.dart';

class ViewArticle extends StatefulWidget {
  final Article article;

  const ViewArticle({super.key, required this.article});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  bool _showFullContent = false;
  String? _translatedContent;
  bool _isTranslating = false;

  @override
  void initState() {
    super.initState();
    _translateContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HealmanColors.ivoryWhite,
      appBar: AppBar(
        title: Text(
          widget.article.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: HealmanColors.serenityBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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
                      color: HealmanColors.softGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: HealmanColors.textCharcoal,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20.0),

            // Judul berita
            Text(
              widget.article.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HealmanColors.textCharcoal,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12.0),

            // Metadata artikel
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HealmanColors.serenityBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 16,
                    color: HealmanColors.serenityBlue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'By ${widget.article.author}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: HealmanColors.serenityBlue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: HealmanColors.serenityBlue,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _formatUserFriendlyDate(widget.article.postedOn),
                      style: const TextStyle(
                        fontSize: 14,
                        color: HealmanColors.serenityBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Konten berita
            _isTranslating
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                HealmanColors.serenityBlue),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Menerjemahkan konten...',
                            style: TextStyle(
                              color: HealmanColors.textCharcoal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _buildMarkdownContent(_showFullContent
                    ? (_translatedContent ?? widget.article.content)
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
                    color: HealmanColors.serenityBlue,
                  ),
                  label: Text(
                    _showFullContent
                        ? 'Tampilkan lebih sedikit'
                        : 'Tampilkan lebih banyak',
                    style: const TextStyle(
                      color: HealmanColors.serenityBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        HealmanColors.serenityBlue.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
    String content = _translatedContent ?? widget.article.content;
    if (content.length > 100 && !_showFullContent) {
      return '${content.substring(0, 100)}...';
    }
    return content;
  }

  Future<void> _translateContent() async {
    try {
      setState(() {
        _isTranslating = true;
      });

      String translatedText =
          await _translateToIndonesian(widget.article.content);

      setState(() {
        _translatedContent = translatedText;
        _isTranslating = false;
      });
    } catch (e) {
      setState(() {
        _isTranslating = false;
      });
    }
  }

  Future<String> _translateToIndonesian(String text) async {
    try {
      final translator = GoogleTranslator();

      // Detect bahasa dan terjemahkan jika bukan bahasa Indonesia
      var translation = await translator.translate(text, to: 'id');

      return translation.text;
    } catch (e) {
      // Jika terjemahan gagal, gunakan dictionary fallback
      return _translateWithDictionary(text);
    }
  }

  String _translateWithDictionary(String text) {
    // Dictionary untuk menerjemahkan kata-kata umum
    Map<String, String> translations = {
      // Mental health terms
      'mental health': 'kesehatan mental',
      'Mental Health': 'Kesehatan Mental',
      'MENTAL HEALTH': 'KESEHATAN MENTAL',
      'depression': 'depresi',
      'Depression': 'Depresi',
      'anxiety': 'kecemasan',
      'Anxiety': 'Kecemasan',
      'stress': 'stres',
      'Stress': 'Stres',
      'therapy': 'terapi',
      'Therapy': 'Terapi',
      'treatment': 'pengobatan',
      'Treatment': 'Pengobatan',
      'disorder': 'gangguan',
      'Disorder': 'Gangguan',
      'psychological': 'psikologis',
      'Psychological': 'Psikologis',
      'psychologist': 'psikolog',
      'Psychologist': 'Psikolog',
      'psychiatrist': 'psikiater',
      'Psychiatrist': 'Psikiater',
      'counseling': 'konseling',
      'Counseling': 'Konseling',
      'wellbeing': 'kesejahteraan',
      'Wellbeing': 'Kesejahteraan',
      'wellness': 'kebugaran mental',
      'Wellness': 'Kebugaran Mental',
      'mindfulness': 'kesadaran penuh',
      'Mindfulness': 'Kesadaran Penuh',
      'meditation': 'meditasi',
      'Meditation': 'Meditasi',
      'Afghanistan': 'Afghanistan',
      'accessing': 'mengakses',
      'Accessing': 'Mengakses',
      'difficult': 'sulit',
      'Difficult': 'Sulit',
      'harder': 'lebih sulit',
      'Harder': 'Lebih Sulit',
      'facility': 'fasilitas',
      'Facility': 'Fasilitas',
      'getting out': 'keluar',
      'Getting out': 'Keluar',
      'can be': 'bisa',
      'Can be': 'Bisa',
    };

    String result = text;

    // Terapkan terjemahan kata per kata
    translations.forEach((english, indonesian) {
      result = result.replaceAll(RegExp('\\b$english\\b'), indonesian);
    });

    return result;
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
                color: HealmanColors.textCharcoal,
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
                const Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HealmanColors.serenityBlue,
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
                const Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HealmanColors.serenityBlue,
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
            color: HealmanColors.textCharcoal,
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
            color: HealmanColors.textCharcoal,
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
            color: HealmanColors.textCharcoal,
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
          color: HealmanColors.textCharcoal,
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
