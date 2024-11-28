// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_fireworks/flutter_fireworks.dart';

class WordsGameScreen extends StatefulWidget {
  const WordsGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<WordsGameScreen> {
  final List<Map<String, String>> questions = [
    {"hint": "Ibu kota Indonesia", "answer": "Jakarta"},
    {
      "hint":
          "Hewan yang dikenal dengan kelambatannya dan sering tidur sepanjang hari",
      "answer": "Kungkang"
    },
    {"hint": "Planet tempat kita tinggal", "answer": "Bumi"},
    {
      "hint": "Benda yang digunakan untuk menulis di papan tulis",
      "answer": "Spidol"
    },
    {"hint": "Hewan terbesar di dunia, hidup di laut", "answer": "Paus"},
    {"hint": "Nama presiden pertama Indonesia", "answer": "Soekarno"},
    {"hint": "Benua terbesar di dunia", "answer": "Asia"},
    {
      "hint": "Benda yang digunakan untuk menghubungkan dua bagian",
      "answer": "Jembatan"
    },
    {"hint": "Bunga nasional Indonesia", "answer": "Melati"},
    {"hint": "Alat musik yang dipetik, memiliki enam senar", "answer": "Gitar"},
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
      const Color(0xFF864542), // Marsala
      const Color(0xFFB04A98), // Orchid
      const Color(0xFF008F6C), // Sea Green
    ],
    // The fastest explosion in seconds
    minExplosionDuration: 0.5,
    // The slowest explosion in seconds
    maxExplosionDuration: 2.5,
    // The minimum number of particles in an explosion
    minParticleCount: 80,
    // The maximum number of particles in an explosion
    maxParticleCount: 150,
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

        Future.delayed(const Duration(seconds: 2));
        fireworksController.fireMultipleRockets(
          // Fire a random number of rockets between 5 and 20
          minRockets: 5,
          maxRockets: 8,
          // Fire all the rockets within this launch window
          launchWindow: const Duration(milliseconds: 400),
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
