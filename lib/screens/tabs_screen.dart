import 'package:flutter/material.dart';

import 'search_screen.dart';
import 'watch_later_screen.dart';
import 'seen_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: const [
          SearchScreen(),
          WatchLaterScreen(),
          SeenScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Watch Later',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Seen',
          ),
        ],
      ),
    );
  }
}
