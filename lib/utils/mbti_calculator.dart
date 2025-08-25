enum MBTIDimension {
  extroversion,
  introversion,
  sensing,
  intuition,
  thinking,
  feeling,
  judging,
  perceiving,
}

class MBTICalculator {
  static Map<MBTIDimension, int> calculateScores(List<dynamic> answers) {
    Map<MBTIDimension, int> scores = {
      MBTIDimension.extroversion: 0,
      MBTIDimension.introversion: 0,
      MBTIDimension.sensing: 0,
      MBTIDimension.intuition: 0,
      MBTIDimension.thinking: 0,
      MBTIDimension.feeling: 0,
      MBTIDimension.judging: 0,
      MBTIDimension.perceiving: 0,
    };

    for (var answer in answers) {
      // Default score adalah 1, tapi bisa diubah jika ada score dalam answer
      int scoreValue = 1;

      // Jika answer adalah Map (dari quiz baru), ambil score-nya
      if (answer is Map && answer.containsKey('score')) {
        scoreValue = answer['score'] ?? 1;
      }

      AnswerType type;
      if (answer is Map && answer.containsKey('type')) {
        // Konversi dari Map ke AnswerType
        switch (answer['value']) {
          case 'E':
            type = AnswerType.extrovert;
            break;
          case 'I':
            type = AnswerType.introvert;
            break;
          case 'S':
            type = AnswerType.sensing;
            break;
          case 'N':
            type = AnswerType.intuition;
            break;
          case 'T':
            type = AnswerType.thinking;
            break;
          case 'F':
            type = AnswerType.feeling;
            break;
          case 'J':
            type = AnswerType.judging;
            break;
          case 'P':
            type = AnswerType.perceiving;
            break;
          default:
            type = AnswerType.extrovert;
        }
      } else {
        // Fallback untuk Option objects
        type = answer.type;
      }

      switch (type) {
        case AnswerType.extrovert:
          scores[MBTIDimension.extroversion] =
              scores[MBTIDimension.extroversion]! + scoreValue;
          break;
        case AnswerType.introvert:
          scores[MBTIDimension.introversion] =
              scores[MBTIDimension.introversion]! + scoreValue;
          break;
        case AnswerType.sensing:
          scores[MBTIDimension.sensing] =
              scores[MBTIDimension.sensing]! + scoreValue;
          break;
        case AnswerType.intuition:
          scores[MBTIDimension.intuition] =
              scores[MBTIDimension.intuition]! + scoreValue;
          break;
        case AnswerType.thinking:
          scores[MBTIDimension.thinking] =
              scores[MBTIDimension.thinking]! + scoreValue;
          break;
        case AnswerType.feeling:
          scores[MBTIDimension.feeling] =
              scores[MBTIDimension.feeling]! + scoreValue;
          break;
        case AnswerType.judging:
          scores[MBTIDimension.judging] =
              scores[MBTIDimension.judging]! + scoreValue;
          break;
        case AnswerType.perceiving:
          scores[MBTIDimension.perceiving] =
              scores[MBTIDimension.perceiving]! + scoreValue;
          break;
      }
    }

    return scores;
  }

  static String calculateMBTIType(Map<MBTIDimension, int> scores) {
    String result = '';

    // E vs I
    result += scores[MBTIDimension.extroversion]! >
            scores[MBTIDimension.introversion]!
        ? 'E'
        : 'I';

    // S vs N
    result += scores[MBTIDimension.sensing]! > scores[MBTIDimension.intuition]!
        ? 'S'
        : 'N';

    // T vs F
    result += scores[MBTIDimension.thinking]! > scores[MBTIDimension.feeling]!
        ? 'T'
        : 'F';

    // J vs P
    result += scores[MBTIDimension.judging]! > scores[MBTIDimension.perceiving]!
        ? 'J'
        : 'P';

    return result;
  }

