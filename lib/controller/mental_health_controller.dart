import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MentalHealthController extends ChangeNotifier {
  List<AssessmentResult> _assessmentHistory = [];
  List<AssessmentResult> get assessmentHistory => _assessmentHistory;

  AssessmentResult? _latestResult;
  AssessmentResult? get latestResult => _latestResult;

  MentalHealthController() {
    loadAssessmentHistory();
  }

  Future<void> saveAssessmentResult(AssessmentResult result) async {
    _assessmentHistory.insert(0, result);
    _latestResult = result;

    await _saveAssessmentHistory();
    notifyListeners();
  }

  Future<void> loadAssessmentHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('assessment_history');

    if (historyJson != null) {
      final List<dynamic> decoded = json.decode(historyJson);
      _assessmentHistory =
          decoded.map((item) => AssessmentResult.fromJson(item)).toList();

      if (_assessmentHistory.isNotEmpty) {
        _latestResult = _assessmentHistory.first;
      }
    }
    notifyListeners();
  }

  Future<void> _saveAssessmentHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        json.encode(_assessmentHistory.map((e) => e.toJson()).toList());
    await prefs.setString('assessment_history', encoded);
  }

  AssessmentResult calculateDepressionScore(List<int> answers) {
    int totalScore = answers.reduce((a, b) => a + b);

    String severity;
    String description;
    List<String> recommendations;

    if (totalScore <= 4) {
      severity = 'Minimal';
      description =
          'You show minimal signs of depression. Keep maintaining your mental wellness!';
      recommendations = [
        'Continue healthy lifestyle habits',
        'Practice mindfulness and gratitude',
        'Maintain social connections'
      ];
    } else if (totalScore <= 9) {
      severity = 'Mild';
      description = 'You may be experiencing mild depression symptoms.';
      recommendations = [
        'Consider talking to a counselor',
        'Increase physical activity',
        'Practice stress management techniques'
      ];
    } else if (totalScore <= 14) {
      severity = 'Moderate';
      description = 'You may be experiencing moderate depression symptoms.';
      recommendations = [
        'Seek professional mental health support',
        'Consider therapy or counseling',
        'Focus on self-care activities'
      ];
    } else if (totalScore <= 19) {
      severity = 'Moderately Severe';
      description = 'You may be experiencing moderately severe depression.';
      recommendations = [
        'Strongly consider professional help',
        'Talk to your doctor about treatment options',
        'Reach out to trusted friends or family'
      ];
    } else {
      severity = 'Severe';
      description = 'You may be experiencing severe depression symptoms.';
      recommendations = [
        'Please seek immediate professional help',
        'Contact a mental health crisis line if needed',
        'Don\'t hesitate to reach out for support'
      ];
    }

    return AssessmentResult(
      type: 'Depression',
      score: totalScore,
      maxScore: 27,
      severity: severity,
      description: description,
      recommendations: recommendations,
      timestamp: DateTime.now(),
    );
  }

  AssessmentResult calculateAnxietyScore(List<int> answers) {
    int totalScore = answers.reduce((a, b) => a + b);

    String severity;
    String description;
    List<String> recommendations;

    if (totalScore <= 4) {
      severity = 'Minimal';
      description =
          'You show minimal signs of anxiety. Great job managing stress!';
      recommendations = [
        'Continue stress management practices',
        'Maintain regular exercise routine',
        'Practice relaxation techniques'
      ];
    } else if (totalScore <= 9) {
      severity = 'Mild';
      description = 'You may be experiencing mild anxiety symptoms.';
      recommendations = [
        'Practice deep breathing exercises',
        'Try meditation or mindfulness',
        'Consider reducing caffeine intake'
      ];
    } else if (totalScore <= 14) {
      severity = 'Moderate';
      description = 'You may be experiencing moderate anxiety symptoms.';
      recommendations = [
        'Consider professional counseling',
        'Learn anxiety management techniques',
        'Focus on stress reduction'
      ];
    } else {
      severity = 'Severe';
      description = 'You may be experiencing severe anxiety symptoms.';
      recommendations = [
        'Seek professional mental health support',
        'Consider therapy for anxiety management',
        'Talk to a healthcare provider'
      ];
    }

    return AssessmentResult(
      type: 'Anxiety',
      score: totalScore,
      maxScore: 21,
      severity: severity,
      description: description,
      recommendations: recommendations,
      timestamp: DateTime.now(),
    );
  }

  AssessmentResult calculateStressScore(
      List<int> answers, List<bool> isPositiveQuestion) {
    int totalScore = 0;

    // Calculate score with reverse scoring for positive questions
    for (int i = 0; i < answers.length; i++) {
      if (isPositiveQuestion[i]) {
        // Reverse score: 0->4, 1->3, 2->2, 3->1, 4->0
        totalScore += (4 - answers[i]);
      } else {
        // Normal scoring
        totalScore += answers[i];
      }
    }

    String severity;
    String description;
    List<String> recommendations;

    if (totalScore <= 13) {
      severity = 'Low';
      description = 'You have low stress levels. Keep up the good work!';
      recommendations = [
        'Maintain current stress management',
        'Continue healthy lifestyle habits',
        'Practice preventive self-care'
      ];
    } else if (totalScore <= 26) {
      severity = 'Moderate';
      description = 'You have moderate stress levels.';
      recommendations = [
        'Focus on stress reduction techniques',
        'Improve work-life balance',
        'Consider relaxation practices'
      ];
    } else {
      severity = 'High';
      description = 'You have high stress levels that need attention.';
      recommendations = [
        'Prioritize stress management',
        'Consider professional help',
        'Make lifestyle changes to reduce stress'
      ];
    }

    return AssessmentResult(
      type: 'Stress',
      score: totalScore,
      maxScore: 40,
      severity: severity,
      description: description,
      recommendations: recommendations,
      timestamp: DateTime.now(),
    );
  }
}

class AssessmentResult {
  final String type;
  final int score;
  final int maxScore;
  final String severity;
  final String description;
  final List<String> recommendations;
  final DateTime timestamp;

  AssessmentResult({
    required this.type,
    required this.score,
    required this.maxScore,
    required this.severity,
    required this.description,
    required this.recommendations,
    required this.timestamp,
  });

  double get percentage => (score / maxScore) * 100;

  Color get severityColor {
    switch (severity.toLowerCase()) {
      case 'minimal':
      case 'low':
        return Colors.green;
      case 'mild':
      case 'moderate':
        return Colors.orange;
      case 'moderately severe':
      case 'high':
        return Colors.red[700]!;
      case 'severe':
        return Colors.red[900]!;
      default:
        return Colors.grey;
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'score': score,
        'maxScore': maxScore,
        'severity': severity,
        'description': description,
        'recommendations': recommendations,
        'timestamp': timestamp.toIso8601String(),
      };

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      AssessmentResult(
        type: json['type'],
        score: json['score'],
        maxScore: json['maxScore'],
        severity: json['severity'],
        description: json['description'],
        recommendations: List<String>.from(json['recommendations']),
        timestamp: DateTime.parse(json['timestamp']),
      );
}
