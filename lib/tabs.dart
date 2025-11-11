import 'package:flutter/material.dart';
import 'package:taskfive/screens/about_us_screen.dart';
import 'package:taskfive/screens/chats_screen.dart';
import 'package:taskfive/screens/home_screen.dart';
import 'package:taskfive/screens/jobs_screen.dart';
import 'package:taskfive/screens/some_screen.dart';
import 'package:taskfive/screens/profile_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    JobsScreen(),
    ProfileScreen(),
    ChatsScreen(),
    AboutUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job_Seeker')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services_outlined),
          ),
        ],
      ),
    );
  }
}
