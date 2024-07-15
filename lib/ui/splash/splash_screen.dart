import 'package:flutter/material.dart';
import 'package:quiz/common/utils/transition_fade.dart';

import 'dart:async';

import 'package:quiz/ui/welcome_app/welcome_app_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    await Future.delayed(duration).then(
      (value) => Navigator.pushReplacement(
        context,
        TransitionFade(child: const WelcomeAppScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFBDF565),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/educode.png",
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
