import 'package:flutter/material.dart';
import 'package:project_ourecycle/frontend/pages/transaksi_screen.dart';
import 'package:project_ourecycle/frontend/pages/setting_screen.dart';
import 'package:project_ourecycle/frontend/pages/home_screen.dart';

class AnimationBar extends StatefulWidget {
  const AnimationBar({super.key});

  @override
  State<AnimationBar> createState() => _AnimationBarState();
}

class _AnimationBarState extends State<AnimationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TransaksiScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Color(0xFF00AA13),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
