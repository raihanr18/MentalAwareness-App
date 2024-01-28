import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static String? _currentAudioFile;

  static final Map<String, bool> _isPlayingMap = {};

  static Future<void> playAudio(String audioFile, BuildContext context) async {
    try {
      if (_currentAudioFile != null && _currentAudioFile != audioFile) {
        await _audioPlayer.stop();
        _isPlayingMap[_currentAudioFile!] = false;
      }

      await _audioPlayer.play(AssetSource(audioFile));
      _currentAudioFile = audioFile;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Memainkan $audioFile')),
      );

      _isPlayingMap[_currentAudioFile!] = true;
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      if (_currentAudioFile != null) {
        _isPlayingMap[_currentAudioFile!] = false;
      }
      _currentAudioFile = null;
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  static bool isPlaying(String audioFile) {
    return _isPlayingMap[audioFile] ?? false;
  }
}

class TrackPage extends StatelessWidget {
  final String title;
  final String audioFile;
  final IconData icon;

  const TrackPage({super.key, 
    required this.title,
    required this.audioFile,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TrackPageContent(
        title: title,
        audioFile: audioFile,
        icon: icon,
      ),
    );
  }
}

class TrackPageContent extends StatefulWidget {
  final String title;
  final String audioFile;
  final IconData icon;

  const TrackPageContent({super.key, 
    required this.title,
    required this.audioFile,
    required this.icon,
  });

  @override
  _TrackPageContentState createState() => _TrackPageContentState();
}

class _TrackPageContentState extends State<TrackPageContent>
    with SingleTickerProviderStateMixin {
  late bool isPlaying;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isPlaying = AudioManager.isPlaying(widget.audioFile);

    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _toggleAudio() async {
    if (isPlaying) {
      await AudioManager.stopAudio();
    } else {
      await AudioManager.playAudio(widget.audioFile, context);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Icon(
                widget.icon,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isPlaying ? Colors.red : Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              await _toggleAudio();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                isPlaying ? 'Stop' : 'Play',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
