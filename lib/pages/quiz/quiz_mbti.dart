import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/quiz/enhanced_result_page.dart';

class QuizMbti extends StatefulWidget {
  const QuizMbti({super.key});

  @override
  State<QuizMbti> createState() => _QuizMbtiState();
}

class _QuizMbtiState extends State<QuizMbti> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> answers = [];
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Dalam situasi sosial, Anda lebih nyaman:',
      'type': 'EI',
      'options': [
        {'text': 'Berada di tengah keramaian', 'value': 'E', 'score': 3},
        {'text': 'Berbicara dengan beberapa orang', 'value': 'E', 'score': 2},
        {'text': 'Mengamati dari pinggir', 'value': 'I', 'score': 2},
        {'text': 'Berbicara satu lawan satu', 'value': 'I', 'score': 3},
      ]
    },
    {
      'question': 'Ketika mengambil keputusan, Anda lebih mengandalkan:',
      'type': 'TF',
      'options': [
        {'text': 'Logika dan fakta objektif', 'value': 'T', 'score': 3},
        {'text': 'Analisis pro-kontra', 'value': 'T', 'score': 2},
        {'text': 'Dampak terhadap orang lain', 'value': 'F', 'score': 2},
        {'text': 'Perasaan dan nilai pribadi', 'value': 'F', 'score': 3},
      ]
    },
    {
      'question': 'Cara Anda memproses informasi:',
      'type': 'SN',
      'options': [
        {
          'text': 'Fokus pada detail dan fakta konkret',
          'value': 'S',
          'score': 3
        },
        {'text': 'Memperhatikan hal-hal praktis', 'value': 'S', 'score': 2},
        {'text': 'Melihat gambaran besar', 'value': 'N', 'score': 2},
        {'text': 'Mencari pola dan kemungkinan', 'value': 'N', 'score': 3},
      ]
    },
    {
      'question': 'Gaya hidup Anda cenderung:',
      'type': 'JP',
      'options': [
        {'text': 'Terencana dan teratur', 'value': 'J', 'score': 3},
        {'text': 'Suka membuat jadwal', 'value': 'J', 'score': 2},
        {'text': 'Fleksibel dan adaptif', 'value': 'P', 'score': 2},
        {'text': 'Spontan dan terbuka', 'value': 'P', 'score': 3},
      ]
    },
    {
      'question': 'Setelah hari yang panjang, Anda lebih suka:',
      'type': 'EI',
      'options': [
        {'text': 'Keluar dengan teman-teman', 'value': 'E', 'score': 3},
        {'text': 'Menghadiri acara sosial', 'value': 'E', 'score': 2},
        {'text': 'Waktu sendiri di rumah', 'value': 'I', 'score': 2},
        {'text': 'Merenung dan bersantai', 'value': 'I', 'score': 3},
      ]
    },
    {
      'question': 'Dalam menyelesaikan masalah, Anda:',
      'type': 'TF',
      'options': [
        {'text': 'Menggunakan analisis sistematis', 'value': 'T', 'score': 3},
        {'text': 'Mencari solusi efisien', 'value': 'T', 'score': 2},
        {'text': 'Mempertimbangkan dampak emosional', 'value': 'F', 'score': 2},
        {'text': 'Mengutamakan harmoni kelompok', 'value': 'F', 'score': 3},
      ]
    },
    {
      'question': 'Anda lebih tertarik pada:',
      'type': 'SN',
      'options': [
        {'text': 'Hal-hal yang sudah terbukti', 'value': 'S', 'score': 3},
        {'text': 'Pengalaman praktis', 'value': 'S', 'score': 2},
        {'text': 'Ide-ide inovatif', 'value': 'N', 'score': 2},
        {'text': 'Kemungkinan masa depan', 'value': 'N', 'score': 3},
      ]
    },
    {
      'question': 'Pendekatan Anda terhadap deadline:',
      'type': 'JP',
      'options': [
        {'text': 'Menyelesaikan jauh sebelumnya', 'value': 'J', 'score': 3},
        {'text': 'Membuat timeline yang jelas', 'value': 'J', 'score': 2},
        {'text': 'Bekerja dengan pressure', 'value': 'P', 'score': 2},
        {'text': 'Menyelesaikan di menit terakhir', 'value': 'P', 'score': 3},
      ]
    },
    {
      'question': 'Dalam berkomunikasi, Anda:',
      'type': 'EI',
      'options': [
        {'text': 'Langsung dan ekspresif', 'value': 'E', 'score': 3},
        {'text': 'Suka berbagi cerita', 'value': 'E', 'score': 2},
        {'text': 'Mendengarkan lebih banyak', 'value': 'I', 'score': 2},
        {'text': 'Bicara setelah memikirkan', 'value': 'I', 'score': 3},
      ]
    },
    {
      'question': 'Saat menghadapi kritik, Anda:',
      'type': 'TF',
      'options': [
        {'text': 'Mengevaluasi objektif', 'value': 'T', 'score': 3},
        {'text': 'Fokus pada perbaikan', 'value': 'T', 'score': 2},
        {
          'text': 'Mempertimbangkan niat pemberi kritik',
          'value': 'F',
          'score': 2
        },
        {'text': 'Merasa tersentuh secara personal', 'value': 'F', 'score': 3},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _nextQuestion(int optionIndex) {
    final currentQuestion = questions[currentQuestionIndex];
    final selectedOption = currentQuestion['options'][optionIndex];

    answers.add({
      'questionIndex': currentQuestionIndex,
      'type': currentQuestion['type'],
      'value': selectedOption['value'],
      'score': selectedOption['score'],
    });

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      _slideController.reset();
      _slideController.forward();
    } else {
      _showResults();
    }
  }

  void _showResults() {
    // Kirim data mentah answers langsung ke EnhancedResultPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EnhancedResultPage(
          userAnswers: answers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Progress bar yang tidak mencapai 100% di soal terakhir
    final progress = currentQuestionIndex / questions.length;
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress
            _buildHeader(progress),

            // Question content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question number and category
                      _buildQuestionInfo(),

                      const SizedBox(height: 24),

                      // Question text
                      _buildQuestionText(currentQuestion['question']),

                      const SizedBox(height: 32),

                      // Answer options
                      Expanded(
                        child: _buildAnswerOptions(currentQuestion['options']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey[700],
                    size: 18,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Tes Kepribadian MBTI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${currentQuestionIndex + 1}/${questions.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

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
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    width: constraints.maxWidth * progress,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.purple.shade500],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progres',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: progress * 100,
                ),
                builder: (context, value, child) {
                  return Text(
                    '${value.toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInfo() {
    final typeMap = {
      'EI': 'Energi & Perhatian',
      'SN': 'Cara Memproses Informasi',
      'TF': 'Pengambilan Keputusan',
      'JP': 'Gaya Hidup',
    };

    final currentType = questions[currentQuestionIndex]['type'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              currentType,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori: ${typeMap[currentType]}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                Text(
                  'Pertanyaan ${currentQuestionIndex + 1} dari ${questions.length}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionText(String question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnswerOptions(List<Map<String, dynamic>> options) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final letters = ['A', 'B', 'C', 'D'];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _nextQuestion(index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Center(
                        child: Text(
                          letters[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option['text'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
