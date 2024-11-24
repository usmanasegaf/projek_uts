import 'package:flutter/material.dart';
import 'package:projek_uts/logicGame.dart';
import 'package:projek_uts/login.dart';
import 'package:projek_uts/mathGame.dart';
import 'package:projek_uts/memoryGames.dart';
import 'package:projek_uts/reactionTimeGame.dart';
import 'package:projek_uts/wordsGame.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permainan Logika',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    Center(child: LogicGame()),
    Center(child: ReactionTimeApp()),
    Center(child: MathGameApp()),
    Center(child: GameScreen()),
    Center(child: MemoryGameApp()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.memory),
            label: 'Logic Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Reaction Time Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Math game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Words games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Memory games',
          ),
        ],
      ),
    );
  }
}
