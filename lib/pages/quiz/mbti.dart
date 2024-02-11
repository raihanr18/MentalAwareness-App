import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/quiz/quiz_mbti.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Mbti extends StatefulWidget {
  const Mbti({super.key});

  @override
  State<Mbti> createState() => _MbtiState();
}

dynamic height, width;

class _MbtiState extends State<Mbti> {
  final RoundedLoadingButtonController mulaiController =
      RoundedLoadingButtonController();

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
            SizedBox(
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
                          'assets/icon/logo_polos.png',
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
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Container(
                      decoration: roundedWidget(),
                      height: height * 0.707,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedLoadingButton(
                            onPressed: () {
                              nextPage(context, const QuizMbti());
                              mulaiController.success();
                              mulaiController.reset();
                            },
                            height: 80,
                            width: 320,
                            controller: mulaiController,
                            successColor: Colors.green,
                            color: Colors.blue,
                            valueColor: Colors.white,
                            borderRadius: 15,
                            child: const Wrap(
                              children: [
                                Text(
                                  "Mulai",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    child: Container(
                      height: 200,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Apakah kamu siap?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
