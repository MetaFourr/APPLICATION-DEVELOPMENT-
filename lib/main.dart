import 'package:flutter/material.dart';
import 'screens/newborn_care_screen.dart';

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
      home: const NewbornCareScreen(),
    );
  }
}