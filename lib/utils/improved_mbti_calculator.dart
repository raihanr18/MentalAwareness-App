class ImprovedMBTICalculator {
  static const Map<String, String> _dimensionNames = {
    'EI': 'Extraversion vs Introversion',
    'SN': 'Sensing vs Intuition',
    'TF': 'Thinking vs Feeling',
    'JP': 'Judging vs Perceiving'
  };

  static const Map<String, List<String>> _cognitiveFunctions = {
    'ENFJ': ['Fe', 'Ni', 'Se', 'Ti'],
    'INFJ': ['Ni', 'Fe', 'Ti', 'Se'],
    'ENFP': ['Ne', 'Fi', 'Te', 'Si'],
    'INFP': ['Fi', 'Ne', 'Si', 'Te'],
    'ENTJ': ['Te', 'Ni', 'Se', 'Fi'],
    'INTJ': ['Ni', 'Te', 'Fi', 'Se'],
    'ENTP': ['Ne', 'Ti', 'Fe', 'Si'],
    'INTP': ['Ti', 'Ne', 'Si', 'Fe'],
    'ESFJ': ['Fe', 'Si', 'Ne', 'Ti'],
    'ISFJ': ['Si', 'Fe', 'Ti', 'Ne'],
    'ESFP': ['Se', 'Fi', 'Te', 'Ni'],
    'ISFP': ['Fi', 'Se', 'Ni', 'Te'],
    'ESTJ': ['Te', 'Si', 'Ne', 'Fi'],
    'ISTJ': ['Si', 'Te', 'Fi', 'Ne'],
    'ESTP': ['Se', 'Ti', 'Fe', 'Ni'],
    'ISTP': ['Ti', 'Se', 'Ni', 'Fe'],
  };

  static const Map<String, String> _functionDescriptions = {
    'Fe':
        'Extraverted Feeling - Harmoni eksternal dan kesejahteraan orang lain',
    'Fi': 'Introverted Feeling - Nilai-nilai personal dan autentisitas',
    'Te': 'Extraverted Thinking - Efisiensi dan organisasi eksternal',
    'Ti': 'Introverted Thinking - Logika internal dan analisis mendalam',
    'Ne': 'Extraverted Intuition - Kemungkinan dan koneksi eksternal',
    'Ni': 'Introverted Intuition - Visi dan insight internal',
    'Se': 'Extraverted Sensing - Pengalaman dan stimulasi eksternal',
    'Si': 'Introverted Sensing - Detail dan pengalaman masa lalu',
  };

  static Map<String, dynamic> calculateMBTI(
      List<Map<String, dynamic>> userAnswers) {
    Map<String, List<int>> dimensionScores = {
      'EI': [],
      'SN': [],
      'TF': [],
      'JP': []
    };

    Map<String, int> rawScores = {
      'E': 0,
      'I': 0,
      'S': 0,
      'N': 0,
      'T': 0,
      'F': 0,
      'J': 0,
      'P': 0
    };

    // Process each answer
    for (var answer in userAnswers) {
      String dimension = answer['dimension'];
      String selectedType = answer['selectedType'];
      int score = answer['score'];
      bool isReverse = answer['reverse'] ?? false;

      // Handle reverse scoring
      if (isReverse) {
        score = 6 - score; // Invert 1->5, 2->4, 3->3, 4->2, 5->1
        // Also invert the type for reverse questions
        if (selectedType == 'E') {
          selectedType = 'I';
        } else if (selectedType == 'I') {
          selectedType = 'E';
        } else if (selectedType == 'S') {
          selectedType = 'N';
        } else if (selectedType == 'N') {
          selectedType = 'S';
        } else if (selectedType == 'T') {
          selectedType = 'F';
        } else if (selectedType == 'F') {
          selectedType = 'T';
        } else if (selectedType == 'J') {
          selectedType = 'P';
        } else if (selectedType == 'P') {
          selectedType = 'J';
        }
      }

      // Add to dimension scores for consistency checking
      dimensionScores[dimension]!.add(score);

      // Add to raw scores
      if (selectedType != 'neutral') {
        rawScores[selectedType] = (rawScores[selectedType] ?? 0) + score;
      }
    }

    // Calculate percentages and preferences

    // E/I calculation
    int totalEI = rawScores['E']! + rawScores['I']!;
    double ePercentage = totalEI > 0 ? (rawScores['E']! / totalEI) * 100 : 50.0;
    double iPercentage = 100 - ePercentage;

    // S/N calculation
    int totalSN = rawScores['S']! + rawScores['N']!;
    double sPercentage = totalSN > 0 ? (rawScores['S']! / totalSN) * 100 : 50.0;
    double nPercentage = 100 - sPercentage;

    // T/F calculation
    int totalTF = rawScores['T']! + rawScores['F']!;
    double tPercentage = totalTF > 0 ? (rawScores['T']! / totalTF) * 100 : 50.0;
    double fPercentage = 100 - tPercentage;

    // J/P calculation
    int totalJP = rawScores['J']! + rawScores['P']!;
    double jPercentage = totalJP > 0 ? (rawScores['J']! / totalJP) * 100 : 50.0;
    double pPercentage = 100 - jPercentage;

    // Determine preferences
    String eiType = ePercentage > iPercentage ? 'E' : 'I';
    String snType = sPercentage > nPercentage ? 'S' : 'N';
    String tfType = tPercentage > fPercentage ? 'T' : 'F';
    String jpType = jPercentage > pPercentage ? 'J' : 'P';

    String mbtiType = eiType + snType + tfType + jpType;

    // Calculate preference strengths
    double eiStrength =
        (ePercentage > iPercentage ? ePercentage : iPercentage) - 50;
    double snStrength =
        (sPercentage > nPercentage ? sPercentage : nPercentage) - 50;
    double tfStrength =
        (tPercentage > fPercentage ? tPercentage : fPercentage) - 50;
    double jpStrength =
        (jPercentage > pPercentage ? jPercentage : pPercentage) - 50;

    // Check consistency
    Map<String, double> consistencyScores =
        _calculateConsistency(dimensionScores);

    // Calculate overall confidence
    double overallConfidence = _calculateConfidence(
        [eiStrength, snStrength, tfStrength, jpStrength], consistencyScores);

    return {
      'personalityType': mbtiType,
      'mbtiType': mbtiType,
      'dimensions': {
        'EI': {
          'percentage': eiType == 'E' ? ePercentage : iPercentage,
          'dominantType': eiType,
          'strength': _getStrengthLabel(eiStrength),
        },
        'SN': {
          'percentage': snType == 'S' ? sPercentage : nPercentage,
          'dominantType': snType,
          'strength': _getStrengthLabel(snStrength),
        },
        'TF': {
          'percentage': tfType == 'T' ? tPercentage : fPercentage,
          'dominantType': tfType,
          'strength': _getStrengthLabel(tfStrength),
        },
        'JP': {
          'percentage': jpType == 'J' ? jPercentage : pPercentage,
          'dominantType': jpType,
          'strength': _getStrengthLabel(jpStrength),
        },
      },
      'cognitiveFunctions': {
        'dominant': _cognitiveFunctions[mbtiType]?[0] ?? 'Unknown',
        'auxiliary': _cognitiveFunctions[mbtiType]?[1] ?? 'Unknown',
        'tertiary': _cognitiveFunctions[mbtiType]?[2] ?? 'Unknown',
        'inferior': _cognitiveFunctions[mbtiType]?[3] ?? 'Unknown',
      },
      'percentages': {
        'E': ePercentage.round(),
        'I': iPercentage.round(),
        'S': sPercentage.round(),
        'N': nPercentage.round(),
        'T': tPercentage.round(),
        'F': fPercentage.round(),
        'J': jPercentage.round(),
        'P': pPercentage.round(),
      },
      'preferenceStrengths': {
        'EI': _getStrengthLabel(eiStrength),
        'SN': _getStrengthLabel(snStrength),
        'TF': _getStrengthLabel(tfStrength),
        'JP': _getStrengthLabel(jpStrength),
      },
      'strengthValues': {
        'EI': eiStrength.round(),
        'SN': snStrength.round(),
        'TF': tfStrength.round(),
        'JP': jpStrength.round(),
      },
      'consistencyScores': consistencyScores,
      'consistencyScore': consistencyScores.values.reduce((a, b) => a + b) /
          consistencyScores.length,
      'confidenceLevel': overallConfidence / 100,
      'overallConfidence': overallConfidence,
      'confidenceLabel': _getConfidenceLabel(overallConfidence),
      'rawScores': rawScores,
    };
  }

  static Map<String, double> _calculateConsistency(
      Map<String, List<int>> dimensionScores) {
    Map<String, double> consistency = {};

    for (String dimension in dimensionScores.keys) {
      List<int> scores = dimensionScores[dimension]!;
      if (scores.isEmpty) {
        consistency[dimension] = 0.0;
        continue;
      }

      // Calculate standard deviation
      double mean = scores.reduce((a, b) => a + b) / scores.length;
      double variance = scores
              .map((score) => (score - mean) * (score - mean))
              .reduce((a, b) => a + b) /
          scores.length;
      double stdDev = variance > 0 ? (variance).sqrt() : 0.0;

      // Convert to consistency score (lower stdDev = higher consistency)
      double consistencyScore = 100 - (stdDev / 2 * 100).clamp(0, 100);
      consistency[dimension] = consistencyScore;
    }

    return consistency;
  }

  static double _calculateConfidence(
      List<double> strengths, Map<String, double> consistencyScores) {
    // Average preference strength
    double avgStrength = strengths.reduce((a, b) => a + b) / strengths.length;

    // Average consistency
    double avgConsistency = consistencyScores.values.reduce((a, b) => a + b) /
        consistencyScores.length;

    // Combined confidence (weighted: 60% strength, 40% consistency)
    double confidence = (avgStrength * 0.6) + (avgConsistency * 0.4);

    return confidence.clamp(0, 100);
  }

  static String _getStrengthLabel(double strength) {
    if (strength < 10) return 'Slight';
    if (strength < 20) return 'Moderate';
    if (strength < 30) return 'Clear';
    return 'Very Clear';
  }

  static String _getConfidenceLabel(double confidence) {
    if (confidence < 60) return 'Low';
    if (confidence < 75) return 'Moderate';
    if (confidence < 90) return 'High';
    return 'Very High';
  }

  static Map<String, dynamic> getTypeDescription(String mbtiType) {
    const Map<String, Map<String, dynamic>> descriptions = {
      'ENFJ': {
        'title': 'The Protagonist',
        'shortDesc':
            'Karismatik dan inspiratif, mampu memotivasi orang lain untuk mencapai tujuan bersama.',
        'description':
            'ENFJ adalah pemimpin alami yang peduli terhadap kesejahteraan orang lain. Mereka memiliki kemampuan luar biasa untuk memahami emosi dan motivasi orang lain, serta mampu menginspirasi dan memotivasi tim untuk mencapai tujuan bersama. ENFJ cenderung idealis dan selalu berusaha membuat dunia menjadi tempat yang lebih baik.',
        'strengths': [
          'Empati tinggi',
          'Kemampuan komunikasi',
          'Visi yang kuat',
          'Inspiratif',
          'Mampu memotivasi'
        ],
        'weaknesses': [
          'Terlalu fokus pada orang lain',
          'Sensitif terhadap kritik',
          'Cenderung perfeksionis',
          'Mudah terbebani'
        ],
        'careers': [
          'Konselor',
          'Guru',
          'Pelatih',
          'HR Manager',
          'Psikolog',
          'Pemimpin Non-profit'
        ]
      },
      'INFJ': {
        'title': 'The Advocate',
        'shortDesc':
            'Kreatif dan berwawasan, didorong oleh nilai-nilai personal yang kuat.',
        'description':
            'INFJ adalah kepribadian yang langka dan kompleks. Mereka memiliki intuisi yang kuat tentang orang dan situasi, serta didorong oleh nilai-nilai personal yang mendalam. INFJ cenderung perfeksionis dan memiliki visi yang jelas tentang bagaimana mereka ingin membuat perbedaan di dunia.',
        'strengths': [
          'Intuisi kuat',
          'Empati mendalam',
          'Visi jangka panjang',
          'Kreatif',
          'Independen'
        ],
        'weaknesses': [
          'Perfeksionis',
          'Sensitif',
          'Mudah terbebani',
          'Sulit mengungkapkan perasaan'
        ],
        'careers': [
          'Penulis',
          'Konselor',
          'Psikolog',
          'Aktivis',
          'Seniman',
          'Researcher'
        ]
      },
      // Add more types...
    };

    return descriptions[mbtiType] ??
        {
          'title': 'Unknown Type',
          'shortDesc': 'Deskripsi tidak tersedia.',
          'description':
              'Deskripsi lengkap untuk tipe ini sedang dikembangkan.',
          'strengths': ['Dalam pengembangan'],
          'weaknesses': ['Dalam pengembangan'],
          'careers': ['Dalam pengembangan']
        };
  }

  static String getCognitiveFunctionDescription(String function) {
    return _functionDescriptions[function] ?? 'Deskripsi tidak tersedia';
  }

  static List<String> getDevelopmentSuggestions(
      String mbtiType, Map<String, double> consistencyScores) {
    List<String> suggestions = [];

    // Base suggestions for each type
    const Map<String, List<String>> typeSuggestions = {
      'ENFJ': [
        'Luangkan waktu untuk diri sendiri secara rutin',
        'Belajar menerima kritik konstruktif',
        'Kembangkan batasan yang sehat dalam hubungan',
        'Praktikkan teknik manajemen stres'
      ],
      'INFJ': [
        'Kembangkan keterampilan komunikasi asertif',
        'Belajar untuk tidak terlalu perfeksionis',
        'Bangun jaringan sosial yang mendukung',
        'Praktikkan mindfulness dan meditasi'
      ],
      // Add more...
    };

    suggestions.addAll(typeSuggestions[mbtiType] ?? []);

    // Add consistency-based suggestions
    consistencyScores.forEach((dimension, score) {
      if (score < 70) {
        suggestions.add(
            'Eksplorasi lebih dalam preferensi ${_dimensionNames[dimension]}');
      }
    });

    return suggestions;
  }
}

extension DoubleExtension on double {
  double sqrt() {
    if (this < 0) return double.nan;
    if (this == 0) return 0;

    double x = this;
    double prev = 0;

    while (x != prev) {
      prev = x;
      x = (x + this / x) / 2;
    }

    return x;
  }
}
