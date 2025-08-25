import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healman_mental_awareness/controller/mental_health_controller.dart';

class AnxietyAssessmentPage extends StatefulWidget {
  const AnxietyAssessmentPage({super.key});

  @override
  State<AnxietyAssessmentPage> createState() => _AnxietyAssessmentPageState();
}

class _AnxietyAssessmentPageState extends State<AnxietyAssessmentPage> {
  final PageController _pageController = PageController();
  int currentQuestionIndex = 0;
  List<int> answers = List.filled(7, -1); // GAD-7 has 7 questions

  final List<String> questions = [
    "Feeling nervous, anxious, or on edge",
    "Not being able to stop or control worrying",
    "Worrying too much about different things",
    "Trouble relaxing",
    "Being so restless that it is hard to sit still",
    "Becoming easily annoyed or irritable",
    "Feeling afraid, as if something awful might happen",
  ];

  final List<String> options = [
    "Not at all",
    "Several days",
    "More than half the days",
    "Nearly every day",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Anxiety Assessment (GAD-7)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Progress Indicator
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${currentQuestionIndex + 1} of ${questions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / questions.length,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Content
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentQuestionIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildQuestionPage(index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(int questionIndex) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          // Question Text
          Text(
            'Over the last 2 weeks, how often have you been bothered by:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            questions[questionIndex],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 40),

          // Answer Options
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: options.asMap().entries.map((entry) {
                  int optionIndex = entry.key;
                  String option = entry.value;
                  bool isSelected = answers[questionIndex] == optionIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        answers[questionIndex] = optionIndex;
                      });

                      // Auto-advance after selection
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (questionIndex < questions.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _completeAssessment();
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF667eea)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF667eea)
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Color(0xFF667eea),
                                    size: 16,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                          Text(
                            '$optionIndex',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color:
                                  isSelected ? Colors.white : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Navigation Buttons
          Row(
            children: [
              if (questionIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (questionIndex > 0) const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: answers[questionIndex] != -1
                      ? () {
                          if (questionIndex < questions.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _completeAssessment();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667eea),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    questionIndex == questions.length - 1 ? 'Complete' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _completeAssessment() {
    if (answers.contains(-1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please answer all questions before completing the assessment.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final controller = context.read<MentalHealthController>();
    final result = controller.calculateAnxietyScore(answers);

    controller.saveAssessmentResult(result);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AnxietyResultPage(result: result),
      ),
    );
  }
}

class AnxietyResultPage extends StatelessWidget {
  final AssessmentResult result;

  const AnxietyResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Assessment Results',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Result Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(result.severity)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: _getSeverityColor(result.severity)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _getSeverityIcon(result.severity),
                                size: 60,
                                color: _getSeverityColor(result.severity),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Anxiety Level: ${result.severity}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: _getSeverityColor(result.severity),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Score: ${result.score}/21',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Interpretation
                        _buildInfoSection(
                          'What this means',
                          _getAnxietyInterpretation(result.severity),
                          Icons.info_outline,
                        ),

                        const SizedBox(height: 20),

                        // Recommendations
                        _buildInfoSection(
                          'Recommendations',
                          _getAnxietyRecommendations(result.severity),
                          Icons.lightbulb_outline,
                        ),

                        const SizedBox(height: 20),

                        // Action Buttons
                        _buildActionButton(
                          'View Meditation Exercises',
                          Icons.self_improvement,
                          () => Navigator.pushNamed(context, '/meditation'),
                        ),

                        const SizedBox(height: 12),

                        _buildActionButton(
                          'Track Your Mood',
                          Icons.mood,
                          () => Navigator.pushNamed(context, '/mood-tracker'),
                        ),

                        const SizedBox(height: 12),

                        _buildActionButton(
                          'Take Another Assessment',
                          Icons.quiz,
                          () => Navigator.pushReplacementNamed(
                              context, '/mental-health-assessment'),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF667eea), size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF667eea),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'minimal':
        return Colors.green;
      case 'mild':
        return Colors.orange;
      case 'moderate':
        return Colors.red;
      case 'severe':
        return Colors.red[800]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity.toLowerCase()) {
      case 'minimal':
        return Icons.sentiment_very_satisfied;
      case 'mild':
        return Icons.sentiment_neutral;
      case 'moderate':
        return Icons.sentiment_dissatisfied;
      case 'severe':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.help_outline;
    }
  }

  String _getAnxietyInterpretation(String severity) {
    switch (severity.toLowerCase()) {
      case 'minimal':
        return 'Your anxiety levels appear to be minimal. This suggests you are managing stress well and have good coping mechanisms in place.';
      case 'mild':
        return 'You may be experiencing mild anxiety. This is common and manageable with appropriate self-care strategies and lifestyle adjustments.';
      case 'moderate':
        return 'Your results indicate moderate anxiety levels. Consider implementing stress management techniques and consider speaking with a mental health professional.';
      case 'severe':
        return 'Your responses suggest severe anxiety that may be significantly impacting your daily life. We strongly recommend consulting with a mental health professional for proper evaluation and treatment.';
      default:
        return 'Unable to determine anxiety level. Please retake the assessment or consult with a healthcare provider.';
    }
  }

  String _getAnxietyRecommendations(String severity) {
    switch (severity.toLowerCase()) {
      case 'minimal':
        return 'Continue your current self-care practices. Regular exercise, meditation, and maintaining social connections can help preserve your mental wellness.';
      case 'mild':
        return 'Practice relaxation techniques like deep breathing, meditation, or progressive muscle relaxation. Maintain regular sleep schedule and limit caffeine intake.';
      case 'moderate':
        return 'Consider counseling or therapy. Practice stress management techniques daily. Maintain healthy lifestyle habits and consider limiting stressful situations when possible.';
      case 'severe':
        return 'Seek professional help immediately. Contact a mental health provider, your doctor, or a crisis helpline. Avoid alcohol and drugs, and lean on your support system.';
      default:
        return 'Consult with a healthcare provider for personalized recommendations based on your specific situation.';
    }
  }
}
