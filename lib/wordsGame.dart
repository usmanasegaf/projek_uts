import 'package:flutter/material.dart';
import 'package:flutter_fireworks/flutter_fireworks.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, String>> questions = [
    {"hint": "Ibu kota Indonesia", "answer": "Jakarta"},
    {"hint": "Hewan berkaki empat, menggonggong", "answer": "Anjing"},
    {"hint": "Planet tempat kita tinggal", "answer": "Bumi"},
  ];

  int currentQuestionIndex = 0;
  String userAnswer = "";
  String message = "";
  bool showFireworks = false;

  final TextEditingController _controller = TextEditingController();

  final fireworksController = FireworksController(
    colors: [
      const Color(0xFFFF4C40), // Coral
      const Color(0xFF6347A6), // Purple Haze
      const Color(0xFF7FB13B), // Greenery
      const Color(0xFF82A0D1), // Serenity Blue
      const Color(0xFFF7B3B2), // Rose Quartz
      const Color(0xFF864542), // Marsala
      const Color(0xFFB04A98), // Orchid
      const Color(0xFF008F6C), // Sea Green
      const Color(0xFFFFD033), // Pastel Yellow
      const Color(0xFFFF6F7C), // Pink Grapefruit
    ],
    // The fastest explosion in seconds
    minExplosionDuration: 0.5,
    // The slowest explosion in seconds
    maxExplosionDuration: 3.5,
    // The minimum number of particles in an explosion
    minParticleCount: 125,
    // The maximum number of particles in an explosion
    maxParticleCount: 275,
    // The duration for particles to fade out in seconds
    fadeOutDuration: 0.4,
  );

  void checkAnswer() {
    final correctAnswer =
        questions[currentQuestionIndex]['answer']?.toLowerCase() ?? "";
    if (userAnswer.toLowerCase() == correctAnswer) {
      setState(() {
        message = "Benar!";
        showFireworks = true;
        _controller.clear();
      });
      setState(() {
        showFireworks = false;
        currentQuestionIndex++;
        userAnswer = "";
        if (currentQuestionIndex >= questions.length) {
          message = "Permainan selesai! Kamu menang!";
        }
        Future.delayed(const Duration(seconds: 2));
        fireworksController.fireMultipleRockets(
          // Fire a random number of rockets between 5 and 20
          minRockets: 5,
          maxRockets: 20,
          // Fire all the rockets within this launch window
          launchWindow: const Duration(milliseconds: 600),
        );
      });
    } else {
      setState(() {
        message = "Salah, coba lagi!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(title: const Text("Tebak Kata")),
        body: const Center(
            child: Text(
          "Permainan selesai! Selamat!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Tebak Kata")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Petunjuk:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  questions[currentQuestionIndex]['hint']!,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  onChanged: (value) => setState(() {
                    userAnswer = value;
                  }),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Jawaban Kamu",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: message == "Benar!" ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          FireworksDisplay(
            controller: fireworksController,
          ),
        ],
      ),
    );
  }
}
