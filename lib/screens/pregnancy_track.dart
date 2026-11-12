import 'package:flutter/material.dart';

class PregnancyTrackScreen extends StatefulWidget {
  const PregnancyTrackScreen({super.key});

  @override
  State<PregnancyTrackScreen> createState() => _PregnancyTrackScreenState();
}

class _PregnancyTrackScreenState extends State<PregnancyTrackScreen> {
  // Example: Set your due date here
  final DateTime _dueDate = DateTime.now().add(const Duration(days: 100));
  int _currentWeek = 0;
  int _daysRemaining = 0;

  @override
  void initState() {
    super.initState();
    _calculatePregnancyProgress();
  }

  void _calculatePregnancyProgress() {
    final now = DateTime.now();
    final totalDays = _dueDate.difference(now).inDays;
    // 280 days is a standard full-term pregnancy
    final daysPregnant = 280 - totalDays;
    
    setState(() {
      _currentWeek = (daysPregnant / 7).floor();
      _daysRemaining = totalDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pregnancy Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Week Header
            Text(
              'Week $_currentWeek',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text('$_daysRemaining days to go'),
            const SizedBox(height: 20),
            // Here you can add cards for weight, appointments, etc.
          ],
        ),
      ),
    );
  }
}