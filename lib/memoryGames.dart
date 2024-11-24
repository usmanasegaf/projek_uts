import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permainan Memori',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MemoryGamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MemoryGamePage extends StatefulWidget {
  const MemoryGamePage({super.key});

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  List<int> sequence = [];
  int currentLevel = 1;
  int userIndex = 0;
  bool isUserTurn = false;
  bool showSequence = true;

  @override
  void initState() {
    super.initState();
    startNewLevel();
  }

  void startNewLevel() {
    setState(() {
      showSequence = true;
      isUserTurn = false;
      userIndex = 0;
      sequence.add(Random().nextInt(9)); // Angka acak 0-9
    });

    Future.delayed(Duration(seconds: currentLevel + 1), () {
      setState(() {
        showSequence = false;
        isUserTurn = true;
      });
    });
  }

  void onUserInput(int number) {
    if (!isUserTurn) return;

    if (sequence[userIndex] == number) {
      userIndex++;
      if (userIndex == sequence.length) {
        setState(() {
          currentLevel++;
        });
        startNewLevel();
      }
    } else {
      // Game over
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Game Over'),
          content: Text('Skor Anda: $currentLevel'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Main Lagi'),
            ),
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      sequence.clear();
      currentLevel = 1;
      startNewLevel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permainan Memori'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showSequence) ...[
              const Text(
                'Ingat Urutan Ini:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                sequence.join(' '),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ] else if (isUserTurn) ...[
              const Text(
                'Masukkan Urutan:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(10, (index) {
                  return ElevatedButton(
                    onPressed: () => onUserInput(index),
                    child: Text('$index'),
                  );
                }),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
