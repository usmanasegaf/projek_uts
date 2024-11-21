import 'package:flutter/material.dart';

class LogicGame extends StatefulWidget {
  @override
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
        title: Text('Permainan Logika'),
      ),
      body: gameFinished
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Permainan Selesai!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Skor Anda: ${score * 25}/${questions.length * 25}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: restartGame,
                    child: Text('Mulai Lagi'),
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
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(true),
                          child: Text('Benar'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(false),
                          child: Text('Salah'),
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
