// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class MathGameApp extends StatelessWidget {
  const MathGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MathGameScreen();
  }
}

class MathGameScreen extends StatefulWidget {
  const MathGameScreen({super.key});

  @override
  _MathGameScreenState createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  int _score = 0;
  // ignore: prefer_final_fields
  int _timePerQuestion = 6; // waktu untuk menjawab setiap soal dalam detik
  int _currentTime = 6;
  late Timer _timer;

  late int _number1;
  late int _number2;
  late String _operator;
  late int _correctAnswer;

  // ignore: prefer_final_fields
  TextEditingController _answerController = TextEditingController();

  bool _gameStarted = false; // Flag untuk menandakan permainan telah dimulai
  int _questionCount = 0; // Variabel untuk menghitung jumlah soal yang dijawab

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  @override
  void dispose() {
    _timer.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

    // Increment the question count
    setState(() {
      _questionCount++;
    });

    // Stop the game after 10 questions
    if (_questionCount >= 10) {
      _timer.cancel();
      _showScoreDialog(); // Show the score dialog
    } else {
      // Reset timer dan generate soal baru
      _answerController.clear();
      _generateQuestion();
      setState(() {
        _currentTime = _timePerQuestion;
      });
    }
  }

  void _resetGame() {
    setState(() {
      _score = 0;
      _startTimer();
      _currentTime = _timePerQuestion;
      _questionCount = 0; // Reset question count
    });
    _generateQuestion();
  }

  void _startGame() {
    setState(() {
      _gameStarted = true; // Mulai permainan
    });
    _startTimer(); // Mulai timer
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permainan Selesai'),
          content: Text('Skor Anda: $_score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame(); // Reset game after showing score
              },
              child: const Text('Main Lagi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permainan Matematika Cepat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!_gameStarted) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Ketuk Tombol untuk Memulai Game"),
                ),
                ElevatedButton(
                  onPressed: _startGame,
                  child: const Text('Start Game'),
                ),
              ] else ...[
                // Tampilan permainan setelah game dimulai
                Text(
                  'Waktu Tersisa: $_currentTime detik',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Skor: $_score',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Text(
                  '$_number1 $_operator $_number2 = ?',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _answerController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan jawaban',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _checkAnswer(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkAnswer,
                  child: const Text('Kirim Jawaban'),
                ),
                const SizedBox(height: 40),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
