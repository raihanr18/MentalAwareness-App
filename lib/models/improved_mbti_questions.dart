class ImprovedMBTIQuestions {
  static const List<Map<String, dynamic>> questions = [
    // Extraversion vs Introversion (6 pertanyaan)
    {
      'id': 'EI_1',
      'dimension': 'EI',
      'question': 'Dalam situasi meeting tim, saya lebih suka:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'E', 'score': 5},
        {'text': 'Setuju', 'value': 'E', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'I', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'I', 'score': 1},
      ],
      'statement':
          'Aktif memberikan ide dan berkontribusi dalam diskusi kelompok'
    },
    {
      'id': 'EI_2',
      'dimension': 'EI',
      'question': 'Setelah menghadiri acara sosial yang besar, saya biasanya:',
      'context': 'social',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'I', 'score': 5},
        {'text': 'Setuju', 'value': 'I', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'E', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'E', 'score': 1},
      ],
      'statement': 'Merasa lelah dan butuh waktu sendiri untuk mengisi energi'
    },
    {
      'id': 'EI_3',
      'dimension': 'EI',
      'question': 'Ketika memecahkan masalah kompleks, saya lebih efektif:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'E', 'score': 5},
        {'text': 'Setuju', 'value': 'E', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'I', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'I', 'score': 1},
      ],
      'statement':
          'Berdiskusi dengan orang lain untuk mendapat berbagai perspektif'
    },
    {
      'id': 'EI_4',
      'dimension': 'EI',
      'question':
          'Dalam lingkungan kerja, saya merasa paling produktif ketika:',
      'context': 'work',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'I', 'score': 5},
        {'text': 'Setuju', 'value': 'I', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'E', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'E', 'score': 1},
      ],
      'statement': 'Bekerja dalam ruangan yang tenang tanpa banyak gangguan'
    },
    {
      'id': 'EI_5',
      'dimension': 'EI',
      'question': 'Saat menghadiri pesta atau gathering, saya cenderung:',
      'context': 'social',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'E', 'score': 5},
        {'text': 'Setuju', 'value': 'E', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'I', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'I', 'score': 1},
      ],
      'statement': 'Bertemu dan berbicara dengan banyak orang baru'
    },
    {
      'id': 'EI_6',
      'dimension': 'EI',
      'question': 'Ketika memiliki waktu luang, saya lebih suka:',
      'context': 'personal',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'I', 'score': 5},
        {'text': 'Setuju', 'value': 'I', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'E', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'E', 'score': 1},
      ],
      'statement':
          'Menghabiskan waktu sendiri dengan hobi atau aktivitas personal'
    },

    // Sensing vs Intuition (6 pertanyaan)
    {
      'id': 'SN_1',
      'dimension': 'SN',
      'question': 'Ketika mempelajari hal baru, saya lebih tertarik pada:',
      'context': 'learning',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'N', 'score': 5},
        {'text': 'Setuju', 'value': 'N', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'S', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'S', 'score': 1},
      ],
      'statement': 'Teori dan konsep abstrak serta kemungkinan penerapannya'
    },
    {
      'id': 'SN_2',
      'dimension': 'SN',
      'question': 'Dalam pekerjaan, saya lebih menyukai tugas yang:',
      'context': 'work',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'S', 'score': 5},
        {'text': 'Setuju', 'value': 'S', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'N', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'N', 'score': 1},
      ],
      'statement':
          'Memiliki prosedur yang jelas dan langkah-langkah yang terstruktur'
    },
    {
      'id': 'SN_3',
      'dimension': 'SN',
      'question': 'Ketika membuat keputusan penting, saya lebih mengandalkan:',
      'context': 'decision',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'N', 'score': 5},
        {'text': 'Setuju', 'value': 'N', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'S', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'S', 'score': 1},
      ],
      'statement': 'Intuisi dan gambaran besar tentang kemungkinan masa depan'
    },
    {
      'id': 'SN_4',
      'dimension': 'SN',
      'question': 'Saat menjelaskan sesuatu kepada orang lain, saya cenderung:',
      'context': 'communication',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'S', 'score': 5},
        {'text': 'Setuju', 'value': 'S', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'N', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'N', 'score': 1},
      ],
      'statement': 'Memberikan detail spesifik dan contoh konkret'
    },
    {
      'id': 'SN_5',
      'dimension': 'SN',
      'question': 'Yang paling menarik bagi saya dalam sebuah proyek adalah:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'N', 'score': 5},
        {'text': 'Setuju', 'value': 'N', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'S', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'S', 'score': 1},
      ],
      'statement': 'Mengeksplorasi ide-ide inovatif dan solusi kreatif'
    },
    {
      'id': 'SN_6',
      'dimension': 'SN',
      'question': 'Ketika menghadapi informasi baru, saya lebih fokus pada:',
      'context': 'learning',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'S', 'score': 5},
        {'text': 'Setuju', 'value': 'S', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'N', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'N', 'score': 1},
      ],
      'statement': 'Fakta-fakta dan data yang dapat diverifikasi'
    },

    // Thinking vs Feeling (6 pertanyaan)
    {
      'id': 'TF_1',
      'dimension': 'TF',
      'question':
          'Ketika memberikan feedback kepada rekan kerja, saya lebih mengutamakan:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'T', 'score': 5},
        {'text': 'Setuju', 'value': 'T', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'F', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'F', 'score': 1},
      ],
      'statement': 'Analisis objektif terhadap kinerja dan hasil yang terukur'
    },
    {
      'id': 'TF_2',
      'dimension': 'TF',
      'question':
          'Dalam konflik interpersonal, hal yang paling penting bagi saya adalah:',
      'context': 'social',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'F', 'score': 5},
        {'text': 'Setuju', 'value': 'F', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'T', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'T', 'score': 1},
      ],
      'statement': 'Menjaga harmoni dan memastikan semua pihak merasa didengar'
    },
    {
      'id': 'TF_3',
      'dimension': 'TF',
      'question':
          'Saat mengambil keputusan yang mempengaruhi tim, saya lebih mempertimbangkan:',
      'context': 'decision',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'T', 'score': 5},
        {'text': 'Setuju', 'value': 'T', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'F', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'F', 'score': 1},
      ],
      'statement': 'Efisiensi dan logika dari solusi yang dipilih'
    },
    {
      'id': 'TF_4',
      'dimension': 'TF',
      'question': 'Yang membuat saya merasa puas dalam pekerjaan adalah:',
      'context': 'work',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'F', 'score': 5},
        {'text': 'Setuju', 'value': 'F', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'T', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'T', 'score': 1},
      ],
      'statement':
          'Membantu orang lain dan berkontribusi untuk kesejahteraan tim'
    },
    {
      'id': 'TF_5',
      'dimension': 'TF',
      'question': 'Ketika mengkritik ide atau proposal, saya lebih fokus pada:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'T', 'score': 5},
        {'text': 'Setuju', 'value': 'T', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'F', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'F', 'score': 1},
      ],
      'statement': 'Kelemahan logis dan inkonsistensi dalam argumentasi'
    },
    {
      'id': 'TF_6',
      'dimension': 'TF',
      'question': 'Dalam situasi yang menekan, saya cenderung:',
      'context': 'stress',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'F', 'score': 5},
        {'text': 'Setuju', 'value': 'F', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'T', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'T', 'score': 1},
      ],
      'statement': 'Memprioritaskan perasaan dan kesejahteraan emosional tim'
    },

    // Judging vs Perceiving (6 pertanyaan)
    {
      'id': 'JP_1',
      'dimension': 'JP',
      'question': 'Dalam mengelola proyek, saya lebih suka:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'J', 'score': 5},
        {'text': 'Setuju', 'value': 'J', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'P', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'P', 'score': 1},
      ],
      'statement': 'Membuat rencana detail dan mengikuti timeline yang ketat'
    },
    {
      'id': 'JP_2',
      'dimension': 'JP',
      'question': 'Ketika menghadapi deadline, saya biasanya:',
      'context': 'work',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'P', 'score': 5},
        {'text': 'Setuju', 'value': 'P', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'J', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'J', 'score': 1},
      ],
      'statement': 'Bekerja dengan intensitas tinggi menjelang batas waktu'
    },
    {
      'id': 'JP_3',
      'dimension': 'JP',
      'question': 'Ruang kerja saya biasanya:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'J', 'score': 5},
        {'text': 'Setuju', 'value': 'J', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'P', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'P', 'score': 1},
      ],
      'statement': 'Terorganisir rapi dengan semua dokumen tersusun sistematis'
    },
    {
      'id': 'JP_4',
      'dimension': 'JP',
      'question': 'Ketika membuat rencana liburan, saya lebih suka:',
      'context': 'personal',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'P', 'score': 5},
        {'text': 'Setuju', 'value': 'P', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'J', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'J', 'score': 1},
      ],
      'statement':
          'Memiliki fleksibilitas untuk berubah sesuai situasi dan mood'
    },
    {
      'id': 'JP_5',
      'dimension': 'JP',
      'question': 'Dalam meeting, saya merasa paling nyaman ketika:',
      'context': 'work',
      'reverse': false,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'J', 'score': 5},
        {'text': 'Setuju', 'value': 'J', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'P', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'P', 'score': 1},
      ],
      'statement': 'Ada agenda yang jelas dan pembahasan sesuai jadwal'
    },
    {
      'id': 'JP_6',
      'dimension': 'JP',
      'question': 'Saat menghadapi perubahan mendadak dalam rencana, saya:',
      'context': 'change',
      'reverse': true,
      'options': [
        {'text': 'Sangat Setuju', 'value': 'P', 'score': 5},
        {'text': 'Setuju', 'value': 'P', 'score': 4},
        {'text': 'Netral', 'value': 'neutral', 'score': 3},
        {'text': 'Tidak Setuju', 'value': 'J', 'score': 2},
        {'text': 'Sangat Tidak Setuju', 'value': 'J', 'score': 1},
      ],
      'statement': 'Mudah beradaptasi dan melihatnya sebagai peluang baru'
    },
  ];

  static Map<String, List<Map<String, dynamic>>> getQuestionsByDimension() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var question in questions) {
      String dimension = question['dimension'];
      if (!grouped.containsKey(dimension)) {
        grouped[dimension] = [];
      }
      grouped[dimension]!.add(question);
    }

    return grouped;
  }

  static int getTotalQuestions() => questions.length;

  static List<String> getDimensions() => ['EI', 'SN', 'TF', 'JP'];
}
