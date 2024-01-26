import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static AudioPlayer _audioPlayer = AudioPlayer();
  static String? _currentAudioFile;

  // Use a Map to store the playing state for each audio file
  static Map<String, bool> _isPlayingMap = {};

  static Future<void> playAudio(String audioFile, BuildContext context) async {
    try {
      if (_currentAudioFile != null && _currentAudioFile != audioFile) {
        await _audioPlayer.stop();
        // Reset the playing state for the previous audio file
        _isPlayingMap[_currentAudioFile!] = false;
      }

      await _audioPlayer.play(AssetSource(audioFile));
      _currentAudioFile = audioFile;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Memainkan $audioFile')),
      );

      // Update the playing state for the current audio file
      _isPlayingMap[_currentAudioFile!] = true;
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      if (_currentAudioFile != null) {
        // Reset the playing state for the current audio file
        _isPlayingMap[_currentAudioFile!] = false;
      }
      _currentAudioFile = null;
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  // Get the playing state for a specific audio file
  static bool isPlaying(String audioFile) {
    return _isPlayingMap[audioFile] ?? false;
  }
}

class MeditasiPage extends StatelessWidget {
  const MeditasiPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: ListView(
        children: [
          MeditasiListItem(
            title: 'Meditasi Untuk Mencapai Pencerahan',
            audioFile: 'pencerahan.mp3',
            icon: Icons.lightbulb,
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Sedang Bersedih',
            audioFile: 'sedih.mp3',
            icon: Icons.sentiment_very_dissatisfied,
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Seseorang Yang Sedang banyak Pikiran',
            audioFile: 'stress.mp3',
            icon: Icons.warning,
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Sedang Tidak Percaya Diri',
            audioFile: 'tidakpercaya.mp3',
            icon: Icons.thumb_down_alt,
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Susah Tidur',
            audioFile: 'tidur.mp3',
            icon: Icons.nightlight_round,
          ),
        ],
      ),
    );
  }
}

class MeditasiListItem extends StatefulWidget {
  final String title;
  final String audioFile;
  final IconData icon;

  MeditasiListItem({
    Key? key,
    required this.title,
    required this.audioFile,
    required this.icon,
  }) : super(key: key);

  @override
  _MeditasiListItemState createState() => _MeditasiListItemState();
}

class _MeditasiListItemState extends State<MeditasiListItem> {
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    // Initialize the playing state for the current audio file
    isPlaying = AudioManager.isPlaying(widget.audioFile);
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
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () async {
          await _toggleAudio();
        },
        child: ListTile(
          leading: Icon(widget.icon, color: Colors.indigo),
          title: Text(widget.title),
          subtitle: Text(
              'Ketuk untuk ${isPlaying ? "menghentikan" : "memutar"} meditasi'),
          trailing: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
