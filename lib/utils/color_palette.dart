import 'package:flutter/material.dart';

/// **Palet Warna: Healman App**
///
/// Color palette yang dirancang khusus untuk aplikasi kesehatan mental
/// dengan fokus pada ketenangan, kepercayaan, dan pertumbuhan
class HealmanColors {
  HealmanColors._();

  /// **1. Warna Primer**

  /// **Hijau Pertumbuhan (Growth Green)**
  /// Melambangkan alam, pertumbuhan, penyembuhan, dan keseimbangan
  /// Digunakan untuk progress bar, CTA utama, ikon relaksasi
  static const Color growthGreen = Color(0xFF48B8A8);

  /// **Biru Ketenangan (Serenity Blue)**
  /// Melambangkan kepercayaan, stabilitas, dan ketenangan
  /// Digunakan untuk header, footer, link, navigasi utama
  static const Color serenityBlue = Color(0xFF5A96E3);

  /// **2. Warna Aksen**

  /// **Pesona Harapan (Hopeful Peach)**
  /// Memberikan kehangatan, optimisme, dan kenyamanan
  /// Digunakan untuk notifikasi, badges, highlight
  static const Color hopefulPeach = Color(0xFFFFCBA4);

  /// **3. Warna Netral**

  /// **Putih Gading (Ivory White)**
  /// Latar belakang yang lembut dan mudah di mata
  /// Digunakan untuk background utama aplikasi
  static const Color ivoryWhite = Color(0xFFF8F8F4);

  /// **Abu-abu Lembut (Soft Gray)**
  /// Memberikan kesan modern dan rapi
  /// Digunakan untuk cards, dividers, text fields
  static const Color softGray = Color(0xFFE0E0E0);

  /// **Arang Teks (Text Charcoal)**
  /// Mengurangi ketegangan mata saat membaca
  /// Digunakan untuk teks utama, judul, label
  static const Color textCharcoal = Color(0xFF424242);

  /// **Gradient Combinations**

  /// Gradient untuk background utama
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [growthGreen, serenityBlue],
  );

  /// Gradient untuk card highlights
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [serenityBlue, growthGreen],
  );

  /// Gradient untuk accent elements
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [hopefulPeach, growthGreen],
  );

  /// **Theme Data**

  /// Light theme untuk aplikasi
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // Color Scheme
        colorScheme: const ColorScheme.light(
          primary: growthGreen,
          onPrimary: Colors.white,
          secondary: serenityBlue,
          onSecondary: Colors.white,
          tertiary: hopefulPeach,
          onTertiary: textCharcoal,
          surface: ivoryWhite,
          onSurface: textCharcoal,
          error: Color(0xFFE57373),
          onError: Colors.white,
        ),

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: serenityBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Bottom Navigation Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: growthGreen,
          unselectedItemColor: softGray,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // Card Theme
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 4,
          shadowColor: Color.fromRGBO(66, 66, 66, 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),

        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: growthGreen,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: serenityBlue,
            side: const BorderSide(color: serenityBlue, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: serenityBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: softGray.withValues(alpha: 0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: growthGreen, width: 2),
          ),
          labelStyle: const TextStyle(color: textCharcoal),
          hintStyle: TextStyle(color: textCharcoal.withValues(alpha: 0.6)),
        ),

        // Progress Indicator Theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: growthGreen,
          linearTrackColor: softGray,
        ),

        // Scaffold Theme
        scaffoldBackgroundColor: ivoryWhite,

        // Text Theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: textCharcoal,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            color: textCharcoal,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle(
            color: textCharcoal,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: textCharcoal,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: textCharcoal,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            color: textCharcoal,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: textCharcoal,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            color: textCharcoal,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: textCharcoal,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: textCharcoal,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            color: textCharcoal,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            color: textCharcoal,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
