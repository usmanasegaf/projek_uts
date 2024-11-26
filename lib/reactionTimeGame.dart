import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ReactionTimeApp extends StatefulWidget {
  @override
  _ReactionTimeAppState createState() => _ReactionTimeAppState();
}

class _ReactionTimeAppState extends State<ReactionTimeApp> {
  Color _screenColor = Colors.grey;
  late Timer _timer;
  DateTime? _startTime;
  List<int> _reactionTimes = [];
  bool _waitingForTap = false;
  bool _gameStarted = false;

  void _startRound() {
    setState(() {
      _screenColor = Colors.grey;
      _waitingForTap = false;
      _gameStarted = true;
    });

    final delay = Random().nextInt(3000) + 2000;

    _timer = Timer(Duration(milliseconds: delay), () {
      setState(() {
        _screenColor = Colors.green;
        _startTime = DateTime.now();
        _waitingForTap = true;
      });
    });
  }

  void _handleTap() {
    if (!_waitingForTap) return;

    final reactionTime = DateTime.now().difference(_startTime!).inMilliseconds;
    setState(() {
      _reactionTimes.add(reactionTime);
      _waitingForTap = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Reaction Time'),
        content: Text('$reactionTime ms'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Next Round'),
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction Time Tester'),
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
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                ],
                Text(
                  _gameStarted
                      ? (_waitingForTap
                          ? 'Tap Now!'
                          : 'Wait for the screen to turn green!')
                      : 'Tekan tombol untuk memulai ronde',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                // <-------- Button will disappear after the game starts
                if (!_gameStarted) ...[
                  ElevatedButton(
                    onPressed: _startRound,
                    child: Text('Start Round'),
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
