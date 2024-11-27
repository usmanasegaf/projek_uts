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
  ];

  void checkAnswer(bool userAnswer) {
    if (userAnswer == questions[currentQuestionIndex]['answer']) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
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
      currentQuestionIndex = 0;
      score = 0;
      gameFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permainan Logika'),
      ),
      body: gameFinished
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Permainan Selesai!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Skor Anda: ${score * 10}/${questions.length * 10}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: restartGame,
                    child: const Text('Mulai Lagi'),
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
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(true),
                          child: const Text('Benar'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(false),
                          child: const Text('Salah'),
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
