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

  static Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('Error seeking audio: $e');
    }
  }
}

class TrackPage extends StatelessWidget {
  final String title;
  final String audioFile;
  final IconData icon;

  const TrackPage({
    super.key,
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
      backgroundColor: Colors.white,
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

  const TrackPageContent({
    super.key,
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
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();
    isPlaying = AudioManager.isPlaying(widget.audioFile);
    // Mendengarkan perubahan durasi audio
    AudioManager._audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    // Mendengarkan perubahan posisi audio
    AudioManager._audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    AudioManager.stopAudio();
    super.dispose();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 24.0, color: Colors.blue),
        ),
        const SizedBox(height: 20),
        Slider(
          value: _position.inSeconds.toDouble(),
          min: 0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (newValue) {
            if (mounted) {
              setState(() {
                _position = Duration(seconds: newValue.toInt());
              });
            }
          },
          onChangeEnd: (newValue) {
            if (mounted) {
              AudioManager.seekTo(Duration(seconds: newValue.toInt()));
            }
          },
          activeColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isPlaying ? Colors.white : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                await _toggleAudio();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: isPlaying
                    ? Icon(Icons.stop, size: 40, color: Colors.blue)
                    : Icon(Icons.play_arrow, size: 40, color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
