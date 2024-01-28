import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/login.dart';
import 'package:healman_mental_awareness/pages/meditasi.dart';
import 'package:healman_mental_awareness/pages/news_portal.dart';
import 'package:healman_mental_awareness/pages/quiz.dart';
import 'package:healman_mental_awareness/provider/sign_in_provider.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataSharedPreferences();
  }
    
  @override
  void initState() {
    super.initState();

    getData();
  }

  int _selectedIndex = 0;
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
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
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: roundedWidget(),
                  height: height * 0.8108,
                  width: width,
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: const [
                      NewsPortal(),
                      MeditasiPage(),
                      QuizPage(),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: roundedWidget(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 20,
                          bottom: 2.5,
                        ),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage("${sp.imageUrl}"),
                              radius: 19,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Hai, ${sp.name}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-SemiBold',
                              ),
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.black),
                              onSelected: (String result) {
                                print('Selected: $result');
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'profile',
                                  child: Text('Profile'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'tentang_kami',
                                  child: Text('Tentang Kami'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'logout',
                                  child: const Text('Logout'),
                                  onTap: () {
                                    sp.userLogout();
                                    nextPageReplace(context, const Login());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
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
