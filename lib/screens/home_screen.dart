import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/screens/play_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assests/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "\nMemory\nMatching\n\t\t\tGame",
                    style: GoogleFonts.dynaPuff(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 145, 0)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 63, 168, 2)),
                    child: Text(
                      "Play",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
