import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healman_mental_awareness/controller/mood_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class EnhancedMeditationPage extends StatefulWidget {
  const EnhancedMeditationPage({super.key});

  @override
  State<EnhancedMeditationPage> createState() => _EnhancedMeditationPageState();
}

class _EnhancedMeditationPageState extends State<EnhancedMeditationPage> {
  String selectedCategory = 'Semua';
  MeditationItem? currentPlayingMeditation;
  AudioPlayer? _audioPlayer;
  bool isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer?.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });
    _audioPlayer?.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });
    _audioPlayer?.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          _position = const Duration();
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause(MeditationItem meditation) async {
    try {
      if (_audioPlayer == null) {
        print('AudioPlayer is null, reinitializing...');
        _initializeAudioPlayer();
      }

      if (currentPlayingMeditation == meditation && isPlaying) {
        // Pause current audio
        await _audioPlayer?.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        // Stop current audio if playing different meditation
        if (currentPlayingMeditation != null &&
            currentPlayingMeditation != meditation) {
          await _audioPlayer?.stop();
        }

        // Play new audio
        if (meditation.audioFile.isNotEmpty) {
          print('Playing audio: ${meditation.audioFile}');
          await _audioPlayer?.play(AssetSource(meditation.audioFile));
          setState(() {
            currentPlayingMeditation = meditation;
            isPlaying = true;
          });
        } else {
          print('No audio file found for meditation: ${meditation.title}');
        }
      }
    } catch (e) {
      print('Error playing audio: $e');
      // Reset audio player on error
      setState(() {
        isPlaying = false;
        currentPlayingMeditation = null;
      });
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer?.stop();
    setState(() {
      isPlaying = false;
      currentPlayingMeditation = null;
      _position = const Duration();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  final List<String> categories = [
    'Semua',
    'Rekomendasi',
    'Redakan Stres',
    'Tidur',
    'Fokus',
    'Mindfulness'
  ];

  final Map<String, List<MeditationItem>> meditationCategories = {
    'Redakan Stres': [
      MeditationItem(
        title: 'Pernapasan Dalam untuk Stres',
        description: 'Tenangkan pikiran dengan latihan pernapasan terfokus',
        audioFile: 'music/stress.mp3',
        icon: Icons.air,
        duration: '10 menit',
        difficulty: 'Pemula',
        tags: ['stres', 'pernapasan', 'tenang'],
        color: Colors.blue,
      ),
      MeditationItem(
        title: 'Relaksasi Otot Progresif',
        description: 'Lepaskan ketegangan dari tubuh secara sistematis',
        audioFile: 'music/stress.mp3',
        icon: Icons.self_improvement,
        duration: '15 menit',
        difficulty: 'Menengah',
        tags: ['stres', 'relaksasi', 'tubuh'],
        color: Colors.teal,
      ),
    ],
    'Tidur': [
      MeditationItem(
        title: 'Meditasi Tidur Damai',
        description: 'Panduan lembut untuk membantu tidur secara alami',
        audioFile: 'music/tidur.mp3',
        icon: Icons.nightlight_round,
        duration: '20 menit',
        difficulty: 'Pemula',
        tags: ['tidur', 'malam', 'damai'],
        color: Colors.indigo,
      ),
      MeditationItem(
        title: 'Pemindaian Tubuh untuk Tidur',
        description:
            'Rilekskan setiap bagian tubuh untuk tidur yang lebih baik',
        audioFile: 'music/tidur.mp3',
        icon: Icons.bedtime,
        duration: '25 menit',
        difficulty: 'Pemula',
        tags: ['tidur', 'pemindaian tubuh', 'relaksasi'],
        color: Colors.purple,
      ),
    ],
    'Fokus': [
      MeditationItem(
        title: 'Latihan Fokus Mindful',
        description: 'Tingkatkan konsentrasi dan kejernihan mental',
        audioFile: 'music/pencerahan.mp3',
        icon: Icons.lightbulb,
        duration: '12 menit',
        difficulty: 'Menengah',
        tags: ['fokus', 'konsentrasi', 'kejernihan'],
        color: Colors.orange,
      ),
      MeditationItem(
        title: 'Meditasi Kerja',
        description: 'Tetap fokus dan produktif selama bekerja',
        audioFile: 'music/pencerahan.mp3',
        icon: Icons.work,
        duration: '8 menit',
        difficulty: 'Pemula',
        tags: ['fokus', 'kerja', 'produktivitas'],
        color: Colors.green,
      ),
    ],
    'Mindfulness': [
      MeditationItem(
        title: 'Kesadaran Saat Ini',
        description: 'Kembangkan kesadaran pada momen sekarang',
        audioFile: 'music/hilangharapan.mp3',
        icon: Icons.psychology,
        duration: '15 menit',
        difficulty: 'Menengah',
        tags: ['mindfulness', 'saat ini', 'kesadaran'],
        color: Colors.deepPurple,
      ),
      MeditationItem(
        title: 'Meditasi Cinta Kasih',
        description: 'Kembangkan welas asih untuk diri sendiri dan orang lain',
        audioFile: 'music/sedih.mp3',
        icon: Icons.favorite,
        duration: '18 menit',
        difficulty: 'Pemula',
        tags: ['mindfulness', 'welas asih', 'cinta'],
        color: Colors.pink,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moodController = context.watch<MoodController>();

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
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Row(
                  children: [
                    const Text(
                      'Meditation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.self_improvement,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section
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
                  child: Column(
                    children: [
                      // Mood-based Recommendation
                      if (moodController.currentMood != null)
                        Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF667eea).withValues(alpha: 0.1),
                                const Color(0xFF764ba2).withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blue[100]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    moodController
                                        .moodTypes[moodController.currentMood]!
                                        .emoji,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Based on your current mood',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _getMoodBasedRecommendation(
                                    moodController.currentMood!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Category Filter
                      Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = selectedCategory == category;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF667eea)
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Meditation List
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          children: _getFilteredMeditations(
                              moodController.currentMood),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMoodBasedRecommendation(String mood) {
    switch (mood) {
      case 'excellent':
        return 'Try Focus Meditation to maintain your energy!';
      case 'good':
        return 'Perfect time for Mindfulness practice';
      case 'okay':
        return 'Light meditation to boost your mood';
      case 'bad':
        return 'Stress relief meditation recommended';
      case 'terrible':
        return 'Gentle breathing exercises for comfort';
      default:
        return 'Choose any meditation that feels right';
    }
  }

  List<Widget> _getFilteredMeditations(String? currentMood) {
    List<MeditationItem> allMeditations = [];

    // Collect all meditations
    meditationCategories.forEach((category, items) {
      allMeditations.addAll(items);
    });

    List<MeditationItem> filteredMeditations;

    if (selectedCategory == 'Semua') {
      filteredMeditations = allMeditations;
    } else if (selectedCategory == 'Recommended' && currentMood != null) {
      filteredMeditations = _getRecommendedForMood(currentMood, allMeditations);
    } else {
      filteredMeditations = meditationCategories[selectedCategory] ?? [];
    }

    return filteredMeditations
        .map((meditation) => _buildMeditationCard(meditation))
        .toList();
  }

  List<MeditationItem> _getRecommendedForMood(
      String mood, List<MeditationItem> allMeditations) {
    switch (mood) {
      case 'terrible':
      case 'bad':
        return allMeditations
            .where((m) =>
                m.tags.contains('stress') ||
                m.tags.contains('breathing') ||
                m.tags.contains('calm'))
            .toList();
      case 'okay':
        return allMeditations
            .where((m) =>
                m.tags.contains('mindfulness') || m.tags.contains('relaxation'))
            .toList();
      case 'good':
      case 'excellent':
        return allMeditations
            .where((m) =>
                m.tags.contains('focus') ||
                m.tags.contains('clarity') ||
                m.tags.contains('mindfulness'))
            .toList();
      default:
        return allMeditations.take(3).toList();
    }
  }

  Widget _buildMeditationCard(MeditationItem meditation) {
    return GestureDetector(
      onTap: () {
        _togglePlayPause(meditation);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: meditation.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                meditation.icon,
                color: meditation.color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meditation.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meditation.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: _buildInfoChip(meditation.duration,
                            Icons.access_time, Colors.blue),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: _buildInfoChip(meditation.difficulty,
                            Icons.signal_cellular_alt, Colors.green),
                      ),
                    ],
                  ),
                  // Audio player controls
                  if (currentPlayingMeditation == meditation) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: meditation.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // Play/Pause button
                          GestureDetector(
                            onTap: () => _togglePlayPause(meditation),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: meditation.color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Progress text
                          Text(
                            '${_formatDuration(_position)} / ${_formatDuration(_duration)}',
                            style: TextStyle(
                              fontSize: 10,
                              color: meditation.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Progress bar
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                              ),
                              child: Slider(
                                value: _duration.inMilliseconds > 0
                                    ? _position.inMilliseconds /
                                        _duration.inMilliseconds
                                    : 0,
                                onChanged: (value) async {
                                  final position = Duration(
                                    milliseconds:
                                        (value * _duration.inMilliseconds)
                                            .round(),
                                  );
                                  await _audioPlayer?.seek(position);
                                },
                                activeColor: meditation.color,
                                inactiveColor:
                                    meditation.color.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          // Stop button
                          GestureDetector(
                            onTap: _stopAudio,
                            child: Icon(
                              Icons.stop,
                              color: meditation.color,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Play button (only show when not currently playing)
            Icon(
              currentPlayingMeditation == meditation && isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled,
              color: meditation.color,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MeditationItem {
  final String title;
  final String description;
  final String audioFile;
  final IconData icon;
  final String duration;
  final String difficulty;
  final List<String> tags;
  final Color color;

  MeditationItem({
    required this.title,
    required this.description,
    required this.audioFile,
    required this.icon,
    required this.duration,
    required this.difficulty,
    required this.tags,
    required this.color,
  });
}
