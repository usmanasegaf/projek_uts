// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LogicGame extends StatefulWidget {
  const LogicGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogicGameState createState() => _LogicGameState();
}

class _LogicGameState extends State<LogicGame> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool gameFinished = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Jika A = B dan B = C, maka A = C.',
      'answer': true,
    },
    {
      'question': 'Jika X > Y dan Y > Z, maka X < Z.',
      'answer': false,
    },
    {
      'question': 'Semua bilangan genap adalah bilangan prima.',
      'answer': false,
    },
    {
      'question':
          'Jika P adalah bilangan genap, maka P + 1 adalah bilangan ganjil.',
      'answer': true,
    },
    {
      'question': 'Semua angka 2 adalah bilangan prima.',
      'answer': true,
    },
    {
      'question': 'Jika A > B dan B > C, maka A > C.',
      'answer': true,
    },
    {
      'question':
          'Jika P adalah bilangan prima, maka P + 2 adalah bilangan prima.',
      'answer': false,
    },
    {
      'question':
          'Jika suatu bilangan habis dibagi 2, maka bilangan tersebut genap.',
      'answer': true,
    },
    {
      'question': 'Bilangan negatif tidak bisa menjadi bilangan prima.',
      'answer': true,
    },
    {
      'question': 'Semua bilangan ganjil adalah bilangan komposit.',
      'answer': false,
    },
    {
      'question':
          'Jika 10 lebih besar dari 5 dan 5 lebih besar dari 0, maka 10 lebih besar dari 0.',
      'answer': true,
    },
    {
      'question': 'Semua bilangan negatif adalah bilangan prima.',
      'answer': false,
    },
    {
      'question':
          'Bilangan prima hanya bisa dibagi oleh 1 dan dirinya sendiri.',
      'answer': true,
    },
    {
      'question':
          'Jika A adalah bilangan ganjil dan B adalah bilangan ganjil, maka A + B adalah bilangan ganjil.',
      'answer': false,
    },
    {
      'question': 'Angka 1 adalah bilangan prima.',
      'answer': false,
    },
    {
      'question':
          'Semua bilangan genap lebih besar dari 1 adalah bilangan prima.',
      'answer': false,
    },
    {
      'question': 'Jumlah dari dua bilangan genap selalu genap.',
      'answer': true,
    },
    {
      'question': 'Jumlah dari dua bilangan ganjil selalu ganjil.',
      'answer': false,
    },
    {
      'question': 'Angka 3 adalah bilangan prima.',
      'answer': true,
    },
    {
      'question': 'Jika A > B dan B > C, maka A < C.',
      'answer': false,
    },
  ];

  void checkAnswer(bool userAnswer) {
    if (userAnswer == questions[currentQuestionIndex]['answer']) {
      score++;
    }

    if (currentQuestionIndex < 9) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        gameFinished = true;
      });
    }
  }

  void restartGame() {
    setState(() {
      // Acak urutan soal
      questions.shuffle();
      currentQuestionIndex = 0;
      score = 0;
      gameFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Permainan Logika',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: gameFinished
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.done_all,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Permainan Selesai!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Skor Anda: ${score * 10}/100',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: restartGame,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Mulai Lagi',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    questions[currentQuestionIndex]['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          onPressed: () => checkAnswer(true),
                          icon: const Icon(
                            Icons.check_circle_outline,
                          ),
                          label: const Text(
                            'Benar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          onPressed: () => checkAnswer(false),
                          icon: const Icon(
                            Icons.cancel_outlined,
                          ),
                          label: const Text(
                            'Salah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
