import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MoodController extends ChangeNotifier {
  List<MoodEntry> _moodHistory = [];
  List<MoodEntry> get moodHistory => _moodHistory;

  String? _currentMood;
  String? get currentMood => _currentMood;

  final Map<String, MoodData> moodTypes = {
    'excellent': MoodData(
        name: 'Excellent',
        emoji: '😄',
        color: Color(0xFF4CAF50),
        description: 'Feeling amazing and energetic!'),
    'good': MoodData(
        name: 'Good',
        emoji: '😊',
        color: Color(0xFF8BC34A),
        description: 'Feeling positive and content'),
    'okay': MoodData(
        name: 'Okay',
        emoji: '😐',
        color: Color(0xFFFF9800),
        description: 'Feeling neutral, neither good nor bad'),
    'bad': MoodData(
        name: 'Bad',
        emoji: '😞',
        color: Color(0xFFFF5722),
        description: 'Feeling down or upset'),
    'terrible': MoodData(
        name: 'Terrible',
        emoji: '😢',
        color: Color(0xFFF44336),
        description: 'Feeling very sad or distressed'),
  };

  MoodController() {
    loadMoodHistory();
  }

  Future<void> saveMood(String moodType, String? note) async {
    final entry = MoodEntry(
      mood: moodType,
      note: note,
      timestamp: DateTime.now(),
    );

    _moodHistory.insert(0, entry);
    _currentMood = moodType;

    await _saveMoodHistory();
    notifyListeners();
  }

  Future<void> loadMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('mood_history');

    if (historyJson != null) {
      final List<dynamic> decoded = json.decode(historyJson);
      _moodHistory = decoded.map((item) => MoodEntry.fromJson(item)).toList();

      if (_moodHistory.isNotEmpty) {
        _currentMood = _moodHistory.first.mood;
      }
    }
    notifyListeners();
  }

  Future<void> _saveMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        json.encode(_moodHistory.map((e) => e.toJson()).toList());
    await prefs.setString('mood_history', encoded);
  }

  List<MoodEntry> getWeeklyMoods() {
    final weekAgo = DateTime.now().subtract(Duration(days: 7));
    return _moodHistory
        .where((entry) => entry.timestamp.isAfter(weekAgo))
        .toList();
  }

  double getAverageMoodScore() {
    if (_moodHistory.isEmpty) return 0.0;

    final scores =
        _moodHistory.map((entry) => _getMoodScore(entry.mood)).toList();
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  int _getMoodScore(String mood) {
    switch (mood) {
      case 'excellent':
        return 5;
      case 'good':
        return 4;
      case 'okay':
        return 3;
      case 'bad':
        return 2;
      case 'terrible':
        return 1;
      default:
        return 3;
    }
  }

  List<String> getMoodRecommendations(String mood) {
    switch (mood) {
      case 'excellent':
        return [
          'Keep up the positive energy!',
          'Share your happiness with others',
          'Try maintaining this mood with gratitude practices'
        ];
      case 'good':
        return [
          'Great to see you feeling positive!',
          'Consider meditation to maintain balance',
          'Exercise to boost your mood even more'
        ];
      case 'okay':
        return [
          'Take a short walk outside',
          'Practice deep breathing exercises',
          'Listen to uplifting music'
        ];
      case 'bad':
        return [
          'Try guided meditation for sadness',
          'Talk to a friend or counselor',
          'Consider journaling your thoughts'
        ];
      case 'terrible':
        return [
          'Consider reaching out for professional help',
          'Practice self-care activities',
          'Try calming meditation sessions'
        ];
      default:
        return ['Take care of yourself today'];
    }
  }
}

class MoodData {
  final String name;
  final String emoji;
  final Color color;
  final String description;

  MoodData({
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
  });
}

class MoodEntry {
  final String mood;
  final String? note;
  final DateTime timestamp;

  MoodEntry({
    required this.mood,
    this.note,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'mood': mood,
        'note': note,
        'timestamp': timestamp.toIso8601String(),
      };

  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
        mood: json['mood'],
        note: json['note'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
