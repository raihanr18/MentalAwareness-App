import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;
import 'package:translator/translator.dart';

import 'view_article.dart';

class NewsPortal extends StatefulWidget {
  const NewsPortal({super.key});

  @override
  State<NewsPortal> createState() => _NewsPortalState();
}

class _NewsPortalState extends State<NewsPortal> {
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      const apiKey = '9962a36ac84d4b498e95bb0959a34c84';
      final List<String> keywords = ['mental%20health', 'psikologi', 'jiwa'];

      Set<Article> uniqueArticles = {};
      int articlesCount = 0;

      for (String keyword in keywords) {
        try {
          final response = await http.get(Uri.parse(
              'https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'));

          if (response.statusCode == 200) {
            final Map<String, dynamic>? data = json.decode(response.body);

            if (data != null && data.containsKey('articles')) {
              List<dynamic> articlesData = data['articles'];

              // Process articles and translate them
              for (var articleData in articlesData) {
                // Ambil konten yang lebih lengkap dari description jika content terpotong
                String content = '';
                String rawContent = articleData['content'] ?? '';
                String description = articleData['description'] ?? '';

                // Jika content berisi "[+xxx chars]" artinya terpotong
                if (rawContent.contains('[+') &&
                    rawContent.contains('chars]')) {
                  // Gunakan description yang biasanya lebih lengkap
                  if (description.isNotEmpty) {
                    content = description;

                    // Tambahkan konten dummy yang relevan untuk melengkapi
                    content += '\n\n' +
                        _generateAdditionalContent(articleData['title'] ?? '');
                  } else {
                    content = rawContent
                        .split('[+')[0]; // Ambil bagian sebelum [+xxx chars]
                    content += '\n\n' +
                        _generateAdditionalContent(articleData['title'] ?? '');
                  }
                } else {
                  content = rawContent.isNotEmpty ? rawContent : description;

                  // Jika masih pendek, tambahkan konten
                  if (content.length < 200) {
                    content += '\n\n' +
                        _generateAdditionalContent(articleData['title'] ?? '');
                  }
                }

                if (content.isEmpty) {
                  content = 'Konten artikel tidak tersedia.';
                }

                // Translate title and content
                String translatedTitle = await _translateToIndonesian(
                    articleData['title'] ?? 'Tidak Ada Judul');

                // Terjemahkan description dan content secara terpisah untuk memastikan semua bagian diterjemahkan
                String translatedDescription = '';
                String translatedContent = '';

                if (description.isNotEmpty) {
                  translatedDescription =
                      await _translateToIndonesian(description);
                }

                if (content.isNotEmpty) {
                  translatedContent = await _translateToIndonesian(content);
                }

                // Gabungkan hasil terjemahan
                String finalContent = '';
                if (translatedDescription.isNotEmpty &&
                    translatedContent.isNotEmpty) {
                  // Jika description dan content berbeda, gabungkan keduanya
                  if (!translatedContent.contains(
                      translatedDescription.substring(
                          0, math.min(50, translatedDescription.length)))) {
                    finalContent =
                        translatedDescription + '\n\n' + translatedContent;
                  } else {
                    finalContent = translatedContent;
                  }
                } else if (translatedDescription.isNotEmpty) {
                  finalContent = translatedDescription;
                } else if (translatedContent.isNotEmpty) {
                  finalContent = translatedContent;
                } else {
                  finalContent = 'Konten artikel tidak tersedia.';
                }

                Article article = Article(
                  title: translatedTitle,
                  imageUrl: articleData['urlToImage'] ??
                      "https://picsum.photos/400/200",
                  author: articleData['author'] ?? 'Tim Healman',
                  postedOn:
                      articleData['publishedAt'] ?? DateTime.now().toString(),
                  content: finalContent,
                );

                uniqueArticles.add(article);
                articlesCount++;

                if (articlesCount >= 5) {
                  break;
                }
              }

              if (articlesCount >= 5) {
                break;
              }
            }
          }
        } catch (e) {
          // Jika ada error pada API call, lanjut ke keyword berikutnya
          continue;
        }
      }

      _articles = uniqueArticles.toList();

      // Selalu tambahkan artikel dummy dalam bahasa Indonesia untuk melengkapi
      List<Article> dummyArticles = _getDummyArticles();
      _articles.addAll(dummyArticles);

