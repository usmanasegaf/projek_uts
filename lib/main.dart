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
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // State untuk mengganti halaman
  Key memoryGameKey = UniqueKey();
  Key mathGameKey = UniqueKey();
  Key reactGameKey = UniqueKey();
  // List of pages
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const LogicGame(),
      ReactionTimeApp(key: reactGameKey),
      MathGameApp(key: mathGameKey),
      const WordsGameScreen(),
      MemoryGamePage(key: memoryGameKey),
    ];
  }

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
            label: 'Math Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Words Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Memory Game',
          ),
        ],
      ),
    );
  }
}
