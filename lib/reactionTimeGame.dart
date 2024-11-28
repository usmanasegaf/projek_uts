// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ReactionTimeApp extends StatefulWidget {
  const ReactionTimeApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReactionTimeAppState createState() => _ReactionTimeAppState();
}

class _ReactionTimeAppState extends State<ReactionTimeApp> {
  Color _screenColor = Color.fromARGB(255, 119, 255, 255);
  late Timer _timer;
  DateTime? _startTime;
  // ignore: prefer_final_fields
  List<int> _reactionTimes = [];
  bool _waitingForTap = false;
  bool _gameStarted = false;
  bool _gameFinished = false; // <--- Flag untuk menandai akhir permainan

  void _startRound() {
    if (_reactionTimes.length == 5) {
      // <--- Cek apakah sudah 5 ronde selesai
      setState(() {
        _gameFinished = true; // Tandai bahwa game selesai
        _gameStarted = false;
        _waitingForTap = false;
      });
      return;
    }

    setState(() {
      _screenColor = Color.fromARGB(255, 119, 255, 255);
      _waitingForTap = false;
      _gameStarted = true;
    });

    final delay = Random().nextInt(3000) + 2000;

    _timer = Timer(Duration(milliseconds: delay), () {
      setState(() {
        _screenColor = const Color.fromARGB(255, 80, 207, 75);
        _startTime = DateTime.now();
        _waitingForTap = true;
      });
    });
  }

  void _handleTap() {
    if (!_waitingForTap) return;

    final reactionTime =
        DateTime.now().difference(_startTime!).inMilliseconds - 80;
    setState(() {
      _reactionTimes.add(reactionTime);
      _waitingForTap = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reaction Time'),
        content: Text('$reactionTime ms'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Next Round'),
          ),
        ],
      ),
    ).then((_) {
      _startRound();
    });
  }

  double _calculateAverage() {
    if (_reactionTimes.isEmpty) return 0.0;
    return _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length;
  }

  void _restartGame() {
    setState(() {
      _reactionTimes.clear();
      _gameFinished = false;
      _gameStarted = false;
      _screenColor = const Color.fromARGB(255, 119, 255, 255);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permainan Reaction Time'),
      ),
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          color: _screenColor,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_reactionTimes.isNotEmpty) ...[
                  Text(
                    'Average Reaction Time: ${_calculateAverage().toStringAsFixed(2)} ms',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                ],
                if (!_gameFinished) ...[
                  Text(
                    _gameStarted
                        ? (_waitingForTap
                            ? 'Tap Now!'
                            : 'Wait for the screen to turn green!')
                        : 'Tekan tombol untuk memulai ronde',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  if (!_gameStarted) ...[
                    ElevatedButton(
                      onPressed: _startRound,
                      child: const Text('Start Round'),
                    ),
                  ],
                ] else ...[
                  // <--- Tombol 'Main Lagi' setelah 5 ronde
                  const Text(
                    'Permainan Selesai!',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _restartGame,
                    child: const Text('Main Lagi'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
