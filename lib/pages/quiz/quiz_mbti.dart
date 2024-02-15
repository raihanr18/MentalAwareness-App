import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/models/Question.dart';
import 'package:healman_mental_awareness/pages/quiz/mbti.dart';
import 'package:healman_mental_awareness/pages/result_page.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QuizMbti extends StatefulWidget {
  const QuizMbti({super.key});

  @override
  State<QuizMbti> createState() => _QuizMbtiState();
}

double height = 0.0;
double width = 0.0;

class _QuizMbtiState extends State<QuizMbti> {
  final RoundedLoadingButtonController mulaiController =
      RoundedLoadingButtonController();

  List<Question> questionList = questions;
  int indexQuestion = 0;
  Option? selectedOption;
  List<Option> userAnswers = [];
  bool showNextButton = false;

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
                          // Pilihan A, B
                          _answerList(),
                        ],
                      ),
                    ),
                  ),

                  // Soal
                  Positioned(
                    top: 70,
                    child: Container(
                      height: 200,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  questionList[indexQuestion].text,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: RoundedLoadingButton(
                      onPressed: () {
                        nextPage(context, const Mbti());
                        mulaiController.success();
                        mulaiController.reset();
                      },
                      height: 32,
                      width: 115,
                      controller: mulaiController,
                      successColor: Colors.green,
                      color: Colors.blue,
                      valueColor: Colors.white,
                      borderRadius: 15,
                      child: const Wrap(
                        children: [
                          Text(
                            "Kembali",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Next question button
                  Positioned(
                    bottom: 35,
                    right: 10,
                    child: AnimatedOpacity(
                      opacity: showNextButton ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: showNextButton ? RoundedLoadingButton(
                        onPressed: () {
                          setState(() {
                            if (indexQuestion < questions.length - 1) {
                              indexQuestion++;
                              selectedOption = null;
                              showNextButton = false;
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(userAnswers: userAnswers),
                                ),
                              );
                            }
                          });
                          mulaiController.success();
                          mulaiController.reset();
                        },
                        height: 32,
                        width: 115,
                        elevation: 0,
                        controller: mulaiController,
                        successColor: Colors.green,
                        color: Colors.transparent,
                        valueColor: Colors.white,
                        borderRadius: 15,
                        child: Wrap(
                          children: [
                            const SizedBox(width: 20),
                            Image.asset(
                              'assets/icon/arrow_next.png',
                              width: 50,
                            )
                          ],
                        ),
                      ) : const SizedBox(), 
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

  // Pilihan Jawaban
  Widget _answerButton(Option option) {
    bool isSelected = selectedOption == option;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedOption = option;
            userAnswers.add(option); 
            showNextButton = true;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isSelected ? Colors.green : Colors.blue, 
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Center(
              child: isSelected
                  ? Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 30,
                      ),
                    )
                  : null, 
            ),
            Expanded(
              child: Text(
                option.text, 
                style: const TextStyle(
                    fontSize: 20, fontFamily: 'Poppins', color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _answerList() {
    return Column(
      children: questionList[indexQuestion]
          .options
          .map((option) => _answerButton(option))
          .toList(),
    );
  }
}
