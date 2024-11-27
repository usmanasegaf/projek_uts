// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';

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
  bool showSequence = false;
  bool gameStarted = false;

  void startNewLevel() {
    setState(() {
      showSequence = true;
      isUserTurn = false;
      userIndex = 0;
      sequence.add(Random().nextInt(9));
    });

    Future.delayed(const Duration(milliseconds: 1350), () {
      if (mounted) {
        setState(() {
          showSequence = false;
          isUserTurn = true;
        });
      }
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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Game Over'),
          content: Text('Skor Anda: ${currentLevel - 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: const Text('Main Lagi'),
            ),
          ],
        ),
      );
    }
  }

  void restartGame() {
    // Hanya me-*reset* permainan tanpa memengaruhi navigasi
    setState(() {
      sequence.clear();
      currentLevel = 1;
      userIndex = 0;
      isUserTurn = false;
      showSequence = false;
      gameStarted = false;
    });
  }

  void startGame() {
    setState(() {
      gameStarted = true;
    });
    startNewLevel();
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
            if (!gameStarted) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Ketuk Tombol untuk Memulai Game"),
              ),
              ElevatedButton(
                onPressed: startGame,
                child: const Text('Start Game'),
              ),
            ] else if (showSequence) ...[
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
