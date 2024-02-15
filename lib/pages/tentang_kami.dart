import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';

class TentangKami extends StatefulWidget {
  const TentangKami({super.key});

  @override
  State<TentangKami> createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Healman',
          style: TextStyle(
              fontSize: 23,
              color: Colors.indigo[800],
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins-SemiBold'),
        ),
        backgroundColor: Colors.blue[100],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/icon/logo_polos.png',
            width: 40,
            height: 40,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, const Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          nextPage(context, const HomePage());
                        },
                      ),
                      const Text(
                        'Tentang Kami',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    height: 5,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/icon/logo_polos.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Healman',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-SemiBold',
                      color: Color(0xFF223A6A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Medical App',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF223A6A),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Selamat datang di Healman Mental Awareness-App! Kami hadir untuk meningkatkan kesadaran dan kesehatan mental remaja di Indonesia. Dapatkan informasi, panduan, dan dukungan untuk mengatasi masalah kesehatan mental serta mengelola stres. Mari bersama menciptakan masa depan yang lebih sehat untuk generasi mendatang.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-SemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