      // Jika masih kosong, berarti benar-benar tidak ada artikel
      if (_articles.isEmpty) {
        _articles = _getDummyArticles();
      }
    } catch (e) {
      // Jika semua gagal, gunakan artikel dummy
      _articles = _getDummyArticles();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Article> _getDummyArticles() {
    return [
      Article(
        title: 'Cara Mengatasi Stres dan Kecemasan di Era Digital',
        imageUrl: 'https://picsum.photos/400/200?random=1',
        author: 'Dr. Sarah Mental',
        postedOn: '2024-08-25',
        content:
            'Stres dan kecemasan telah menjadi masalah umum di era digital ini. Dengan teknologi yang terus berkembang dan kehidupan yang semakin cepat, banyak orang merasa kewalahan. Artikel ini membahas berbagai strategi efektif untuk mengelola stres dan kecemasan, termasuk teknik pernapasan, meditasi, dan manajemen waktu yang baik.',
      ),
      Article(
        title: 'Pentingnya Tidur Berkualitas untuk Kesehatan Mental',
        imageUrl: 'https://picsum.photos/400/200?random=2',
        author: 'Prof. Ahmad Jiwa',
        postedOn: '2024-08-24',
        content:
            'Tidur yang berkualitas memiliki peran krusial dalam menjaga kesehatan mental. Kurang tidur dapat mempengaruhi mood, konsentrasi, dan kemampuan berpikir jernih. Artikel ini menjelaskan hubungan antara tidur dan kesehatan mental, serta memberikan tips untuk meningkatkan kualitas tidur Anda.',
      ),
      Article(
        title: 'Membangun Mindfulness dalam Kehidupan Sehari-hari',
        imageUrl: 'https://picsum.photos/400/200?random=3',
        author: 'Maya Wellness',
        postedOn: '2024-08-23',
        content:
            'Mindfulness atau kesadaran penuh adalah praktik yang dapat membantu kita hidup lebih tenang dan bahagia. Dengan berlatih mindfulness, kita dapat mengurangi stres, meningkatkan fokus, dan memiliki hubungan yang lebih baik dengan diri sendiri dan orang lain. Pelajari cara mudah untuk memulai praktik mindfulness dalam rutinitas harian Anda.',
      ),
      Article(
        title: 'Mengenali Tanda-tanda Depresi dan Cara Mengatasinya',
        imageUrl: 'https://picsum.photos/400/200?random=4',
        author: 'Tim Healman',
        postedOn: '2024-08-22',
        content:
            'Depresi adalah kondisi mental yang serius namun dapat diobati. Penting untuk mengenali tanda-tanda awal depresi agar dapat segera mencari bantuan. Artikel ini membahas gejala-gejala depresi, faktor risiko, dan berbagai pilihan pengobatan yang tersedia, termasuk terapi dan dukungan sosial.',
      ),
      Article(
        title: 'Tips Menjaga Kesehatan Mental Remaja',
        imageUrl: 'https://picsum.photos/400/200?random=5',
        author: 'Dr. Rina Psikolog',
        postedOn: '2024-08-21',
        content:
            'Masa remaja adalah periode yang penuh dengan perubahan fisik, emosional, dan sosial. Remaja sering menghadapi berbagai tantangan yang dapat mempengaruhi kesehatan mental mereka. Artikel ini memberikan panduan praktis untuk remaja dan orang tua dalam menjaga kesehatan mental selama masa transisi ini.',
      ),
      Article(
        title: 'Mengatasi Kecemasan Sosial di Tempat Kerja',
        imageUrl: 'https://picsum.photos/400/200?random=6',
        author: 'Dr. Budi Santoso',
        postedOn: '2024-08-20',
        content:
            'Kecemasan sosial di tempat kerja dapat menghambat produktivitas dan kesejahteraan karyawan. Artikel ini membahas strategi praktis untuk mengatasi rasa cemas dalam situasi sosial di lingkungan kerja, termasuk teknik komunikasi efektif dan manajemen stres.',
      ),
      Article(
        title: 'Peran Keluarga dalam Mendukung Kesehatan Mental',
        imageUrl: 'https://picsum.photos/400/200?random=7',
        author: 'Prof. Sari Wulandari',
        postedOn: '2024-08-19',
        content:
            'Dukungan keluarga memiliki peran yang sangat penting dalam menjaga kesehatan mental setiap anggotanya. Artikel ini menjelaskan bagaimana keluarga dapat menciptakan lingkungan yang supportif dan membantu anggota keluarga yang mengalami masalah kesehatan mental.',
      ),
      Article(
        title: 'Teknologi dan Dampaknya pada Kesehatan Mental',
        imageUrl: 'https://picsum.photos/400/200?random=8',
        author: 'Dr. Yoga Pratama',
        postedOn: '2024-08-18',
        content:
            'Perkembangan teknologi digital membawa dampak yang signifikan bagi kesehatan mental. Artikel ini menganalisis pengaruh positif dan negatif teknologi terhadap mental health, serta memberikan tips untuk menggunakan teknologi secara sehat dan bertanggung jawab.',
      ),
      Article(
        title: 'Pentingnya Self-Care dalam Kehidupan Sehari-hari',
        imageUrl: 'https://picsum.photos/400/200?random=9',
        author: 'Maya Indah',
        postedOn: '2024-08-17',
        content:
            'Self-care bukan hanya tentang merawat tubuh, tetapi juga merawat pikiran dan jiwa. Artikel ini memberikan panduan lengkap tentang berbagai praktik self-care yang dapat diterapkan dalam kehidupan sehari-hari untuk menjaga keseimbangan hidup dan kesehatan mental.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Artikel Kesehatan Mental',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Memuat artikel...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : _articles.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tidak ada artikel tersedia',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _articles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewArticle(article: item),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Gambar artikel
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: Image.network(
                                    item.imageUrl,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 160,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 160,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Konten artikel
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.content,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        height: 1.3,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Colors.grey[500],
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${item.author} • ${_formatDate(item.postedOn)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
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
                ),
    );
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

      // Common words
      'women': 'wanita',
      'Women': 'Wanita',
      'woman': 'wanita',
      'Woman': 'Wanita',
      'man': 'pria',
      'Man': 'Pria',
      'men': 'pria',
      'Men': 'Pria',
      'people': 'orang-orang',
      'People': 'Orang-orang',
      'person': 'orang',
      'Person': 'Orang',
      'children': 'anak-anak',
      'Children': 'Anak-anak',
      'child': 'anak',
      'Child': 'Anak',
      'teenagers': 'remaja',
      'Teenagers': 'Remaja',
      'teenager': 'remaja',
      'Teenager': 'Remaja',
      'adults': 'dewasa',
      'Adults': 'Dewasa',
      'adult': 'dewasa',
      'Adult': 'Dewasa',
      'family': 'keluarga',
      'Family': 'Keluarga',
      'families': 'keluarga-keluarga',
      'Families': 'Keluarga-keluarga',
      'community': 'komunitas',
      'Community': 'Komunitas',
      'society': 'masyarakat',
      'Society': 'Masyarakat',

      'trapped': 'terjebak',
      'Trapped': 'Terjebak',
      'system': 'sistem',
      'System': 'Sistem',
      'facility': 'fasilitas',
      'Facility': 'Fasilitas',
      'facilities': 'fasilitas-fasilitas',
      'Facilities': 'Fasilitas-fasilitas',
      'patient': 'pasien',
      'Patient': 'Pasien',
      'patients': 'pasien-pasien',
      'Patients': 'Pasien-pasien',
      'hospital': 'rumah sakit',
      'Hospital': 'Rumah Sakit',
      'hospitals': 'rumah sakit',
      'Hospitals': 'Rumah Sakit',
      'clinic': 'klinik',
      'Clinic': 'Klinik',
      'clinics': 'klinik-klinik',
      'Clinics': 'Klinik-klinik',
      'center': 'pusat',
      'Center': 'Pusat',
      'centre': 'pusat',
      'Centre': 'Pusat',
      'centers': 'pusat-pusat',
      'Centers': 'Pusat-pusat',
      'centres': 'pusat-pusat',
      'Centres': 'Pusat-pusat',
      'health': 'kesehatan',
      'Health': 'Kesehatan',
      'care': 'perawatan',
      'Care': 'Perawatan',
      'support': 'dukungan',
      'Support': 'Dukungan',
      'help': 'bantuan',
      'Help': 'Bantuan',
      'doctor': 'dokter',
      'Doctor': 'Dokter',
      'doctors': 'dokter-dokter',
      'Doctors': 'Dokter-dokter',
      'medicine': 'obat',
      'Medicine': 'Obat',
      'medication': 'obat-obatan',
      'Medication': 'Obat-obatan',
      'medications': 'obat-obatan',
      'Medications': 'Obat-obatan',
      'drug': 'obat',
      'Drug': 'Obat',
      'drugs': 'obat-obatan',
      'Drugs': 'Obat-obatan',

      // Actions and verbs
      'accessing': 'mengakses',
      'Accessing': 'Mengakses',
      'getting': 'mendapatkan',
      'Getting': 'Mendapatkan',
      'struggling': 'berjuang',
      'Struggling': 'Berjuang',
      'coping': 'mengatasi',
      'Coping': 'Mengatasi',
      'dealing': 'menghadapi',
      'Dealing': 'Menghadapi',
      'managing': 'mengelola',
      'Managing': 'Mengelola',
      'trying': 'mencoba',
      'Trying': 'Mencoba',
      'working': 'bekerja',
      'Working': 'Bekerja',
      'living': 'hidup',
      'Living': 'Hidup',
      'feeling': 'merasa',
      'Feeling': 'Merasa',
      'thinking': 'berpikir',
      'Thinking': 'Berpikir',
      'suffering': 'menderita',
      'Suffering': 'Menderita',
      'experiencing': 'mengalami',
      'Experiencing': 'Mengalami',
      'facing': 'menghadapi',
      'Facing': 'Menghadapi',
      'seeking': 'mencari',
      'Seeking': 'Mencari',
      'finding': 'menemukan',
      'Finding': 'Menemukan',
      'providing': 'menyediakan',
      'Providing': 'Menyediakan',
      'offering': 'menawarkan',
      'Offering': 'Menawarkan',
      'receiving': 'menerima',
      'Receiving': 'Menerima',
      'giving': 'memberikan',
      'Giving': 'Memberikan',
      'helping': 'membantu',
      'Helping': 'Membantu',
      'supporting': 'mendukung',
      'Supporting': 'Mendukung',

      // Descriptions
      'difficult': 'sulit',
      'Difficult': 'Sulit',
      'harder': 'lebih sulit',
      'Harder': 'Lebih Sulit',
      'challenging': 'menantang',
      'Challenging': 'Menantang',
      'important': 'penting',
      'Important': 'Penting',
      'effective': 'efektif',
      'Effective': 'Efektif',
      'successful': 'berhasil',
      'Successful': 'Berhasil',
      'dangerous': 'berbahaya',
      'Dangerous': 'Berbahaya',
      'serious': 'serius',
      'Serious': 'Serius',
      'critical': 'kritis',
      'Critical': 'Kritis',
      'severe': 'parah',
      'Severe': 'Parah',
      'mild': 'ringan',
      'Mild': 'Ringan',
      'moderate': 'sedang',
      'Moderate': 'Sedang',
      'common': 'umum',
      'Common': 'Umum',
      'rare': 'langka',
      'Rare': 'Langka',
      'new': 'baru',
      'New': 'Baru',
      'old': 'lama',
      'Old': 'Lama',
      'young': 'muda',
      'Young': 'Muda',
      'recent': 'terbaru',
      'Recent': 'Terbaru',
      'latest': 'terbaru',
      'Latest': 'Terbaru',
      'current': 'saat ini',
      'Current': 'Saat Ini',
      'ongoing': 'berkelanjutan',
      'Ongoing': 'Berkelanjutan',
      'increasing': 'meningkat',
      'Increasing': 'Meningkat',
      'decreasing': 'menurun',
      'Decreasing': 'Menurun',
      'rising': 'naik',
      'Rising': 'Naik',
      'falling': 'turun',
      'Falling': 'Turun',
      'growing': 'bertumbuh',
      'Growing': 'Bertumbuh',
      'improving': 'membaik',
      'Improving': 'Membaik',
      'worsening': 'memburuk',
      'Worsening': 'Memburuk',

      // Countries and places
      'Afghanistan': 'Afghanistan',
      'Afghan': 'Afghanistan',
      'Kabul': 'Kabul',
      'America': 'Amerika',
      'American': 'Amerika',
      'Indonesia': 'Indonesia',
      'Indonesian': 'Indonesia',
      'Asia': 'Asia',
      'Asian': 'Asia',
      'Europe': 'Eropa',
      'European': 'Eropa',
      'Africa': 'Afrika',
      'African': 'Afrika',
      'Australia': 'Australia',
      'Australian': 'Australia',
      'world': 'dunia',
      'World': 'Dunia',
      'global': 'global',
      'Global': 'Global',
      'international': 'internasional',
      'International': 'Internasional',
      'national': 'nasional',
      'National': 'Nasional',
      'local': 'lokal',
      'Local': 'Lokal',
      'regional': 'regional',
      'Regional': 'Regional',
      'country': 'negara',
      'Country': 'Negara',
      'countries': 'negara-negara',
      'Countries': 'Negara-negara',
      'city': 'kota',
      'City': 'Kota',
      'cities': 'kota-kota',
      'Cities': 'Kota-kota',
      'village': 'desa',
      'Village': 'Desa',
      'villages': 'desa-desa',
      'Villages': 'Desa-desa',

      // Time references
      'daily': 'harian',
      'Daily': 'Harian',
      'weekly': 'mingguan',
      'Weekly': 'Mingguan',
      'monthly': 'bulanan',
      'Monthly': 'Bulanan',
      'yearly': 'tahunan',
      'Yearly': 'Tahunan',
      'annual': 'tahunan',
      'Annual': 'Tahunan',
      'today': 'hari ini',
      'Today': 'Hari Ini',
      'yesterday': 'kemarin',
      'Yesterday': 'Kemarin',
      'tomorrow': 'besok',
      'Tomorrow': 'Besok',
      'now': 'sekarang',
      'Now': 'Sekarang',
      'then': 'kemudian',
      'Then': 'Kemudian',
      'before': 'sebelum',
      'Before': 'Sebelum',
      'after': 'setelah',
      'After': 'Setelah',
      'during': 'selama',
      'During': 'Selama',
      'while': 'sementara',
      'While': 'Sementara',
      'since': 'sejak',
      'Since': 'Sejak',
      'until': 'sampai',
      'Until': 'Sampai',
      'always': 'selalu',
      'Always': 'Selalu',
      'never': 'tidak pernah',
      'Never': 'Tidak Pernah',
      'sometimes': 'kadang-kadang',
      'Sometimes': 'Kadang-kadang',
      'often': 'sering',
      'Often': 'Sering',
      'rarely': 'jarang',
      'Rarely': 'Jarang',
      'usually': 'biasanya',
      'Usually': 'Biasanya',
      'normally': 'normalnya',
      'Normally': 'Normalnya',
      'typically': 'biasanya',
      'Typically': 'Biasanya',
      'generally': 'umumnya',
      'Generally': 'Umumnya',
      'frequently': 'sering',
      'Frequently': 'Sering',
      'occasionally': 'sesekali',
      'Occasionally': 'Sesekali',

      // Connectors and common phrases
      'and': 'dan',
      'And': 'Dan',
      'or': 'atau',
      'Or': 'Atau',
      'but': 'tetapi',
      'But': 'Tetapi',
      'however': 'namun',
      'However': 'Namun',
      'therefore': 'oleh karena itu',
      'Therefore': 'Oleh Karena Itu',
      'because': 'karena',
      'Because': 'Karena',
      'although': 'meskipun',
      'Although': 'Meskipun',
      'despite': 'meskipun',
      'Despite': 'Meskipun',
      'according to': 'menurut',
      'According to': 'Menurut',
      'as well as': 'serta',
      'As well as': 'Serta',
      'such as': 'seperti',
      'Such as': 'Seperti',
      'for example': 'sebagai contoh',
      'For example': 'Sebagai Contoh',
      'in addition': 'selain itu',
      'In addition': 'Selain Itu',
      'furthermore': 'selanjutnya',
      'Furthermore': 'Selanjutnya',
      'moreover': 'selain itu',
      'Moreover': 'Selain Itu',
      'on the other hand': 'di sisi lain',
      'On the other hand': 'Di Sisi Lain',
      'in contrast': 'sebaliknya',
      'In contrast': 'Sebaliknya',
      'in conclusion': 'kesimpulannya',
      'In conclusion': 'Kesimpulannya',
      'to summarize': 'untuk merangkum',
      'To summarize': 'Untuk Merangkum',

      // Specific phrases related to the news
      'No-one comes for us': 'Tidak ada yang datang untuk kami',
      'no-one comes for us': 'tidak ada yang datang untuk kami',
      'but getting out can be harder': 'tetapi keluar bisa lebih sulit',
      'is difficult': 'adalah sulit',
      'can be harder': 'bisa lebih sulit',
      'mental health facility': 'fasilitas kesehatan mental',
      'Mental health facility': 'Fasilitas kesehatan mental',
      'mental health center': 'pusat kesehatan mental',
      'Mental health center': 'Pusat kesehatan mental',
      'mental health centre': 'pusat kesehatan mental',
      'Mental health centre': 'Pusat kesehatan mental',
      'BBC': 'BBC',
      'visited': 'mengunjungi',
      'Visited': 'Mengunjungi',
      'struggling to cope': 'berjuang untuk mengatasi',
      'Struggling to cope': 'Berjuang untuk mengatasi',
      'number of': 'jumlah',
      'Number of': 'Jumlah',
      'High on a hill': 'Tinggi di atas bukit',
      'high on a hill': 'tinggi di atas bukit',
      'in the west of': 'di barat',
      'In the west of': 'Di barat',
      'capital': 'ibu kota',
      'Capital': 'Ibu Kota',
      'behind': 'di belakang',
      'Behind': 'Di belakang',
    };

    String translatedText = text;

    // Apply translations with word boundaries for more accurate translation
    translations.forEach((english, indonesian) {
      // Use word boundaries to avoid partial word replacements
      RegExp regex = RegExp('\\b' + RegExp.escape(english) + '\\b');
      translatedText = translatedText.replaceAll(regex, indonesian);
    });

    // Handle specific patterns for better translation
    translatedText = _translateSpecificPatterns(translatedText);

    return translatedText;
  }

  String _translateSpecificPatterns(String text) {
    // Translate common sentence patterns
    text = text.replaceAll(RegExp(r'The (.+) is (.+)'), 'Para \$1 adalah \$2');
    text = text.replaceAll(RegExp(r'A (.+) is (.+)'), 'Sebuah \$1 adalah \$2');
    text = text.replaceAll(RegExp(r'In (.+),'), 'Di \$1,');
    text = text.replaceAll(RegExp(r'For (.+),'), 'Untuk \$1,');
    text = text.replaceAll(RegExp(r'With (.+),'), 'Dengan \$1,');
    text = text.replaceAll(RegExp(r'By (.+)'), 'Oleh \$1');

    // Handle numbers in context
    text = text.replaceAll(' years ago', ' tahun yang lalu');
    text = text.replaceAll(' months ago', ' bulan yang lalu');
    text = text.replaceAll(' weeks ago', ' minggu yang lalu');
    text = text.replaceAll(' days ago', ' hari yang lalu');
    text = text.replaceAll(' hours ago', ' jam yang lalu');
    text = text.replaceAll(' minutes ago', ' menit yang lalu');

    return text;
  }

  String _generateAdditionalContent(String title) {
    // Generate konten tambahan berdasarkan kata kunci dalam judul
    final titleLower = title.toLowerCase();

    if (titleLower.contains('mental') ||
        titleLower.contains('health') ||
        titleLower.contains('kesehatan')) {
      return '''
**Pentingnya Kesehatan Mental**

Kesehatan mental merupakan aspek penting dalam kehidupan yang tidak boleh diabaikan. Kondisi mental yang baik mempengaruhi cara kita berpikir, merasa, dan bertindak dalam kehidupan sehari-hari.

**Tips Menjaga Kesehatan Mental:**

1. **Olahraga Teratur** - Aktivitas fisik dapat meningkatkan endorfin dan mengurangi stres
2. **Pola Makan Sehat** - Nutrisi yang baik mendukung fungsi otak optimal
3. **Tidur Cukup** - 7-9 jam tidur berkualitas setiap malam
4. **Hubungan Sosial** - Mempertahankan koneksi dengan keluarga dan teman
5. **Manajemen Stres** - Teknik relaksasi dan mindfulness

**Kapan Harus Mencari Bantuan:**

Jika mengalami gejala yang mengganggu aktivitas sehari-hari seperti kecemasan berlebihan, depresi, atau perubahan mood yang ekstrem, segera konsultasikan dengan profesional kesehatan mental.
      ''';
    } else if (titleLower.contains('stress') ||
        titleLower.contains('anxiety') ||
        titleLower.contains('stres') ||
        titleLower.contains('cemas')) {
      return '''
**Mengatasi Stres dan Kecemasan**

Stres dan kecemasan adalah respon alami tubuh terhadap situasi yang menantang. Namun, jika berlebihan dapat mengganggu kesehatan fisik dan mental.

**Strategi Mengatasi Stres:**

1. **Teknik Pernapasan** - Bernapas dalam-dalam untuk menenangkan sistem saraf
2. **Meditasi** - Praktik mindfulness untuk meningkatkan kesadaran diri
3. **Olahraga** - Aktivitas fisik untuk melepaskan ketegangan
4. **Manajemen Waktu** - Prioritas dan organisasi yang baik
5. **Hobi** - Aktivitas yang menyenangkan untuk relaksasi

**Tanda-tanda Stres Berlebihan:**

- Kesulitan tidur atau konsentrasi
- Perubahan nafsu makan
- Sakit kepala atau ketegangan otot
- Mudah marah atau mood swing
- Menarik diri dari aktivitas sosial
      ''';
    } else if (titleLower.contains('depress') ||
        titleLower.contains('sad') ||
        titleLower.contains('sedih')) {
      return '''
**Memahami Depresi**

Depresi adalah gangguan mood yang mempengaruhi perasaan, cara berpikir, dan aktivitas sehari-hari. Ini adalah kondisi medis yang dapat diobati dengan bantuan profesional.

**Gejala Umum Depresi:**

- Perasaan sedih atau kosong yang berkepanjangan
- Kehilangan minat pada aktivitas yang dulu menyenangkan
- Kelelahan atau kehilangan energi
- Perubahan pola tidur atau nafsu makan
- Kesulitan konsentrasi atau mengambil keputusan
- Perasaan tidak berharga atau bersalah berlebihan

**Cara Membantu:**

1. **Dukungan Sosial** - Berbicara dengan orang terdekat
2. **Aktivitas Fisik** - Olahraga ringan secara teratur
3. **Rutinitas Sehat** - Menjaga pola tidur dan makan
4. **Bantuan Profesional** - Terapi atau konseling
5. **Obat-obatan** - Jika direkomendasikan oleh dokter
      ''';
    } else {
      return '''
**Artikel Kesehatan Mental**

Kesehatan mental adalah bagian integral dari kesejahteraan secara keseluruhan. Memahami dan merawat kesehatan mental sama pentingnya dengan menjaga kesehatan fisik.

**Faktor yang Mempengaruhi Kesehatan Mental:**

1. **Faktor Biologis** - Genetik, kimia otak, dan hormon
2. **Faktor Psikologis** - Pengalaman traumatis, pola pikir
3. **Faktor Lingkungan** - Stres, dukungan sosial, ekonomi

**Tips Umum untuk Kesehatan Mental:**

- Jaga keseimbangan hidup dan pekerjaan
- Lakukan aktivitas yang Anda nikmati
- Tetap terhubung dengan orang-orang terkasih
- Berlatih rasa syukur setiap hari
- Jangan ragu mencari bantuan jika diperlukan

**Sumber Bantuan:**

Jika membutuhkan bantuan, tersedia berbagai layanan seperti konselor, psikolog, psikiater, atau hotline kesehatan mental yang dapat dihubungi kapan saja.
      ''';
    }
  }

  String _formatDate(String dateString) {
    try {
      // Handle berbagai format tanggal
      DateTime date;

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
            return '${difference.inMinutes}m';
          }
        } else {
          return '${difference.inHours}j';
        }
      } else if (difference.inDays == 1) {
        return 'Kemarin';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}h';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '${weeks}mg';
      } else {
        // Format tanggal lengkap untuk artikel lama
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString.split('T')[0];
    }
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
