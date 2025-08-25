import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healman_mental_awareness/controller/mental_health_controller.dart';

class StressAssessmentPage extends StatefulWidget {
  const StressAssessmentPage({super.key});

  @override
  State<StressAssessmentPage> createState() => _StressAssessmentPageState();
}

class _StressAssessmentPageState extends State<StressAssessmentPage> {
  final PageController _pageController = PageController();
  int currentQuestionIndex = 0;
  List<int> answers = List.filled(10, -1); // PSS-10 has 10 questions

  final List<String> questions = [
    "In the last month, how often have you been upset because of something that happened unexpectedly?",
    "In the last month, how often have you felt that you were unable to control the important things in your life?",
    "In the last month, how often have you felt nervous and stressed?",
    "In the last month, how often have you felt confident about your ability to handle your personal problems?",
    "In the last month, how often have you felt that things were going your way?",
    "In the last month, how often have you found that you could not cope with all the things that you had to do?",
    "In the last month, how often have you been able to control irritations in your life?",
    "In the last month, how often have you felt that you were on top of things?",
    "In the last month, how often have you been angered because of things that were outside of your control?",
    "In the last month, how often have you felt difficulties were piling up so high that you could not overcome them?",
  ];

  final List<String> options = [
    "Never",
    "Almost Never",
    "Sometimes",
    "Fairly Often",
    "Very Often",
  ];

  // Positive questions (4, 5, 7, 8) need reverse scoring
  final List<bool> isPositiveQuestion = [
    false, // 1
    false, // 2
    false, // 3
    true, // 4 - positive
    true, // 5 - positive
    false, // 6
    true, // 7 - positive
    true, // 8 - positive
    false, // 9
    false, // 10
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
                        'Stress Assessment (PSS-10)',
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
          const SizedBox(height: 20),

          // Question Number Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF667eea).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Question ${questionIndex + 1}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF667eea),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Question Text
          Text(
            questions[questionIndex],
            style: const TextStyle(
              fontSize: 20,
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
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(18),
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
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.2)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '$optionIndex',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[600],
                                ),
                              ),
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
    final result = controller.calculateStressScore(answers, isPositiveQuestion);

    controller.saveAssessmentResult(result);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StressResultPage(result: result),
      ),
    );
  }
}

class StressResultPage extends StatelessWidget {
  final AssessmentResult result;

  const StressResultPage({super.key, required this.result});

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
                                'Stress Level: ${result.severity}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: _getSeverityColor(result.severity),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Score: ${result.score}/40',
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
                          _getStressInterpretation(result.severity),
                          Icons.info_outline,
                        ),

                        const SizedBox(height: 20),

                        // Recommendations
                        _buildInfoSection(
                          'Recommendations',
                          _getStressRecommendations(result.severity),
                          Icons.lightbulb_outline,
                        ),

                        const SizedBox(height: 20),

                        // Stress Management Tips
                        _buildInfoSection(
                          'Stress Management Tips',
                          _getStressManagementTips(result.severity),
                          Icons.self_improvement,
                        ),

                        const SizedBox(height: 20),

                        // Action Buttons
                        _buildActionButton(
                          'Practice Stress Relief Meditation',
                          Icons.spa,
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
      case 'low':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return Icons.sentiment_very_satisfied;
      case 'moderate':
        return Icons.sentiment_neutral;
      case 'high':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.help_outline;
    }
  }

  String _getStressInterpretation(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return 'Your stress levels are low, indicating that you are managing life\'s challenges well. You have good coping mechanisms and feel in control of your situation.';
      case 'moderate':
        return 'You are experiencing moderate levels of stress. While this is manageable, it may be beneficial to implement additional stress management strategies.';
      case 'high':
        return 'Your stress levels are high, which may be impacting your daily functioning and overall well-being. Consider seeking support and implementing stress reduction techniques.';
      default:
        return 'Unable to determine stress level. Please retake the assessment or consult with a healthcare provider.';
    }
  }

  String _getStressRecommendations(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return 'Continue your current stress management practices. Maintain healthy lifestyle habits, regular exercise, and good social connections to preserve your well-being.';
      case 'moderate':
        return 'Implement daily stress reduction techniques such as meditation, deep breathing, or yoga. Consider time management strategies and ensure adequate sleep and nutrition.';
      case 'high':
        return 'Prioritize stress management immediately. Consider professional counseling, reduce commitments where possible, and implement multiple stress reduction techniques daily.';
      default:
        return 'Consult with a healthcare provider for personalized stress management recommendations.';
    }
  }

  String _getStressManagementTips(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return '• Maintain regular exercise routine\n• Practice gratitude daily\n• Keep social connections strong\n• Continue healthy sleep habits';
      case 'moderate':
        return '• Practice deep breathing exercises\n• Try progressive muscle relaxation\n• Limit caffeine and alcohol\n• Set realistic goals and priorities\n• Take regular breaks during work';
      case 'high':
        return '• Seek professional support\n• Practice meditation or mindfulness daily\n• Eliminate non-essential commitments\n• Use stress management apps\n• Consider therapy or counseling\n• Focus on basic self-care needs';
      default:
        return 'Consult with a healthcare provider for personalized stress management strategies.';
    }
  }
}
