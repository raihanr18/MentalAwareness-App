import 'package:flutter/material.dart';
import 'track.dart';

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
          MeditasiListItem(
            title: 'Untuk Kamu Yang Sedang Hilang Harapan',
            audioFile: 'hilangharapan.mp3',
            icon: Icons.healing,
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackPage(
                title: widget.title,
                audioFile: widget.audioFile,
                icon: widget.icon,
              ),
            ),
          );
        },
        child: ListTile(
          leading: Icon(widget.icon, color: Colors.indigo),
          title: Text(widget.title),
        ),
      ),
    );
  }
}
