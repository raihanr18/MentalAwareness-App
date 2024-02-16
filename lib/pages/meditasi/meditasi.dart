import 'package:flutter/material.dart';
import 'track.dart';

class MeditasiPage extends StatelessWidget {
  const MeditasiPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: const [
            MeditasiListItem(
              title: 'Meditasi Untuk Mencapai Pencerahan',
              audioFile: 'music/pencerahan.mp3',
              icon: Icons.lightbulb,
            ),
            MeditasiListItem(
              title: 'Meditasi Untuk Yang Sedang Bersedih',
              audioFile: 'music/sedih.mp3',
              icon: Icons.sentiment_very_dissatisfied,
            ),
            MeditasiListItem(
              title: 'Meditasi Untuk Seseorang Yang Sedang banyak Pikiran',
              audioFile: 'music/stress.mp3',
              icon: Icons.warning,
            ),
            MeditasiListItem(
              title: 'Meditasi Untuk Yang Sedang Tidak Percaya Diri',
              audioFile: 'music/tidakpercaya.mp3',
              icon: Icons.thumb_down_alt,
            ),
            MeditasiListItem(
              title: 'Meditasi Untuk Yang Sedang Susah Tidur',
              audioFile: 'music/tidur.mp3',
              icon: Icons.nightlight_round,
            ),
            MeditasiListItem(
              title: 'Meditasi Untuk Yang Sedang Hilang Harapan',
              audioFile: 'music/hilangharapan.mp3',
              icon: Icons.healing,
            ),
          ],
        ),
      ),
    );
  }
}

class MeditasiListItem extends StatefulWidget {
  final String title;
  final String audioFile;
  final IconData icon;

  const MeditasiListItem({
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
      margin: const EdgeInsets.all(8),
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
