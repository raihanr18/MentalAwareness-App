import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/meditasi.dart';
import 'package:healman_mental_awareness/pages/news_portal.dart';
import 'package:healman_mental_awareness/pages/quiz.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: Colors.blue.shade100,
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                height: height * 0.12,
                width: width,
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 55,
                          left: 15,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo_polos.png',
                              width: 50,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Healman',
                              style: TextStyle(
                                color: Colors.indigo.shade800,
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-SemiBold',
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                    ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: height * 0.8108,
                width: width,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: const [
                    NewsPortal(),
                    MeditasiPage(),
                    QuizPage(),
                  ],
                )
              ),
            ],
          )),

      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }

  final _navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.blue,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.favorite_border),
      title: const Text("Meditasi"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.question_answer),
      title: const Text("Quiz"),
      selectedColor: Colors.orange,
    ),
  ];
}
