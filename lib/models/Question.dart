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
  Introvert,
  Extrovert,
  Sensing,
  Intuition,
  Thinking,
  Feeling,
  Judging,
  Perceiving,
}

// Soal
List<Question> questions = [
  Question(
    text: 'Kamu Cenderung', 
    options: [
    Option(
      text: 'Menikmati waktu sendirian',
      type: AnswerType.Introvert,
    ),
    Option(
      text: '''Menikmati waktu bersama orang lain''',
      type: AnswerType.Extrovert,
    ),
    ]
  ),
  Question(
    text: 'Gaya belajarmu lebih condong ke', 
    options: [
    Option(
      text: 'Teori dan konsep',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Pengalaman dan praktik',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Saat membuat keputusan, lebih mendahulukan', 
    options: [
    Option(
      text: 'Logika dan objektivitas',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Perasaan dan subjektivitas',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Pada umumnya, kamu lebih suka', 
    options: [
    Option(
      text: 'Merencakan segalanya',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Bersikap spontan dan fleksibel',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Preferensimu adalah', 
    options: [
    Option(
      text: 'Berbicara dan berkomunikasi',
      type: AnswerType.Extrovert,
    ),
    Option(
      text: 'Mendengarkan dan mengamati',
      type: AnswerType.Introvert,
    ),
    ]
  ),
  Question(
    text: 'Kamu merasa lebih nyaman', 
    options: [
    Option(
      text: 'Bekerja dengan orang lain',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Bekerja mandiri',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu cenderung', 
    options: [
    Option(
      text: 'Mengikuti aturan dan prosedur',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Melanggar aturan dan menciptakan inovasi',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam menangani tugas, kamu lebih cenderung', 
    options: [
    Option(
      text: 'Fokus pada detail',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Fokus pada gambaran besar',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, apakah kamu lebih condong ke arah', 
    options: [
    Option(
      text: 'Realistis dan pragmatis',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Idealis dan visioner',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Kamu lebih suka', 
    options: [
    Option(
      text: 'Mengekspresikan diri secara terbuka',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Menjaga privasi diri',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Pilihanmu adalah lebih suka', 
    options: [
    Option(
      text: 'Menghabiskan waktu di masa depan',
      type: AnswerType.Introvert,
    ),
    Option(
      text: 'Menghabiskan waktu di masa sekarang',
      type: AnswerType.Extrovert,
    ),
    ]
  ),
  Question(
    text: 'Ketika dihadapkan dengan masalah, lebih suka', 
    options: [
    Option(
      text: 'Menganalisis dan memecahkan',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Menciptakan dan menghasilkan ide baru',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam sebuah tim, kamu lebih cenderung menjadi', 
    options: [
    Option(
      text: 'Pemimpin dan pengatur',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Pengikut dan pelaksana',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Gaya komunikasimu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Bersikap diplomatis dan halus',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu merasa lebih dekat dengan', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Preferensimu adalah lebih suka', 
    options: [
    Option(
      text: 'Berfokus pada fakta dan data',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Berfokus pada nilai dan keyakinan',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, kamu lebih memerhatikan', 
    options: [
    Option(
      text: 'Logika dan rasionalitas',
      type: AnswerType.Introvert,
    ),
    Option(
      text: 'Emosi dan kepekaan',
      type: AnswerType.Extrovert,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu cenderung lebih menikmati', 
    options: [
    Option(
      text: 'Aktivitas diluar ruangan',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Ketenangan di dalam ruangan',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Ketika menghadapi situasi baru, lebih suka', 
    options: [
    Option(
      text: 'Bersikap spontan dan impulsif',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Bersikap terencana dan hati-hati',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, apakah kamu lebih suka menjadi', 
    options: [
    Option(
      text: 'Pemikir dan konseptor',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Pelaku dan eksekutor',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam menyelesaikan masalah, lebih suka', 
    options: [
    Option(
      text: 'Menganalisis dan memecahkan',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Menciptakan dan menghasilkan ide baru',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam sebuah tim, lebih cenderung menjadi', 
    options: [
    Option(
      text: 'Pemimpin dan pengatur',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Pengikut dan pelaksana',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berkomunikasi, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.Extrovert,
    ),
    Option(
      text: 'Bersikap diplomatis dan halus',
      type: AnswerType.Introvert,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, lebih suka', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam menghadapi masalah, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap logis dan rasional',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Bersikap emosional dan sensitif',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Apakah kamu merasa lebih nyaman', 
    options: [
    Option(
      text: 'Dikelilingi banyak teman',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Dengan beberapa teman dekat',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Gaya berbicaramu lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Berbicara tentang ide dan konsep',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Berbicara tentang orang dan pengalaman',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengambil keputusan, lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Mengambil risiko dan mencoba hal baru',
      type: AnswerType.Extrovert,
    ),
    Option(
      text: 'Menghindari risiko dan bermain aman',
      type: AnswerType.Introvert,
    ),
    ]
  ),
  Question(
    text: 'Dalam menjalani kehidupan sehari-hari, kamu lebih suka', 
    options: [
    Option(
      text: 'Bersikap konsisten dan stabil',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Bersikap fleksibel dan mudah beradaptasi',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Kamu lebih suka melakukan aktivitas yang melibatkan', 
    options: [
    Option(
      text: 'Tangan dan benda',
      type: AnswerType.Feeling,
    ),
    Option(
      text: 'Ide dan konsep',
      type: AnswerType.Thinking,
    ),
    ]
  ),
  Question(
    text: 'Sebagai individu, cenderung lebih memilih', 
    options: [
    Option(
      text: 'Menjadi pemimpin dan pengatur',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Menjadi pengikut dan pelaksana',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berkomunikasi, kamu lebih suka', 
    options: [
    Option(
      text: 'Bersikap tegas dan blak-blakan',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Menjadi pendengar yang baik dan memahami',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Ketika membuat keputusan, lebih suka', 
    options: [
    Option(
      text: 'Menjadi objektif dan imparsial',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Menjadi subjektif dan personal',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Dalam berpikir, cenderung lebih menyukai', 
    options: [
    Option(
      text: 'Fokus pada fakta dan data',
      type: AnswerType.Introvert,
    ),
    Option(
      text: 'Fokus pada nilai dan keyakinan',
      type: AnswerType.Extrovert,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengatasi masalah, lebih suka', 
    options: [
    Option(
      text: 'Bersikap logis dan rasional',
      type: AnswerType.Intuition,
    ),
    Option(
      text: 'Bersikap emosional dan sensitif',
      type: AnswerType.Intuition,
    ),
    ]
  ),
  Question(
    text: 'Dalam bekerja, pilihamu lebih condong untuk', 
    options: [
    Option(
      text: 'Mengikuti aturan dan prosedur',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Melanggar aturan dan menciptakan inovasi',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Apakah sifatmu lebih cenderung ke arah', 
    options: [
    Option(
      text: 'Serius',
      type: AnswerType.Judging,
    ),
    Option(
      text: 'Humoris',
      type: AnswerType.Perceiving,
    ),
    ]
  ),
  Question(
    text: 'Saat menghadapi tantangan, pilihanmu lebih mendekati', 
    options: [
    Option(
      text: 'Bersikap introspektif dan reflektif',
      type: AnswerType.Introvert,
    ),
    Option(
      text: 'Bersikap ekspresif dan spontan',
      type: AnswerType.Extrovert,
    ),
    ]
  ),
  Question(
    text: 'Dalam pengambilan keputusan, lebih suka',  
    options: [
    Option(
      text: 'Fokus pada fakta dan data',
      type: AnswerType.Thinking,
    ),
    Option(
      text: 'Fokus pada nilai dan kenyataan',
      type: AnswerType.Feeling,
    ),
    ]
  ),
  Question(
    text: 'Dalam mengejar minat dan bakat, lebih suka', 
    options: [
    Option(
      text: 'Mempunyai banyak minat dan bakat',
      type: AnswerType.Sensing,
    ),
    Option(
      text: 'Mempunyai beberapa minat dan bakat yang mendalam',
      type: AnswerType.Intuition,
    ),
    ]
  ),
];
