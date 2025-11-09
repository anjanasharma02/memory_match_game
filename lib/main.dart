import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:my_project/controller/game_controller.dart';
import 'package:my_project/splash_screen.dart';

void main() {

  Get.put(GameController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
