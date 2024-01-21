import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/news_portal_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Nama Seseorang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '"Setiap detik sangatlah berharga karena waktu mengetahui banyak hal, termasuk rahasia hati."',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: NewsPortalWidget([
                {
                  'title':
                      'Resolusi Kesehatan 2024 Warga RI, Ingin Hindari Overthinking',
                  'link':
                      'https://www.cnnindonesia.com/gaya-hidup/20240102131135-255-1044301/resolusi-kesehatan-2024-warga-ri-ingin-hindari-overthinking'
                },
                {
                  'title':
                      '5 Kebiasaan yang Bisa Menurunkan Risiko Terkena Depresi',
                  'link':
                      'https://www.cnnindonesia.com/gaya-hidup/20231228145506-284-1042701/5-kebiasaan-yang-bisa-menurunkan-risiko-terkena-depresi'
                },
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
