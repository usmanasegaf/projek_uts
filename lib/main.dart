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
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // State untuk mengganti halaman MemoryGame
  Key memoryGameKey = UniqueKey();

  // List of pages
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      LogicGame(),
      ReactionTimeApp(),
      MathGameApp(),
      GameScreen(),
      MemoryGamePage(key: memoryGameKey), // <--- Gunakan key unik
    ];
  }

  void resetMemoryGamePage() {
    setState(() {
      memoryGameKey = UniqueKey(); // Membuat key baru untuk rebuild halaman
      _pages[4] = MemoryGamePage(key: memoryGameKey); // Reset halaman
    });
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
          if (index == 4) {
            resetMemoryGamePage(); // Reset saat MemoryGame dipilih ulang
          }
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
