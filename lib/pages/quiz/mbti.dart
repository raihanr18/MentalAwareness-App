import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/quiz/quiz_mbti.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Mbti extends StatefulWidget {
  const Mbti({super.key});

  @override
  State<Mbti> createState() => _MbtiState();
}

dynamic height, width;

class _MbtiState extends State<Mbti> {
  bool isMulaiLoading = false;

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
                          SizedBox(
                            height: 80,
                            width: 320,
                            child: ElevatedButton(
                              onPressed: isMulaiLoading
                                  ? null
                                  : () async {
                                      setState(() {
                                        isMulaiLoading = true;
                                      });

                                      final navigator = Navigator.of(context);
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      if (mounted) {
                                        navigator.pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const QuizMbti(),
                                          ),
                                        );
                                        setState(() {
                                          isMulaiLoading = false;
                                        });
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: isMulaiLoading
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : const Text(
                                      "Mulai",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontFamily: 'Poppins'),
                                    ),
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
