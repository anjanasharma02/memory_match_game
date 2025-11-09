import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/controller/game_controller.dart';
import 'package:my_project/screens/home_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int time = 0;
  Timer? GameTime;

  @override
  void initState() {
    super.initState();
    timer();
    Future.delayed(Duration(milliseconds: 0), () {
      Get.find<GameController>().shuffleImages();
    });
  }

  void timer() {
    GameTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time++;
      });
      if (Get.find<GameController>().cardsMatched.every((matched) => matched)) {
        GameTime?.cancel();
        result();
      }
    });
  }

  void result() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Congratulations!!! 🏆🏆",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            content: Text(
              "You have successfully compeleted the game in $time seconds",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w300,
              ),
            ),
            actions: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text(
                            "Home",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 110,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _restartGame();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 229, 162, 74)),
                          child: Text(
                            "Replay",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<GameController>(builder: (control) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$time",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("sec")
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: GridView.builder(
                        itemCount: control.gameImages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          bool isMatched = control.cardsMatched[index];
                          return GestureDetector(
                              onTap: () {
                                if (!isMatched &&
                                    control.selectedCards.length < 2 &&
                                    !control.ischeckingMatch) {
                                  control.Cards(index);
                                }
                              },
                              child: FlipCard(
                                controller: control.cardControllers[index],
                                flipOnTouch: false,
                                front: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.all()),
                                  child: Icon(
                                    Icons.question_mark,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                back: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage(control.gameImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ));
                        })),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _restartGame() {
    GameTime?.cancel(); // stop current timer
    time = 0;

    // Reset all game data
    final controller = Get.find<GameController>();
    controller.resetGame();

    // Start timer again
    timer();
  }
}
