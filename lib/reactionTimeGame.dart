import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class ReactionTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactionTester();
  }
}

class ReactionTester extends StatefulWidget {
  @override
  _ReactionTesterState createState() => _ReactionTesterState();
}

class _ReactionTesterState extends State<ReactionTester> {
  Color _screenColor = Colors.grey;
  late Timer _timer;
  DateTime? _startTime;
  List<int> _reactionTimes = [];
  bool _waitingForTap = false;

  void _startRound() {
    setState(() {
      _screenColor = Colors.grey;
      _waitingForTap = false;
    });

    // Random delay between 2 to 5 seconds
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

    // Tampilkan dialog dan tunggu hingga dialog selesai sebelum memulai ronde berikutnya
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Reaction Time'),
        content: Text('$reactionTime ms'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Menutup dialog
            },
            child: Text('Next Round'),
          ),
        ],
      ),
    ).then((_) {
      // Memastikan dialog sudah tertutup sebelum memulai ronde baru
      _startRound();
    });
  }

  double _calculateAverage() {
    if (_reactionTimes.isEmpty) return 0.0;
    return _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length;
  }

  @override
  void initState() {
    super.initState();
    _startRound();
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
                  _waitingForTap
                      ? 'Tap Now!'
                      : 'Wait for the screen to turn green!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
