import 'package:flutter/material.dart';

class ImprovedResultPage extends StatefulWidget {
  final Map<String, dynamic> results;
  final List<Map<String, dynamic>> userAnswers;

  const ImprovedResultPage({
    super.key,
    required this.results,
    required this.userAnswers,
  });

  @override
  State<ImprovedResultPage> createState() => _ImprovedResultPageState();
}

class _ImprovedResultPageState extends State<ImprovedResultPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personalityType = widget.results['personalityType'] as String?;
    final dimensions =
        widget.results['dimensions'] as Map<String, dynamic>? ?? {};
    final confidenceLevel =
        (widget.results['confidenceLevel'] as double?) ?? 0.0;
    final consistencyScore =
        (widget.results['consistencyScore'] as double?) ?? 0.0;
    final cognitiveFunctions =
        widget.results['cognitiveFunctions'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: _getPersonalityColor(personalityType),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Hasil Tes MBTI',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _getPersonalityColor(personalityType),
                            _getPersonalityColor(personalityType)
                                .withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getPersonalityIcon(personalityType),
                          size: 60,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),

                // Content
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Personality Type Card
                      _buildPersonalityTypeCard(personalityType),
                      const SizedBox(height: 20),

                      // Confidence & Consistency
                      _buildStatsRow(confidenceLevel, consistencyScore),
                      const SizedBox(height: 20),

                      // Dimensions Analysis
                      _buildDimensionsCard(dimensions),
                      const SizedBox(height: 20),

                      // MBTI Dimensions Explanation
                      _buildMBTIExplanationCard(),
                      const SizedBox(height: 20),

                      // Cognitive Functions
                      _buildCognitiveFunctionsCard(cognitiveFunctions),
                      const SizedBox(height: 20),

                      // Personality Description
                      _buildDescriptionCard(personalityType),
                      const SizedBox(height: 20),

                      // Development Suggestions
                      _buildDevelopmentCard(personalityType),
                      const SizedBox(height: 20),

                      // Action Buttons
                      _buildActionButtons(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalityTypeCard(String? personalityType) {
    final safePersonalityType = personalityType ?? 'UNKNOWN';
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getPersonalityColor(personalityType),
            _getPersonalityColor(personalityType).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getPersonalityColor(personalityType).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getPersonalityIcon(personalityType),
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            safePersonalityType,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getPersonalityTitle(personalityType),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(double confidenceLevel, double consistencyScore) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Tingkat Keyakinan',
            confidenceLevel,
            Icons.verified,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Konsistensi Jawaban',
            consistencyScore,
            Icons.balance,
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, double value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${(value * 100).toInt()}%',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsCard(Map<String, dynamic> dimensions) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics,
                  color: Colors.purple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Analisis Dimensi Kepribadian',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...dimensions.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildDimensionBar(entry.key, entry.value),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDimensionBar(String dimension, Map<String, dynamic> data) {
    final percentage = data['percentage'];
    final dominantType = data['dominantType'];
    final strength = data['strength'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with dimension name
        Text(
          _getDimensionShortName(dimension),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),

        // Type and strength info
        Row(
          children: [
            Expanded(
              child: Text(
                strength,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: _getDimensionColor(dominantType).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                dominantType,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _getDimensionColor(dominantType),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth * (percentage / 100),
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getDimensionColor(dominantType),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        // Percentage
        Text(
          '${percentage.toInt()}%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getDimensionColor(dominantType),
          ),
        ),
      ],
    );
  }

  Widget _buildCognitiveFunctionsCard(Map<String, dynamic> cognitiveFunctions) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Fungsi Kognitif',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCognitiveFunctionItem(
              'Dominan', cognitiveFunctions['dominant'], Colors.red),
          _buildCognitiveFunctionItem(
              'Auxiliary', cognitiveFunctions['auxiliary'], Colors.orange),
          _buildCognitiveFunctionItem(
              'Tertiary', cognitiveFunctions['tertiary'], Colors.blue),
          _buildCognitiveFunctionItem(
              'Inferior', cognitiveFunctions['inferior'], Colors.purple),
        ],
      ),
    );
  }

  Widget _buildMBTIExplanationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.indigo,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Penjelasan Dimensi MBTI',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMBTIExplanationItem(
            'E vs I',
            'Extraversion vs Introversion',
            'E (Extraversion): Energi diperoleh dari dunia luar, senang berinteraksi dengan banyak orang, berpikir sambil berbicara.\n\nI (Introversion): Energi diperoleh dari dunia dalam, lebih suka interaksi yang mendalam, berpikir sebelum berbicara.',
            Icons.people,
            Colors.red,
          ),
          _buildMBTIExplanationItem(
            'S vs N',
            'Sensing vs Intuition',
            'S (Sensing): Fokus pada detail, fakta, dan realitas saat ini. Lebih suka informasi yang konkret dan praktis.\n\nN (Intuition): Fokus pada kemungkinan, pola, dan gambaran besar. Lebih suka ide-ide abstrak dan inovasi.',
            Icons.visibility,
            Colors.green,
          ),
          _buildMBTIExplanationItem(
            'T vs F',
            'Thinking vs Feeling',
            'T (Thinking): Mengutamakan logika dan objektivitas dalam pengambilan keputusan. Fokus pada analisis dan konsistensi.\n\nF (Feeling): Mengutamakan nilai-nilai dan dampak terhadap orang lain. Fokus pada harmoni dan empati.',
            Icons.balance,
            Colors.orange,
          ),
          _buildMBTIExplanationItem(
            'J vs P',
            'Judging vs Perceiving',
            'J (Judging): Suka struktur, perencanaan, dan closure. Lebih nyaman dengan keputusan yang sudah dibuat.\n\nP (Perceiving): Suka fleksibilitas, spontanitas, dan opsi terbuka. Lebih nyaman dengan adaptasi dan perubahan.',
            Icons.schedule,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildMBTIExplanationItem(String dimension, String fullName,
      String explanation, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dimension,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            explanation,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCognitiveFunctionItem(
      String level, String function, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text(
              level,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              function,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(String? personalityType) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.description,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Deskripsi Kepribadian',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getPersonalityDescription(personalityType),
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevelopmentCard(String? personalityType) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.cyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Saran Pengembangan Diri',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._getDevelopmentSuggestions(personalityType)
              .map((suggestion) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            suggestion,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: Colors.blue.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              // TODO: Share results functionality
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade600,
              side: BorderSide(color: Colors.blue.shade600, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.share, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Bagikan Hasil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getPersonalityColor(String? type) {
    if (type == null) return Colors.grey;

    // Analyst types (NT)
    if (['INTJ', 'INTP', 'ENTJ', 'ENTP'].contains(type)) {
      return Colors.purple;
    }
    // Diplomat types (NF)
    if (['INFJ', 'INFP', 'ENFJ', 'ENFP'].contains(type)) {
      return Colors.green;
    }
    // Sentinel types (SJ)
    if (['ISTJ', 'ISFJ', 'ESTJ', 'ESFJ'].contains(type)) {
      return Colors.blue;
    }
    // Explorer types (SP)
    if (['ISTP', 'ISFP', 'ESTP', 'ESFP'].contains(type)) {
      return Colors.orange;
    }
    return Colors.grey;
  }

  IconData _getPersonalityIcon(String? type) {
    if (type == null) return Icons.person;

    // Analyst types (NT)
    if (['INTJ', 'INTP', 'ENTJ', 'ENTP'].contains(type)) {
      return Icons.psychology;
    }
    // Diplomat types (NF)
    if (['INFJ', 'INFP', 'ENFJ', 'ENFP'].contains(type)) {
      return Icons.favorite;
    }
    // Sentinel types (SJ)
    if (['ISTJ', 'ISFJ', 'ESTJ', 'ESFJ'].contains(type)) {
      return Icons.security;
    }
    // Explorer types (SP)
    if (['ISTP', 'ISFP', 'ESTP', 'ESFP'].contains(type)) {
      return Icons.explore;
    }
    return Icons.person;
  }

  String _getPersonalityTitle(String? type) {
    if (type == null) return 'Kepribadian Unik';

    final titles = {
      'INTJ': 'The Architect',
      'INTP': 'The Thinker',
      'ENTJ': 'The Commander',
      'ENTP': 'The Debater',
      'INFJ': 'The Advocate',
      'INFP': 'The Mediator',
      'ENFJ': 'The Protagonist',
      'ENFP': 'The Campaigner',
      'ISTJ': 'The Logistician',
      'ISFJ': 'The Protector',
      'ESTJ': 'The Executive',
      'ESFJ': 'The Consul',
      'ISTP': 'The Virtuoso',
      'ISFP': 'The Adventurer',
      'ESTP': 'The Entrepreneur',
      'ESFP': 'The Entertainer',
    };
    return titles[type] ?? 'Kepribadian Unik';
  }

  String _getDimensionShortName(String dimension) {
    switch (dimension) {
      case 'EI':
        return 'E vs I';
      case 'SN':
        return 'S vs N';
      case 'TF':
        return 'T vs F';
      case 'JP':
        return 'J vs P';
      default:
        return dimension;
    }
  }

  Color _getDimensionColor(String type) {
    switch (type) {
      case 'E':
        return Colors.red;
      case 'I':
        return Colors.blue;
      case 'S':
        return Colors.green;
      case 'N':
        return Colors.purple;
      case 'T':
        return Colors.orange;
      case 'F':
        return Colors.pink;
      case 'J':
        return Colors.indigo;
      case 'P':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _getPersonalityDescription(String? type) {
    if (type == null)
      return 'Kepribadian yang unik dengan karakteristik khusus.';

    final descriptions = {
      'INTJ':
          'Arsitek yang visioner, strategis, dan independen. Memiliki kemampuan untuk melihat gambaran besar dan mengembangkan sistem yang efisien.',
      'INTP':
          'Pemikir yang analitis, objektif, dan inovatif. Senang mengeksplorasi ide-ide kompleks dan memahami bagaimana segala sesuatu bekerja.',
      'ENTJ':
          'Pemimpin alami yang percaya diri, tegas, dan berorientasi pada tujuan. Mahir dalam mengorganisir dan memotivasi orang lain.',
      'ENTP':
          'Inovator yang kreatif, adaptif, dan penuh energi. Senang mengeksplorasi kemungkinan baru dan memecahkan masalah dengan cara unik.',
      'INFJ':
          'Advokat yang idealis, berempati, dan visioner. Memiliki kemampuan untuk memahami orang lain secara mendalam dan menginspirasi perubahan positif.',
      'INFP':
          'Mediator yang kreatif, fleksibel, dan berprinsip. Didorong oleh nilai-nilai personal dan keinginan untuk membuat dunia menjadi tempat yang lebih baik.',
      'ENFJ':
          'Protagonis yang karismatik, berempati, dan inspiratif. Mahir dalam memotivasi dan mengembangkan potensi orang lain.',
      'ENFP':
          'Campaigner yang antusias, kreatif, dan spontan. Senang menjalin hubungan dengan orang lain dan mengeksplorasi kemungkinan baru.',
      'ISTJ':
          'Logistician yang praktis, bertanggung jawab, dan dapat diandalkan. Menghargai tradisi dan bekerja dengan sistematis untuk mencapai tujuan.',
      'ISFJ':
          'Protector yang hangat, perhatian, dan loyal. Senang membantu orang lain dan menciptakan lingkungan yang harmonis.',
      'ESTJ':
          'Executive yang terorganisir, praktis, dan tegas. Mahir dalam mengelola proyek dan memastikan hal-hal berjalan dengan efisien.',
      'ESFJ':
          'Consul yang ramah, kooperatif, dan perhatian. Senang membantu orang lain dan menciptakan keharmonian dalam grup.',
      'ISTP':
          'Virtuoso yang praktis, adaptif, dan berorientasi pada tindakan. Senang memecahkan masalah dengan pendekatan hands-on.',
      'ISFP':
          'Adventurer yang sensitif, fleksibel, dan kreatif. Didorong oleh nilai-nilai personal dan senang mengekspresikan diri secara artistik.',
      'ESTP':
          'Entrepreneur yang energik, pragmatis, dan spontan. Senang mengambil risiko dan beradaptasi dengan situasi yang berubah.',
      'ESFP':
          'Entertainer yang antusias, ramah, dan spontan. Senang berinteraksi dengan orang lain dan menciptakan pengalaman yang menyenangkan.',
    };
    return descriptions[type] ??
        'Kepribadian yang unik dengan karakteristik khusus.';
  }

  List<String> _getDevelopmentSuggestions(String? type) {
    if (type == null) {
      return [
        'Terus kembangkan kekuatan alami Anda',
        'Pelajari untuk menggunakan fungsi kognitif yang kurang dominan',
        'Cari feedback dari orang lain untuk pertumbuhan pribadi',
        'Tetap terbuka terhadap pengalaman dan perspektif baru'
      ];
    }

    final suggestions = {
      'INTJ': [
        'Kembangkan keterampilan komunikasi interpersonal untuk menyampaikan visi dengan lebih efektif',
        'Pelajari untuk lebih menghargai detail dan implementasi praktis dari ide-ide besar',
        'Latih kemampuan untuk menerima feedback dan kritik konstruktif',
        'Kembangkan empati dan pemahaman terhadap perspektif emosional orang lain'
      ],
      'INTP': [
        'Fokuskan pada menyelesaikan proyek hingga tuntas, bukan hanya mengeksplorasi ide',
        'Kembangkan keterampilan organisasi dan manajemen waktu',
        'Latih kemampuan untuk mengkomunikasikan ide kompleks dengan cara yang mudah dipahami',
        'Pelajari untuk lebih mempertimbangkan aspek emosional dalam pengambilan keputusan'
      ],
      // Add more suggestions for other types...
    };
    return suggestions[type] ??
        [
          'Terus kembangkan kekuatan alami Anda',
          'Pelajari untuk menggunakan fungsi kognitif yang kurang dominan',
          'Cari feedback dari orang lain untuk pertumbuhan pribadi',
          'Tetap terbuka terhadap pengalaman dan perspektif baru'
        ];
  }
}
