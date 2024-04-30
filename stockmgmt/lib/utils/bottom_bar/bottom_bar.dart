import 'package:flutter/material.dart';
import 'package:stockmgmt/features/history/presentation/views/history.dart';
import 'package:stockmgmt/features/dashboard/presentation/views/homescreen.dart';
import 'package:stockmgmt/features/items/presentation/views/items.dart';
import 'package:stockmgmt/features/settings/presentation/views/settings.dart';

class BottomBar extends StatefulWidget {
  final int? selectedIndex;
  const BottomBar({super.key, required this.selectedIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSelectedIndex();
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const ItemScreen(),
    const HistoryScreen(),
    const SettingScreen(),
  ];
  int _selectedIndex = 0;

  setSelectedIndex() {
    setState(() {
      _selectedIndex = widget.selectedIndex ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 10,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 73, 73, 220),
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_bag,
              color: Color.fromARGB(255, 73, 73, 220),
            ),
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            label: 'Items',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.history,
              color: Color.fromARGB(255, 73, 73, 220),
            ),
            icon: Icon(
              Icons.history_outlined,
              color: Colors.black,
            ),
            label: 'History',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.settings,
              color: Color.fromARGB(255, 73, 73, 220),
            ),
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
    );
  }
}
