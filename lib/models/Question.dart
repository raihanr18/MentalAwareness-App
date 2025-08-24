class Question {
  final String text;
  final List<Option> options;

  Question({required this.text, required this.options});
}

class Option {
  final String text;
  final AnswerType type;

  Option({required this.text, required this.type});
}

enum AnswerType {
  introvert,
  extrovert,
  sensing,
  intuition,
  thinking,
  feeling,
  judging,
  perceiving,
}

// Soal
List<Question> questions = [
  Question(
    text: 'Kamu Cenderung', 
    options: [
    Option(
      text: 'Menikmati waktu sendirian',
      type: AnswerType.introvert,
    ),
    Option(
      text: '''Menikmati waktu bersama orang lain''',
      type: AnswerType.extrovert,
    ),
    ]
  ),
  Question(
    text: 'Gaya belajarmu lebih condong ke', 
    options: [
    Option(
      text: 'Teori dan konsep',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Pengalaman dan praktik',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Saat membuat keputusan, lebih mendahulukan', 
    options: [
    Option(
      text: 'Logika dan objektivitas',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Perasaan dan subjektivitas',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Pada umumnya, kamu lebih suka', 
    options: [
    Option(
      text: 'Merencakan segalanya',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Bersikap spontan dan fleksibel',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Preferensimu adalah', 
    options: [
    Option(
      text: 'Berbicara dan berkomunikasi',
      type: AnswerType.extrovert,
    ),
    Option(
      text: 'Mendengarkan dan mengamati',
      type: AnswerType.introvert,
    ),
    ]
  ),
  Question(
    text: 'Kamu merasa lebih nyaman', 
    options: [
    Option(
      text: 'Bekerja dengan orang lain',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Bekerja mandiri',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu cenderung', 
    options: [
    Option(
      text: 'Mengikuti aturan dan prosedur',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Melanggar aturan dan menciptakan inovasi',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam menangani tugas, kamu lebih cenderung', 
    options: [
    Option(
      text: 'Fokus pada detail',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Fokus pada gambaran besar',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, apakah kamu lebih condong ke arah', 
    options: [
    Option(
      text: 'Realistis dan pragmatis',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Idealis dan visioner',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Kamu lebih suka', 
    options: [
    Option(
      text: 'Mengekspresikan diri secara terbuka',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Menjaga privasi diri',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Pilihanmu adalah lebih suka', 
    options: [
    Option(
      text: 'Menghabiskan waktu di masa depan',
      type: AnswerType.introvert,
    ),
    Option(
      text: 'Menghabiskan waktu di masa sekarang',
      type: AnswerType.extrovert,
    ),
    ]
  ),
  Question(
    text: 'Ketika dihadapkan dengan masalah, lebih suka', 
    options: [
    Option(
      text: 'Menganalisis dan memecahkan',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Menciptakan dan menghasilkan ide baru',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam sebuah tim, kamu lebih cenderung menjadi', 
    options: [
    Option(
      text: 'Pemimpin dan pengatur',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Pengikut dan pelaksana',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Gaya komunikasimu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Bersikap diplomatis dan halus',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu merasa lebih dekat dengan', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Preferensimu adalah lebih suka', 
    options: [
    Option(
      text: 'Berfokus pada fakta dan data',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Berfokus pada nilai dan keyakinan',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, kamu lebih memerhatikan', 
    options: [
    Option(
      text: 'Logika dan rasionalitas',
      type: AnswerType.introvert,
    ),
    Option(
      text: 'Emosi dan kepekaan',
      type: AnswerType.extrovert,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu cenderung lebih menikmati', 
    options: [
    Option(
      text: 'Aktivitas diluar ruangan',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Ketenangan di dalam ruangan',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Ketika menghadapi situasi baru, lebih suka', 
    options: [
    Option(
      text: 'Bersikap spontan dan impulsif',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Bersikap terencana dan hati-hati',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, apakah kamu lebih suka menjadi', 
    options: [
    Option(
      text: 'Pemikir dan konseptor',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Pelaku dan eksekutor',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam menyelesaikan masalah, lebih suka', 
    options: [
    Option(
      text: 'Menganalisis dan memecahkan',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Menciptakan dan menghasilkan ide baru',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam sebuah tim, lebih cenderung menjadi', 
    options: [
    Option(
      text: 'Pemimpin dan pengatur',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Pengikut dan pelaksana',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berkomunikasi, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.extrovert,
    ),
    Option(
      text: 'Bersikap diplomatis dan halus',
      type: AnswerType.introvert,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, lebih suka', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam menghadapi masalah, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap logis dan rasional',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Bersikap emosional dan sensitif',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu merasa lebih nyaman', 
    options: [
    Option(
      text: 'Dikelilingi banyak teman',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Dengan beberapa teman dekat',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Gaya berbicaramu lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Berbicara tentang ide dan konsep',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Berbicara tentang orang dan pengalaman',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengambil keputusan, lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Mengambil risiko dan mencoba hal baru',
      type: AnswerType.extrovert,
    ),
    Option(
      text: 'Menghindari risiko dan bermain aman',
      type: AnswerType.introvert,
    ),
    ]
  ),
  Question(
    text: 'Dalam menjalani kehidupan sehari-hari, kamu lebih suka', 
    options: [
    Option(
      text: 'Bersikap konsisten dan stabil',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Bersikap fleksibel dan mudah beradaptasi',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Kamu lebih suka melakukan aktivitas yang melibatkan', 
    options: [
    Option(
      text: 'Tangan dan benda',
      type: AnswerType.feeling,
    ),
    Option(
      text: 'Ide dan konsep',
      type: AnswerType.thinking,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, cenderung lebih memilih', 
    options: [
    Option(
      text: 'Menjadi pemimpin dan pengatur',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Menjadi pengikut dan pelaksana',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berkomunikasi, kamu lebih suka', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Menjadi pendengar yang baik dan memahami',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Ketika membuat keputusan, lebih suka', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berpikir, cenderung lebih menyukai', 
    options: [
    Option(
      text: 'Fokus pada fakta dan data',
      type: AnswerType.introvert,
    ),
    Option(
      text: 'Fokus pada nilai dan keyakinan',
      type: AnswerType.extrovert,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengatasi masalah, lebih suka', 
    options: [
    Option(
      text: 'Bersikap logis dan rasional',
      type: AnswerType.intuition,
    ),
    Option(
      text: 'Bersikap emosional dan sensitif',
      type: AnswerType.intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam bekerja, pilihamu lebih condong untuk', 
    options: [
    Option(
      text: 'Mengikuti aturan dan prosedur',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Melanggar aturan dan menciptakan inovasi',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Apakah sifatmu lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Serius',
      type: AnswerType.judging,
    ),
    Option(
      text: 'Humoris',
      type: AnswerType.perceiving,
    ),
    ]
  ),
  Question(
    text: 'Saat menghadapi tantangan, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap introspektif dan reflektif',
      type: AnswerType.introvert,
    ),
    Option(
      text: 'Bersikap ekspresif dan spontan',
      type: AnswerType.extrovert,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, lebih suka',  
    options: [
    Option(
      text: 'Fokus pada fakta dan data',
      type: AnswerType.thinking,
    ),
    Option(
      text: 'Fokus pada nilai dan kenyataan',
      type: AnswerType.feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengejar minat dan bakat, lebih suka', 
    options: [
    Option(
      text: 'Mempunyai banyak minat dan bakat',
      type: AnswerType.sensing,
    ),
    Option(
      text: 'Mempunyai beberapa minat dan bakat yang mendalam',
      type: AnswerType.intuition,
    ),
    ]
  ),
];
