import 'package:flutter/material.dart';

// 1. Keep your friend's screen import[cite: 10]
import 'screens/newborn_care_screen.dart';

// 2. Import your dashboard screen from your dedicated folder
import 'dashboard/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiMommy!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFBFBFB),
        fontFamily: 'Roboto',
      ),
      // Set the root screen to MainNavigation shell
      home: const MainNavigation(),
    );
  }
}

// Navigation Shell holding both your work and your friend's work
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List of screens: Index 0 is YOUR Dashboard, Index 1 is your FRIEND'S Screen
  final List<Widget> _screens = const [
    DashboardScreen(),
    NewbornCareScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care),
            label: 'Newborn Care',
          ),
        ],
      ),
    );
  }
}