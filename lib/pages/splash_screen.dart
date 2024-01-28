import 'dart:async';
import 'dart:math';

import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/pages/login.dart';
import 'package:healman_mental_awareness/provider/sign_in_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  dynamic height, width;

  List<String> videoSplash = [
    'assets/video/splash_1.mp4',
    'assets/video/splash_2.mp4',
    'assets/video/splash_3.mp4'
  ];

  String getRandomVideo(List<String> videoSplash) {
    final random = Random();
    return videoSplash[random.nextInt(videoSplash.length)];
  }

  //Init
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();

    // Timer
    Timer(const Duration(seconds: 4), () {
      sp.isSignedIn == false
          ? nextPage(context, const Login())
          : nextPage(context, const HomePage());
    });

    // Splash Video
    String randomVideo = getRandomVideo(videoSplash);
    // print("Video Path: $randomVideo");

    _controller = VideoPlayerController.asset(randomVideo)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      }).catchError((error) {
        // print("Error video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? Container(
              height: height,
              width: width,
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
            )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
