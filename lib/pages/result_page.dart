import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/models/Question.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';

class ResultPage extends StatefulWidget {
  final List<Option> userAnswers;

  const ResultPage({Key? key, required this.userAnswers}) : super(key: key);

  @override
  State<ResultPage> createState() => ResultPageState();
}

dynamic height, width;

class ResultPageState extends State<ResultPage> {
  late String mbtiType;
  late String mbtiDesc;

  @override
  void initState() {
    super.initState();
    calculateMBTIType();
  }

  void calculateMBTIType() {
    // Hitung jumlah jawaban untuk setiap jenis kepribadian
    Map<AnswerType, int> counts = {
      AnswerType.Introvert: 0,
      AnswerType.Extrovert: 0,
      AnswerType.Sensing: 0,
      AnswerType.Intuition: 0,
      AnswerType.Thinking: 0,
      AnswerType.Feeling: 0,
      AnswerType.Judging: 0,
      AnswerType.Perceiving: 0,
    };

    for (var answer in widget.userAnswers) {
      counts[answer.type] = (counts[answer.type] ?? 0) + 1;
    }

    // Tentukan jenis kepribadian berdasarkan perhitungan
    String mbti = '';
    mbti += counts[AnswerType.Extrovert]! > counts[AnswerType.Introvert]!
        ? 'E'
        : 'I';
    mbti +=
        counts[AnswerType.Sensing]! > counts[AnswerType.Intuition]! ? 'S' : 'N';
    mbti +=
        counts[AnswerType.Thinking]! > counts[AnswerType.Feeling]! ? 'T' : 'F';
    mbti += counts[AnswerType.Judging]! > counts[AnswerType.Perceiving]!
        ? 'J'
        : 'P';

    // Tentukan jenis MBTI berdasarkan hasil
    switch (mbti) {
      case 'ISTJ':
        mbtiType = 'Introvert, Sensing, Thinking, Judging (ISTJ)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ISTJ biasanya berorientasi introvert, peka, berpikir, dan berorientasi pada penilaian. Mereka sangat logis dan sistematis dalam pendekatan mereka terhadap hidup, dan mereka sangat menghargai struktur dan organisasi. ISTJ biasanya merencanakan segala sesuatunya secara hati-hati dan membuat daftar tugas yang perlu diselesaikan. Mereka sangat detail dan teliti, dan mereka selalu memastikan bahwa setiap detail telah dipertimbangkan. ISTJ juga sangat bertanggung jawab dan dapat diandalkan, dan mereka biasanya orang yang disegani karena dedikasi mereka terhadap tanggung jawab mereka.';
        break;
      case 'ISFJ':
        mbtiType = 'Introvert, Sensing, Feeling, Judging (ISFJ)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ISFJ biasanya berorientasi introvert, peka, berorientasi pada perasaan, dan berorientasi pada penilaian. Mereka sangat hangat dan memperhatikan orang lain, dan mereka selalu menempatkan kebutuhan orang lain di atas kebutuhan mereka sendiri. ISFJ biasanya sangat bertanggung jawab dan mereka selalu siap untuk membantu ketika dibutuhkan. Mereka sangat peduli terhadap orang lain dan mereka selalu berusaha membuat orang lain merasa nyaman dan dihargai.';
        break;
      case 'INFJ':
        mbtiType = 'Introvert, Intuitive, Feeling, Judging (INFJ)';
        mbtiDesc =
            'Orang dengan tipe kepribadian INFJ biasanya berorientasi introvert, intuitif, berorientasi pada perasaan, dan berorientasi pada penilaian. Mereka sangat kreatif dan empatik, dan mereka selalu fokus pada masa depan. INFJ sering memiliki visi yang kuat tentang apa yang mereka inginkan dalam hidup, dan mereka mampu bekerja keras untuk mencapai tujuan mereka. Mereka biasanya sangat pemahaman dan sensitif terhadap perasaan orang lain, dan mereka selalu berusaha untuk membantu orang lain mencapai potensi terbaik mereka.';
        break;
      case 'INTJ':
        mbtiType = 'Introvert, Intuitive, Thinking, Judging (INTJ)';
        mbtiDesc =
            'Orang dengan tipe kepribadian INTJ biasanya berorientasi introvert, intuitif, berpikir, dan berorientasi pada penilaian. Mereka sangat mandiri dan inovatif, dan mereka memiliki visi yang jelas tentang bagaimana hal-hal harus dilakukan. INTJ cenderung menjadi pemimpin yang baik, dan mereka selalu mencari cara terbaik untuk meningkatkan efisiensi dan produktivitas. Mereka biasanya sangat analitis dan strategis, dan mereka selalu berusaha untuk mencapai hasil terbaik dalam segala hal yang mereka lakukan.';
        break;
      case 'ESTP':
        mbtiType = 'Extroverted, Sensing, Thinking, Perceiving (ESTP)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ESTP biasanya berorientasi ekstrovert, peka, berpikir, dan berorientasi pada persepsi. Mereka sangat pragmatis dan enerjik, dan mereka menyukai tantangan. ESTP sangat adaptif dan mereka dapat dengan mudah menyesuaikan diri dengan perubahan lingkungan. Mereka biasanya sangat spontan dan fleksibel, dan mereka selalu mencari kesenangan dan petualangan dalam hidup.';
        break;
      case 'ESFP':
        mbtiType = 'Extroverted, Sensing, Feeling, Perceiving (ESFP)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ESFP biasanya berorientasi ekstrovert, peka, berorientasi pada perasaan, dan berorientasi pada persepsi. Mereka sangat ramah, antusias, dan menikmati hidup di saat ini. ESFP cenderung sangat sosial dan mereka suka berada di sekitar orang lain. Mereka selalu mencari cara untuk membuat orang lain merasa senang dan nyaman, dan mereka sering menjadi jiwa pesta dalam setiap situasi sosial.';
        break;
      case 'ENFP':
        mbtiType = 'Extroverted, Intuitive, Feeling, Perceiving (ENFP)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ENFP biasanya berorientasi ekstrovert, intuitif, berorientasi pada perasaan, dan berorientasi pada persepsi. Mereka sangat optimis, penuh semangat, dan penuh ide. ENFP suka berbagi ide-ide mereka dengan orang lain, dan mereka sering menjadi sumber inspirasi bagi orang lain. Mereka sangat kreatif dan berorientasi pada masa depan, dan mereka selalu mencari cara baru untuk meningkatkan dunia di sekitar mereka.';
        break;
      case 'ENTJ':
        mbtiType = 'Extroverted, Intuitive, Thinking, Judging (ENTJ)';
        mbtiDesc =
            'Orang dengan tipe kepribadian ENTJ biasanya berorientasi ekstrovert, intuitif, berpikir, dan berorientasi pada penilaian. Mereka sangat ambisius dan biasanya menjadi pemimpin alami. ENTJ selalu fokus pada efisiensi dan produktivitas, dan mereka selalu mencari cara terbaik untuk mencapai tujuan mereka. Mereka biasanya sangat tegas dan langsung, dan mereka selalu berusaha untuk mencapai hasil terbaik dalam segala yang mereka lakukan.';
        break;
      default:
        mbtiType = 'Unknown';
    }
  }

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
                    ),
                  ),
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
                                  'Kamu Adalah "$mbtiType"',
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
                    bottom: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0), 
                      height: 200,
                      width: 380, 
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.visible, 
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Poppins-SemiBold',
                              ),
                              children: [
                                TextSpan(text: mbtiDesc),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 70,
                      width: 400,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            nextPage(context, const HomePage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Kembali',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins-SemiBold'),
                          ),
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