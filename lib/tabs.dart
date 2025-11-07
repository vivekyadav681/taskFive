import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0;
    List<Widget> screens = [];
    return Scaffold(
      appBar: AppBar(title: Text('Job_Seeker')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => _selectedIndex = value,
        items: [BottomNavigationBarItem(icon: Icon(Icons.home_outlined))],
      ),
    );
  }
}
