import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double initial = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      setState(() {
        initial = initial + 0.01;
        if (initial >= 1.0) {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Loading",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              child: LinearProgressIndicator(
                minHeight: 20,
                color: Colors.redAccent,
                value: initial,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
