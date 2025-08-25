import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/models/improved_mbti_questions.dart';
import 'package:healman_mental_awareness/utils/improved_mbti_calculator.dart';
import 'package:healman_mental_awareness/pages/quiz/improved_result_page.dart';

class ImprovedQuizMbti extends StatefulWidget {
  const ImprovedQuizMbti({super.key});

  @override
  State<ImprovedQuizMbti> createState() => _ImprovedQuizMbtiState();
}

class _ImprovedQuizMbtiState extends State<ImprovedQuizMbti>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> answers = [];
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  int? selectedOption;

  final List<Map<String, dynamic>> questions = ImprovedMBTIQuestions.questions;

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
    final selectedAnswer = currentQuestion['options'][optionIndex];

    answers.add({
      'questionId': currentQuestion['id'],
      'dimension': currentQuestion['dimension'],
      'selectedType': selectedAnswer['value'],
      'score': selectedAnswer['score'],
      'reverse': currentQuestion['reverse'],
      'context': currentQuestion['context'],
    });

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
      _slideController.reset();
      _slideController.forward();
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final results = ImprovedMBTICalculator.calculateMBTI(answers);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ImprovedResultPage(
          results: results,
          userAnswers: answers,
        ),
      ),
    );
  }

  void _selectOption(int optionIndex) {
    setState(() {
      selectedOption = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Progress yang tidak mencapai 100% di pertanyaan terakhir
    final progress = currentQuestionIndex / questions.length;
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with improved progress
            _buildHeader(progress),

            // Question content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Question info
                    _buildQuestionInfo(),

                    const SizedBox(height: 24),

                    // Question card
                    SlideTransition(
                      position: _slideAnimation,
                      child: _buildQuestionCard(currentQuestion),
                    ),

                    const SizedBox(height: 24),

                    // Continue button
                    _buildContinueButton(),
                  ],
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade600,
            Colors.purple.shade500,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Expanded(
                child: const Text(
                  'Tes Kepribadian MBTI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48), // Balance the back button
            ],
          ),

          const SizedBox(height: 16),

          // Enhanced Progress bar
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    width: constraints.maxWidth * progress,
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.yellow],
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pertanyaan ${currentQuestionIndex + 1} dari ${questions.length}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
    final currentQuestion = questions[currentQuestionIndex];
    final dimensionName = _getDimensionName(currentQuestion['dimension']);
    final contextName = _getContextName(currentQuestion['context']);

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
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getContextIcon(currentQuestion['context']),
              color: Colors.blue.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dimensionName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                Text(
                  'Konteks: $contextName',
                  style: TextStyle(
                    fontSize: 11,
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

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question['statement'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: question['options'].asMap().entries.map<Widget>((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = selectedOption == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _selectOption(index),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade50
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue.shade300
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
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
                                  ? Colors.blue.shade500
                                  : Colors.grey.shade300,
                            ),
                            child: isSelected
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option['text'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.blue.shade700
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: selectedOption != null
            ? () => _nextQuestion(selectedOption!)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          elevation: selectedOption != null ? 8 : 0,
          shadowColor: Colors.blue.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastQuestion ? 'Lihat Hasil' : 'Lanjutkan',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isLastQuestion ? Icons.psychology : Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getDimensionName(String dimension) {
    switch (dimension) {
      case 'EI':
        return 'Extraversion vs Introversion';
      case 'SN':
        return 'Sensing vs Intuition';
      case 'TF':
        return 'Thinking vs Feeling';
      case 'JP':
        return 'Judging vs Perceiving';
      default:
        return dimension;
    }
  }

  String _getContextName(String context) {
    switch (context) {
      case 'work':
        return 'Pekerjaan';
      case 'social':
        return 'Sosial';
      case 'personal':
        return 'Personal';
      case 'learning':
        return 'Pembelajaran';
      case 'decision':
        return 'Pengambilan Keputusan';
      case 'communication':
        return 'Komunikasi';
      case 'stress':
        return 'Situasi Stres';
      case 'change':
        return 'Perubahan';
      default:
        return context;
    }
  }

  IconData _getContextIcon(String context) {
    switch (context) {
      case 'work':
        return Icons.work;
      case 'social':
        return Icons.people;
      case 'personal':
        return Icons.person;
      case 'learning':
        return Icons.school;
      case 'decision':
        return Icons.psychology;
      case 'communication':
        return Icons.chat;
      case 'stress':
        return Icons.warning;
      case 'change':
        return Icons.change_circle;
      default:
        return Icons.help_outline;
    }
  }
}