  static Map<String, int> getPercentages(Map<MBTIDimension, int> scores) {
    int totalEI = scores[MBTIDimension.extroversion]! +
        scores[MBTIDimension.introversion]!;
    int totalSN =
        scores[MBTIDimension.sensing]! + scores[MBTIDimension.intuition]!;
    int totalTF =
        scores[MBTIDimension.thinking]! + scores[MBTIDimension.feeling]!;
    int totalJP =
        scores[MBTIDimension.judging]! + scores[MBTIDimension.perceiving]!;

    return {
      'E': totalEI > 0
          ? ((scores[MBTIDimension.extroversion]! / totalEI) * 100).round()
          : 0,
      'I': totalEI > 0
          ? ((scores[MBTIDimension.introversion]! / totalEI) * 100).round()
          : 0,
      'S': totalSN > 0
          ? ((scores[MBTIDimension.sensing]! / totalSN) * 100).round()
          : 0,
      'N': totalSN > 0
          ? ((scores[MBTIDimension.intuition]! / totalSN) * 100).round()
          : 0,
      'T': totalTF > 0
          ? ((scores[MBTIDimension.thinking]! / totalTF) * 100).round()
          : 0,
      'F': totalTF > 0
          ? ((scores[MBTIDimension.feeling]! / totalTF) * 100).round()
          : 0,
      'J': totalJP > 0
          ? ((scores[MBTIDimension.judging]! / totalJP) * 100).round()
          : 0,
      'P': totalJP > 0
          ? ((scores[MBTIDimension.perceiving]! / totalJP) * 100).round()
          : 0,
    };
  }
}

class MBTITypeInfo {
  final String type;
  final String title;
  final String nickname;
  final String description;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> careers;
  final String color;

  MBTITypeInfo({
    required this.type,
    required this.title,
    required this.nickname,
    required this.description,
    required this.strengths,
    required this.weaknesses,
    required this.careers,
    required this.color,
  });

  static MBTITypeInfo getTypeInfo(String type) {
    final typeData = _mbtiTypes[type];
    if (typeData == null) {
      return MBTITypeInfo(
        type: type,
        title: 'Unknown Type',
        nickname: 'Unknown',
        description: 'Tipe kepribadian tidak dikenal.',
        strengths: [],
        weaknesses: [],
        careers: [],
        color: '#6B7280',
      );
    }
    return typeData;
  }

