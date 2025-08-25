import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/pages/meditation/enhanced_meditation.dart';
import 'package:healman_mental_awareness/pages/news_portal.dart';
import 'package:healman_mental_awareness/pages/view_article.dart';
import 'package:healman_mental_awareness/pages/quiz/improved_quiz_mbti.dart';
import 'package:healman_mental_awareness/pages/user/profile.dart';
import 'package:healman_mental_awareness/pages/mood/mood_tracker.dart';
import 'package:healman_mental_awareness/pages/assessment/mental_health_assessment.dart';
import 'package:healman_mental_awareness/utils/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Configure status bar for home page
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    _loadData();
  }

  void _loadData() async {
    final loginController = context.read<LoginController>();
    loginController.getDataSharedPreferences();
  }

  final List<Widget> _pages = [
    const HomeContent(),
    const EnhancedMeditationPage(),
    const MoodTrackerPage(),
    const MentalHealthAssessmentPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: HealmanColors.growthGreen,
            unselectedItemColor: HealmanColors.softGray,
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.self_improvement),
                label: 'Meditasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mood),
                label: 'Suasana Hati',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.psychology),
                label: 'Penilaian',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: HealmanColors.primaryGradient,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: HealmanColors.ivoryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickActions(context),
                    const SizedBox(height: 24),
                    _buildMentalHealthArticles(context),
                    const SizedBox(height: 24),
                    _buildAssessmentProgress(context),
                    const SizedBox(height: 24),
                    _buildWelcomeSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final loginController = context.watch<LoginController>();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (loginController.name?.isNotEmpty ?? false)
                      ? loginController.name!
                      : 'Pejuang Kesehatan Mental',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: loginController.imageUrl != null
                  ? Image.asset(
                      loginController.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aksi Cepat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: HealmanColors.textCharcoal,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Meditasi',
                'Temukan kedamaian',
                Icons.self_improvement,
                HealmanColors.growthGreen,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnhancedMeditationPage(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Lacak Suasana Hati',
                'Catat mood harian',
                Icons.favorite,
                HealmanColors.hopefulPeach,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MoodTrackerPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Penilaian',
                'Cek kesehatan mental Anda',
                Icons.psychology,
                HealmanColors.serenityBlue,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MentalHealthAssessmentPage(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Kuis MBTI',
                'Temukan kepribadian Anda',
                Icons.quiz,
                HealmanColors.growthGreen,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImprovedQuizMbti(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: HealmanColors.textCharcoal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: HealmanColors.textCharcoal.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentalHealthArticles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Artikel Kesehatan Mental',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsPortal(),
                ),
              ),
              child: const Text('Lihat Semua'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _getMentalHealthArticles().length,
            itemBuilder: (context, index) {
              final article = _getMentalHealthArticles()[index];
              return InkWell(
                onTap: () {
                  // Navigasi ke detail artikel dummy atau NewsPortal
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewArticle(
                        article: Article(
                          title: article['title'],
                          imageUrl:
                              'https://picsum.photos/400/200?random=${index + 1}',
                          author: article['author'] ?? 'Tim Healman',
                          postedOn: _getArticleDate(index),
                          content: article['content'],
                        ),
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.75, // 75% dari lebar layar
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade300,
                              Colors.purple.shade300,
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            article['icon'],
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  article['title'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  article['description'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAssessmentProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progres Penilaian',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildProgressItem('Tes Depresi', 0.7, Colors.blue),
              const SizedBox(height: 16),
              _buildProgressItem('Tes Kecemasan', 0.5, Colors.green),
              const SizedBox(height: 16),
              _buildProgressItem('Tes Stres', 0.3, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressItem(String title, double progress, Color color) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.psychology,
            size: 48,
            color: Color(0xFF667eea),
          ),
          const SizedBox(height: 16),
          const Text(
            'Selamat datang di Mental Awareness',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai perjalanan Anda menuju kesehatan mental yang lebih baik dengan berbagai tools dan fitur yang tersedia.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMentalHealthArticles() {
    return [
      {
        'title': 'Cara Mengatasi Stres dan Kecemasan',
        'description':
            'Tips praktis untuk mengelola stres dalam kehidupan sehari-hari',
        'icon': Icons.psychology,
        'author': 'Dr. Sarah Mental',
        'content':
            'Stres dan kecemasan telah menjadi masalah umum di era digital ini. Dengan teknologi yang terus berkembang dan kehidupan yang semakin cepat, banyak orang merasa kewalahan. Artikel ini membahas berbagai strategi efektif untuk mengelola stres dan kecemasan, termasuk teknik pernapasan, meditasi, dan manajemen waktu yang baik. Teknik pernapasan dalam dapat membantu menenangkan sistem saraf dan mengurangi tingkat stres. Meditasi mindfulness juga terbukti efektif dalam mengurangi kecemasan dan meningkatkan kesejahteraan mental.',
      },
      {
        'title': 'Pentingnya Tidur untuk Kesehatan Mental',
        'description':
            'Bagaimana kualitas tidur mempengaruhi kesehatan mental Anda',
        'icon': Icons.bedtime,
        'author': 'Prof. Ahmad Jiwa',
        'content':
            'Tidur yang berkualitas memiliki peran krusial dalam menjaga kesehatan mental. Kurang tidur dapat mempengaruhi mood, konsentrasi, dan kemampuan berpikir jernih. Artikel ini menjelaskan hubungan antara tidur dan kesehatan mental, serta memberikan tips untuk meningkatkan kualitas tidur Anda. Orang dewasa membutuhkan 7-9 jam tidur per malam untuk kesehatan optimal. Rutinitas tidur yang konsisten, lingkungan tidur yang nyaman, dan menghindari kafein sebelum tidur dapat membantu meningkatkan kualitas tidur.',
      },
      {
        'title': 'Membangun Mindfulness dalam Kehidupan',
        'description': 'Praktik mindfulness untuk meningkatkan kesadaran diri',
        'icon': Icons.self_improvement,
        'author': 'Maya Wellness',
        'content':
            'Mindfulness atau kesadaran penuh adalah praktik yang dapat membantu kita hidup lebih tenang dan bahagia. Dengan berlatih mindfulness, kita dapat mengurangi stres, meningkatkan fokus, dan memiliki hubungan yang lebih baik dengan diri sendiri dan orang lain. Pelajari cara mudah untuk memulai praktik mindfulness dalam rutinitas harian Anda. Mulai dengan latihan pernapasan sederhana selama 5 menit setiap hari, kemudian tingkatkan secara bertahap.',
      },
      {
        'title': 'Mengenali Tanda-tanda Depresi',
        'description': 'Memahami gejala dan cara mencari bantuan profesional',
        'icon': Icons.favorite,
        'author': 'Dr. Rina Psikolog',
        'content':
            'Depresi adalah kondisi mental yang serius namun dapat diobati. Penting untuk mengenali tanda-tanda awal depresi agar dapat segera mencari bantuan. Artikel ini membahas gejala-gejala depresi, faktor risiko, dan berbagai pilihan pengobatan yang tersedia, termasuk terapi dan dukungan sosial. Gejala depresi meliputi perasaan sedih yang berkepanjangan, kehilangan minat pada aktivitas, perubahan nafsu makan, dan kesulitan tidur.',
      },
    ];
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Selamat pagi,';
    if (hour < 17) return 'Selamat siang,';
    return 'Selamat malam,';
  }

  String _getArticleDate(int index) {
    final dates = [
      '2024-01-15T08:30:00Z',
      '2024-01-10T14:20:00Z',
      '2024-01-05T09:15:00Z',
      '2023-12-28T16:45:00Z',
    ];

    if (index < dates.length) {
      return dates[index];
    }

    // Fallback untuk artikel tambahan
    final now = DateTime.now();
    final daysAgo = (index + 1) * 3;
    return now.subtract(Duration(days: daysAgo)).toIso8601String();
  }
}
