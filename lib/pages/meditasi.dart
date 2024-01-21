import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MeditasiPage extends StatelessWidget {
  const MeditasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          MeditasiListItem(
            title: 'Meditasi Untuk Mencapai Pencerahan',
            audioFile: 'assets/pencerahan.mp3',
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Sedang Bersedih',
            audioFile: 'assets/sedih.mp3',
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Seseorang Yang Sedang banyak Pikiran',
            audioFile: 'assets/stress.mp3',
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Sedang Tidak Percaya Diri',
            audioFile: 'assets/tidakpercaya.mp3',
          ),
          MeditasiListItem(
            title: 'Meditasi Untuk Yang Susah Tidur',
            audioFile: 'assets/tidur.mp3',
          ),
        ],
      ),
    );
  }
}

class MeditasiListItem extends StatelessWidget {
  final String title;
  final String audioFile;
  final AudioPlayer audioPlayer = AudioPlayer();

  MeditasiListItem({
    super.key,
    required this.title,
    required this.audioFile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: () {
          _playAudio(context);
        },
      ),
    );
  }

  void _playAudio(BuildContext context) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(audioFile));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Memainkan $title')),
      );
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}
