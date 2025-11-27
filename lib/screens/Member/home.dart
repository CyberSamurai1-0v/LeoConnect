import 'package:flutter/material.dart';

import './member_directory/member_directory.dart';
import 'calendar/calendar.dart';
import './documents.dart';
import '../../screens/leaderboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    Center(child: Text('Home Screen')),
    Calendar(),
    Leaderboard(),
    MemberDirectory(),
    Documents(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // shows active screen
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.contact_page),
            icon: Icon(Icons.group),
            label: "Members",
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.document_scanner),
            icon: Icon(Icons.article_outlined),
            label: "Documents",
          ),
        ],
      ),
    );
  }
}
