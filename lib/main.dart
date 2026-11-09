import 'package:flutter/material.dart';

// 1. Friend's screen import
import 'screens/newborn_care_screen.dart';

// 2. Your dashboard screen import
import 'dashboard/dashboard_screen.dart';

// 3. Import your login screen
import 'login_screen.dart';

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
      // Set initial route to Login screen
      home: const LoginScreen(),
    );
  }
}

// Navigation Shell holding both your work and your friend's work after logging in
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