// Maintain Page
import 'package:healman_mental_awareness/controller/internet_controller.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';

// Pages
import 'package:healman_mental_awareness/firebase_options.dart';
import 'package:healman_mental_awareness/pages/splash_screen.dart';

// Package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/view_article.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Healman",
        home: SplashScreen(),
        // home: ResultPage(),
        // home: QuizMbti(),
      ),
    );
  }
}
