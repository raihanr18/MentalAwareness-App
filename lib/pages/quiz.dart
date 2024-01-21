import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [
    {
      'questionText': 'Apa kamu suka bersosialisasi?',
      'answers': [
        {
          'text': 'Ya dong, aku senang keluar dan bertemu orang banyak',
          'value': 2
        },
        {'text': 'Iya, tapi hanya dengan orang yang dikenal saja', 'value': 1},
        {'text': 'Gak, aku lebih suka menyendiri', 'value': 0},
      ],
    },
    {
      'questionText': 'Bagaimana kondisi moodkamu sekarang?',
      'answers': [
        {'text': 'Aku sedang gak enak hati', 'value': 0},
        {'text': 'Tenang dan bahagia', 'value': 2},
        {
          'text': 'Agak khawatir dan sedang memikirkan ma  sa depan',
          'value': 1
        },
      ],
    },
    {
      'questionText': 'Bagaimana kamu bisa menghabiskan waktu luang?',
      'answers': [
        {'text': 'Melakukan hobi', 'value': 2},
        {'text': 'Nonton film', 'value': 0},
        {'text': 'Bertemu dengan teman atau saudara', 'value': 1},
      ],
    },
    {
      'questionText': 'apakah kamu bisa mengontrol emosi?',
      'answers': [
        {'text': 'Gak begitu', 'value': 1},
        {'text': 'Sepertinya aku gak punya emosi, deh', 'value': 0},
        {'text': 'Bisa namun gak setiap saatRadio', 'value': 2},
      ],
    },
    {
      'questionText': 'Bagaimana orang lain mendeskripsikan dirimu?',
      'answers': [
        {'text': 'Bahagia', 'value': 2},
        {'text': 'Penyendiri', 'value': 0},
        {'text': 'Dingin', 'value': 1},
      ],
    },
    {
      'questionText':
          'Seberapa sering Anda merasa cemas atau gelisah tanpa alasan yang jelas?',
      'answers': [
        {'text': 'Tidak pernah', 'value': 2},
        {'text': 'Sering atau hampir selalu.', 'value': 0},
        {'text': 'Kadang-kadang', 'value': 1},
      ],
    },
    {
      'questionText': 'Bagaimana tingkat energi Anda dalam sehari-hari?',
      'answers': [
        {'text': 'Terkadang merasa kurang bertenaga.', 'value': 1},
        {'text': 'Selalu merasa bertenaga.', 'value': 2},
        {'text': 'Sering merasa lelah atau kelelahan.', 'value': 0},
      ],
    },
    {
      'questionText':
          'Seberapa sering Anda merasa sedih atau tidak bersemangat untuk melakukan aktivitas?',
      'answers': [
        {'text': 'Kadang-kadang.', 'value': 1},
        {'text': 'Jarang atau tidak pernah.', 'value': 2},
        {'text': 'Sering atau hampir selalu.', 'value': 0},
      ],
    },
    {
      'questionText': 'Bagaimana tingkat konsentrasi Anda belakangan ini?',
      'answers': [
        {'text': 'Saya bisa berkonsentrasi dengan baik.', 'value': 2},
        {'text': 'Sering sulit untuk berkonsentrasi.', 'value': 0},
        {'text': 'Terkadang sulit berkonsentrasi.', 'value': 1},
      ],
    },
    {
      'questionText':
          'Seberapa sering Anda mengalami perubahan tidur (misalnya, sulit tidur, terbangun tengah malam, atau tidur terlalu banyak)?',
      'answers': [
        {'text': 'Tidur normal dan baik.', 'value': 2},
        {
          'text': 'Sering mengalami perubahan tidur atau gangguan tidur.',
          'value': 0
        },
        {'text': 'Kadang-kadang mengalami perubahan tidur.', 'value': 1},
      ],
    },
  ];

  int _questionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });

    if (_questionIndex < questions.length) {
      // Menampilkan pertanyaan berikutnya jika masih ada pertanyaan tersisa
    } else {
      String message;
      if (_totalScore >= 15) {
        message = 'lanjutkan rutinitas sehari hari anda ';
      } else if (_totalScore >= 10) {
        message =
            'Anda harus meluangkan waktu untuk menenangkan diri seperti meditasi atau mencari hiburan';
      } else if (_totalScore >= 5) {
        message =
            'Anda harus mencari aktivitas yang sangat menghibur, rutin beraktivitas, dan luangkan waktu untuk meditasi';
      } else {
        message =
            'Anda harus diperiksa lebih lanjut dengan mengunjungi dokter psikolog terdekat';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('saran yang kita sampaikan!!'),
            content: Text(message),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _questionIndex < questions.length
                ? Column(
                    children: <Widget>[
                      Text(
                        questions[_questionIndex]['questionText'],
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ...((questions[_questionIndex]['answers']
                              as List<Map<String, dynamic>>))
                          .map(
                            (answer) => ElevatedButton(
                              onPressed: () => _answerQuestion(
                                answer['value'] as int,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  answer['text'] as String,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                          ,
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Anda telah menyelesaikan kuis!',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Nilai Anda: $_totalScore',
                          style: const TextStyle(fontSize: 18),
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
