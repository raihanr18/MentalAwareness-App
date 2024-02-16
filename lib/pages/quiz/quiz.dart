import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:healman_mental_awareness/pages/quiz/mbti.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                key: cardA,
                leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Image.asset('assets/icon/mbti.png')),
                title: const Text('Quiz MBTI'),
                children: <Widget>[
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        """Tes ini menggambarkan kepribadian dalam 16 tipe berdasarkan preferensi empat dimensi utama. Bantu kamu mengerti bagaimana cara kamu berinteraksi dengan dunia. """,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          //
                          nextPage(context, const Mbti());
                        },
                        child: const Column(
                          children: <Widget>[
                            Icon(Icons.quiz_rounded, color: Colors.blue),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Coba Quiz',
                              style: TextStyle(
                                  color: Colors.blue, fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card 2
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: ExpansionTileCard(
            //     key: cardB,
            //     leading: CircleAvatar(
            //         backgroundColor: Colors.blue.shade100,
            //         child: Image.asset('assets/icon/loneliness.png')),
            //     title:
            //         const Text('Quiz Tingkat Rasa Kesepian: Loneliness Scale'),
            //     children: <Widget>[
            //       const Divider(
            //         thickness: 1.0,
            //         height: 1.0,
            //       ),
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 16.0,
            //             vertical: 8.0,
            //           ),
            //           child: Text(
            //             """Tes ini mengukur seberapa kesepian seseorang dengan menilai aspek keterlibatan sosial dan dukungan emosional. """,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyMedium!
            //                 .copyWith(fontSize: 16),
            //           ),
            //         ),
            //       ),
            //       ButtonBar(
            //         alignment: MainAxisAlignment.spaceAround,
            //         buttonHeight: 52.0,
            //         buttonMinWidth: 90.0,
            //         children: <Widget>[
            //           TextButton(
            //             style: flatButtonStyle,
            //             onPressed: () {
            //               //
            //             },
            //             child: const Column(
            //               children: <Widget>[
            //                 Icon(Icons.quiz_rounded, color: Colors.blue),
            //                 Padding(
            //                   padding: EdgeInsets.symmetric(vertical: 2.0),
            //                 ),
            //                 Text(
            //                   'Coba Quiz',
            //                   style: TextStyle(
            //                       color: Colors.blue, fontFamily: 'Poppins'),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: ExpansionTileCard(
            //     key: cardC,
            //     leading: CircleAvatar(
            //         backgroundColor: Colors.blue.shade100,
            //         child: Image.asset('assets/icon/persona.png')),
            //     title: const Text('Quiz Kepribadian Big Five'),
            //     children: <Widget>[
            //       const Divider(
            //         thickness: 1.0,
            //         height: 1.0,
            //       ),
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 16.0,
            //             vertical: 8.0,
            //           ),
            //           child: Text(
            //             """Tes ini memecah kepribadian ke dalam lima dimensi utama: Keterbukaan, Kesadaran, Ekstroversi, Kebaikan Hati, dan Neurotisisme. Memberikan wawasan tentang karakteristik kepribadian seseorang. """,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyMedium!
            //                 .copyWith(fontSize: 16),
            //           ),
            //         ),
            //       ),
            //       ButtonBar(
            //         alignment: MainAxisAlignment.spaceAround,
            //         buttonHeight: 52.0,
            //         buttonMinWidth: 90.0,
            //         children: <Widget>[
            //           TextButton(
            //             style: flatButtonStyle,
            //             onPressed: () {
            //               //
            //             },
            //             child: const Column(
            //               children: <Widget>[
            //                 Icon(Icons.quiz_rounded, color: Colors.blue),
            //                 Padding(
            //                   padding: EdgeInsets.symmetric(vertical: 2.0),
            //                 ),
            //                 Text(
            //                   'Coba Quiz',
            //                   style: TextStyle(
            //                       color: Colors.blue, fontFamily: 'Poppins'),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
