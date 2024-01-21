import 'dart:async';

import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/pages/login.dart';
import 'package:healman_mental_awareness/provider/sign_in_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Init
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();

    // Timer
    Timer(const Duration(seconds: 3), () {
      sp.isSignedIn == false
          ? nextPage(context, const Login())
          : nextPage(context, const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                'Memulai Aplikasi',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
