// Maintain Page
import 'package:healman_mental_awareness/controller/internet_controller.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/controller/mood_controller.dart';
import 'package:healman_mental_awareness/controller/mental_health_controller.dart';

// Pages
import 'package:healman_mental_awareness/firebase_options.dart';
import 'package:healman_mental_awareness/pages/splash_screen.dart';

// Utils
import 'package:healman_mental_awareness/utils/log_filter.dart';
import 'package:healman_mental_awareness/utils/color_palette.dart';

// Package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup log filter to reduce spam warnings
  LogFilter.setupLogFilter();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => LoginController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => MoodController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => MentalHealthController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Healman Mental Health",
        theme: HealmanColors.lightTheme,
        home: const SplashScreen(),
        // home: ResultPage(),
        // home: QuizMbti(),
      ),
    );
  }
}
