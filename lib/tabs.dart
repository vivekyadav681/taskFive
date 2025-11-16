import 'package:flutter/material.dart';
import 'package:taskfive/screens/about_us_screen.dart';
import 'package:taskfive/screens/chats_screen.dart';
import 'package:taskfive/screens/home_screen.dart';
import 'package:taskfive/screens/jobs_screen.dart';
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.badge_outlined),
            activeIcon: const Icon(Icons.badge),
            label: 'jobs',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_outline),
            activeIcon: const Icon(Icons.chat_bubble),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.miscellaneous_services_outlined),
            activeIcon: const Icon(Icons.miscellaneous_services),
            label: 'about us',
          ),
        ],
      ),
    );
  }
}
