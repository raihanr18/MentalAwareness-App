// Maintain Page
import 'package:healman_mental_awareness/pages/home.dart';

// Pages
import 'package:healman_mental_awareness/firebase_options.dart';
import 'package:healman_mental_awareness/pages/index.dart';
import 'package:healman_mental_awareness/pages/splash_screen.dart';

// Provider (Backend)
import 'package:healman_mental_awareness/provider/internet_provider.dart';
import 'package:healman_mental_awareness/provider/sign_in_provider.dart';

// Package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),

        // For testing only
        routes: {
          // '/':(context) => const HomePage(),
          // '/':(context) => const Index(),
        },
      ),
    );
  }
}