  static final Map<String, MBTITypeInfo> _mbtiTypes = {
    'INTJ': MBTITypeInfo(
      type: 'INTJ',
      title: 'The Architect',
      nickname: 'Arsitek',
      description:
          'Pemikir strategis dengan rencana untuk segala hal. Mereka adalah individu yang sangat mandiri, kreatif, dan berorientasi pada tujuan.',
      strengths: [
        'Pemikiran strategis yang kuat',
        'Mandiri dan percaya diri',
        'Kreatif dan inovatif',
        'Fokus pada tujuan jangka panjang',
        'Analitis dan objektif'
      ],
      weaknesses: [
        'Dapat terlihat arogan',
        'Terlalu kritis terhadap orang lain',
        'Kesulitan mengekspresikan emosi',
        'Tidak sabar dengan inefficiency',
        'Cenderung perfeksionis'
      ],
      careers: [
        'Arsitek',
        'Insinyur',
        'Scientist',
        'Programmer',
        'Konsultan Strategi',
        'Entrepreneur',
        'Lawyer'
      ],
      color: '#6366F1',
    ),
    'INTP': MBTITypeInfo(
      type: 'INTP',
      title: 'The Thinker',
      nickname: 'Pemikir',
      description:
          'Filosof yang fleksibel dan inovatif. Mereka sangat tertarik pada teori dan mencari penjelasan logis untuk segala hal.',
      strengths: [
        'Analitis dan objektif',
        'Kreatif dalam pemecahan masalah',
        'Fleksibel dan adaptif',
        'Honest dan straightforward',
        'Enthusiastic tentang ide-ide'
      ],
      weaknesses: [
        'Insensitive terhadap orang lain',
        'Absent-minded',
        'Condescending',
        'Loath rules dan guidelines',
        'Second-guess themselves'
      ],
      careers: [
        'Programmer',
        'Researcher',
        'Professor',
        'Writer',
        'Mathematician',
        'Scientist',
        'Forensic Analyst'
      ],
      color: '#8B5CF6',
    ),
    'ENTJ': MBTITypeInfo(
      type: 'ENTJ',
      title: 'The Commander',
      nickname: 'Komandan',
      description:
          'Pemimpin yang berani, imajinatif, dan berkemauan kuat. Mereka selalu menemukan cara atau membuat jalan.',
      strengths: [
        'Efficient',
        'Energetic',
        'Self-confident',
        'Strong-willed',
        'Strategic thinkers'
      ],
      weaknesses: [
        'Stubborn dan dominant',
        'Intolerant',
        'Impatient',
        'Arrogant',
        'Poor handling of emotions'
      ],
      careers: [
        'CEO',
        'Entrepreneur',
        'Judge',
        'Lawyer',
        'Manager',
        'Investment Banker',
        'Professor'
      ],
      color: '#DC2626',
    ),
    'ENTP': MBTITypeInfo(
      type: 'ENTP',
      title: 'The Debater',
      nickname: 'Pendebat',
      description:
          'Pemikir yang cerdas dan ingin tahu, yang tidak bisa menolak tantangan intelektual.',
      strengths: [
        'Knowledgeable',
        'Quick thinkers',
        'Original',
        'Excellent brainstormers',
        'Charismatic'
      ],
      weaknesses: [
        'Very argumentative',
        'Insensitive',
        'Intolerant',
        'Can find it difficult to focus',
        'Dislike practical matters'
      ],
      careers: [
        'Entrepreneur',
        'Lawyer',
        'Scientist',
        'Inventor',
        'Marketing Specialist',
        'Journalist',
        'Consultant'
      ],
      color: '#F59E0B',
    ),
    'INFJ': MBTITypeInfo(
      type: 'INFJ',
      title: 'The Advocate',
      nickname: 'Advokat',
      description:
          'Idealis yang kreatif dan insightful, terinspirasi dan pantang menyerah - selalu bekerja untuk kebaikan.',
      strengths: [
        'Creative',
        'Insightful',
        'Inspiring dan convincing',
        'Decisive',
        'Determined dan passionate'
      ],
      weaknesses: [
        'Sensitive',
        'Extremely private',
        'Perfectionist',
        'Always need to have a cause',
        'Can burn out easily'
      ],
      careers: [
        'Counselor',
        'Writer',
        'Doctor',
        'Teacher',
        'Photographer',
        'Social Worker',
        'Psychologist'
      ],
      color: '#10B981',
    ),
    'INFP': MBTITypeInfo(
      type: 'INFP',
      title: 'The Mediator',
      nickname: 'Mediator',
      description:
          'Orang yang puitis, baik hati, dan altruistik, selalu ingin membantu tujuan yang baik.',
      strengths: [
        'Idealistic',
        'Loyal dan devoted',
        'Sensitive to feelings',
        'Caring dan interested in others',
        'Works well alone'
      ],
      weaknesses: [
        'Overly idealistic',
        'Overly sensitive',
        'Impractical',
        'Dislike dealing with data',
        'Take things personally'
      ],
      careers: [
        'Writer',
        'Artist',
        'Counselor',
        'Psychologist',
        'Teacher',
        'Social Worker',
        'Librarian'
      ],
      color: '#06B6D4',
    ),
    'ENFJ': MBTITypeInfo(
      type: 'ENFJ',
      title: 'The Protagonist',
      nickname: 'Protagonis',
      description:
          'Pemimpin yang karismatik dan menginspirasi, mampu mempesona pendengar mereka.',
      strengths: [
        'Tolerant',
        'Reliable',
        'Charismatic',
        'Altruistic',
        'Natural leaders'
      ],
      weaknesses: [
        'Overly idealistic',
        'Too sensitive',
        'Fluctuating self-esteem',
        'Struggle to make tough decisions'
      ],
      careers: [
        'Teacher',
        'Counselor',
        'Coach',
        'Politician',
        'Social Worker',
        'Human Resources',
        'Sales Representative'
      ],
      color: '#EF4444',
    ),
    'ENFP': MBTITypeInfo(
      type: 'ENFP',
      title: 'The Campaigner',
      nickname: 'Aktivis',
      description:
          'Semangat yang antusias, kreatif, dan sosiabel - selalu dapat menemukan alasan untuk tersenyum.',
      strengths: [
        'Enthusiastic',
        'Creative',
        'Sociable',
        'Energetic',
        'Positive'
      ],
      weaknesses: [
        'Poor practical skills',
        'Find it difficult to focus',
        'Overthink things',
        'Get stressed easily',
        'Highly emotional'
      ],
      careers: [
        'Journalist',
        'Actor',
        'Teacher',
        'Counselor',
        'Musician',
        'Social Worker',
        'Entrepreneur'
      ],
      color: '#F97316',
    ),
    'ISTJ': MBTITypeInfo(
      type: 'ISTJ',
      title: 'The Logistician',
      nickname: 'Logistik',
      description:
          'Fakta praktis dan dapat diandalkan, tidak bisa dibujuk untuk mengabaikan tanggung jawab mereka.',
      strengths: [
        'Honest dan direct',
        'Strong-willed dan dutiful',
        'Very responsible',
        'Calm dan practical',
        'Create dan enforce order'
      ],
      weaknesses: [
        'Stubborn',
        'Insensitive',
        'Always by the book',
        'Judgmental',
        'Often unreasonably blame themselves'
      ],
      careers: [
        'Accountant',
        'Manager',
        'Lawyer',
        'Military Officer',
        'Doctor',
        'Dentist',
        'Engineer'
      ],
      color: '#4F46E5',
    ),
    'ISFJ': MBTITypeInfo(
      type: 'ISFJ',
      title: 'The Protector',
      nickname: 'Pelindung',
      description:
          'Pelindung yang hangat dan berdedikasi, selalu siap mempertahankan orang yang dicintai.',
      strengths: [
        'Supportive',
        'Reliable dan patient',
        'Imaginative dan observant',
        'Enthusiastic',
        'Loyal dan hard-working'
      ],
      weaknesses: [
        'Humble dan shy',
        'Take things too personally',
        'Repress their feelings',
        'Overload themselves',
        'Reluctant to change'
      ],
      careers: [
        'Nurse',
        'Teacher',
        'Social Worker',
        'Counselor',
        'Administrator',
        'Interior Designer',
        'Bookkeeper'
      ],
      color: '#059669',
    ),
    'ESTJ': MBTITypeInfo(
      type: 'ESTJ',
      title: 'The Executive',
      nickname: 'Eksekutif',
      description:
          'Administrator yang sangat baik, tak tertandingi dalam mengelola hal-hal atau orang.',
      strengths: [
        'Dedicated',
        'Strong-willed',
        'Direct dan honest',
        'Loyal, patient, dan reliable',
        'Enjoy creating order'
      ],
      weaknesses: [
        'Inflexible dan stubborn',
        'Uncomfortable with unconventional situations',
        'Judgmental',
        'Too focused on social status',
        'Difficult to relax'
      ],
      careers: [
        'Manager',
        'Judge',
        'Teacher',
        'Military Officer',
        'Police Officer',
        'Financial Officer',
        'Administrator'
      ],
      color: '#DC2626',
    ),
    'ESFJ': MBTITypeInfo(
      type: 'ESFJ',
      title: 'The Consul',
      nickname: 'Konsul',
      description:
          'Orang yang sangat peduli, sosial, dan populer, selalu ingin membantu.',
      strengths: [
        'Strong practical skills',
        'Strong sense of duty',
        'Very loyal',
        'Sensitive dan warm',
        'Good at connecting with others'
      ],
      weaknesses: [
        'Worried about their social status',
        'Inflexible',
        'Reluctant to innovate',
        'Vulnerable to criticism',
        'Often too needy'
      ],
      careers: [
        'Social Worker',
        'Teacher',
        'Nurse',
        'Coach',
        'Office Manager',
        'Event Coordinator',
        'Receptionist'
      ],
      color: '#10B981',
    ),
    'ISTP': MBTITypeInfo(
      type: 'ISTP',
      title: 'The Virtuoso',
      nickname: 'Virtuoso',
      description:
          'Eksperimenter yang berani dan praktis, master dari semua jenis alat.',
      strengths: [
        'Optimistic dan energetic',
        'Creative dan practical',
        'Spontaneous dan rational',
        'Know how to prioritize',
        'Great in a crisis'
      ],
      weaknesses: [
        'Stubborn',
        'Insensitive',
        'Private dan reserved',
        'Easily bored',
        'Dislike commitment'
      ],
      careers: [
        'Mechanic',
        'Engineer',
        'Pilot',
        'Paramedic',
        'Data Analyst',
        'Software Developer',
        'Photographer'
      ],
      color: '#7C3AED',
    ),
    'ISFP': MBTITypeInfo(
      type: 'ISFP',
      title: 'The Adventurer',
      nickname: 'Petualang',
      description:
          'Seniman yang fleksibel dan menawan, selalu siap untuk mengeksplorasi kemungkinan baru.',
      strengths: [
        'Charming',
        'Sensitive to feelings',
        'Imaginative',
        'Passionate',
        'Curious'
      ],
      weaknesses: [
        'Fiercely independent',
        'Unpredictable',
        'Easily stressed',
        'Overly competitive',
        'Fluctuating self-esteem'
      ],
      careers: [
        'Artist',
        'Musician',
        'Designer',
        'Writer',
        'Psychologist',
        'Social Worker',
        'Teacher'
      ],
      color: '#06B6D4',
    ),
    'ESTP': MBTITypeInfo(
      type: 'ESTP',
      title: 'The Entrepreneur',
      nickname: 'Entrepreneur',
      description:
          'Orang yang cerdas, energik, dan sangat perceptif, benar-benar menikmati hidup di ujung.',
      strengths: [
        'Bold',
        'Rational dan practical',
        'Original',
        'Perceptive',
        'Direct'
      ],
      weaknesses: [
        'Insensitive',
        'Impatient',
        'Risk-prone',
        'Unstructured',
        'May miss the bigger picture'
      ],
      careers: [
        'Sales Representative',
        'Entrepreneur',
        'Paramedic',
        'Police Officer',
        'Actor',
        'Real Estate Agent',
        'Marketing Specialist'
      ],
      color: '#F59E0B',
    ),
    'ESFP': MBTITypeInfo(
      type: 'ESFP',
      title: 'The Entertainer',
      nickname: 'Penghibur',
      description:
          'Orang yang spontan, energik, dan antusias - hidup tidak pernah membosankan di sekitar mereka.',
      strengths: [
        'Bold',
        'Original',
        'Aesthetics dan showmanship',
        'Practical',
        'Observant'
      ],
      weaknesses: [
        'Sensitive',
        'Conflict-averse',
        'Easily bored',
        'Poor long-term planners',
        'Unfocused'
      ],
      careers: [
        'Actor',
        'Artist',
        'Teacher',
        'Social Worker',
        'Event Planner',
        'Fashion Designer',
        'Musician'
      ],
      color: '#EF4444',
    ),
  };
}

// Import this for the AnswerType enum
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
