import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/pages/meditasi.dart';
import 'quiz.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const MeditasiPage(),
    const QuizPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              width: 30,
              height: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/meditasi.png',
              width: 30,
              height: 30,
            ),
            label: 'Meditasi',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/quiz.png',
              width: 30,
              height: 30,
            ),
            label: 'Quiz',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
