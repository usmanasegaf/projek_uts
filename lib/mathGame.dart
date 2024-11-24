import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class MathGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MathGameScreen();
  }
}

class MathGameScreen extends StatefulWidget {
  @override
  _MathGameScreenState createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  int _score = 0;
  int _timePerQuestion = 10; // waktu untuk menjawab setiap soal dalam detik
  int _currentTime = 10;
  late Timer _timer;

  late int _number1;
  late int _number2;
  late String _operator;
  late int _correctAnswer;

  TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _checkAnswer(isTimeout: true);
        }
      });
    });
  }

  void _generateQuestion() {
    final random = Random();
    _number1 = random.nextInt(10) + 1; // Angka pertama (1-10)
    _number2 = random.nextInt(10) + 1; // Angka kedua (1-10)
    int operatorIndex = random.nextInt(3); // 0: +, 1: -, 2: x

    switch (operatorIndex) {
      case 0:
        _operator = '+';
        _correctAnswer = _number1 + _number2;
        break;
      case 1:
        _operator = '-';
        _correctAnswer = _number1 - _number2;
        break;
      case 2:
        _operator = 'x';
        _correctAnswer = _number1 * _number2;
        break;
    }
  }

  void _checkAnswer({bool isTimeout = false}) {
    if (!isTimeout) {
      final userAnswer = int.tryParse(_answerController.text);
      if (userAnswer != null && userAnswer == _correctAnswer) {
        setState(() {
          _score++;
        });
      }
    }

    // Reset timer dan generate soal baru
    _answerController.clear();
    _generateQuestion();
    setState(() {
      _currentTime = _timePerQuestion;
    });
  }

  void _resetGame() {
    setState(() {
      _score = 0;
      _currentTime = _timePerQuestion;
    });
    _generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permainan Matematika Cepat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Waktu Tersisa: $_currentTime detik',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Skor: $_score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text(
              '$_number1 $_operator $_number2 = ?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Masukkan jawaban',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _checkAnswer(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Kirim Jawaban'),
            ),
            SizedBox(height: 40),
            if (_currentTime == 0)
              ElevatedButton(
                onPressed: _resetGame,
                child: Text('Main Lagi'),
              ),
          ],
        ),
      ),
    );
  }
}
