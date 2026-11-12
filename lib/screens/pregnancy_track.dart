import 'package:flutter/material.dart';

class PregnancyTrackScreen extends StatefulWidget {
  const PregnancyTrackScreen({super.key});

  @override
  State<PregnancyTrackScreen> createState() => _PregnancyTrackScreenState();
}

class _PregnancyTrackScreenState extends State<PregnancyTrackScreen> {
  // Example: Set your due date here
  final DateTime _dueDate = DateTime.now().add(const Duration(days: 140)); // 20 weeks left
  int _currentWeek = 0;
  int _daysRemaining = 0;
  double _progress = 0.0;

  // --- NEW PINK THEME COLORS ---
  final Color _primaryPink = const Color(0xFFD81B60); // Deep rose pink
  final Color _bgColor = const Color(0xFFFFF0F5); // Very soft lavender/blush pink
  final Color _textColor = const Color(0xFF4A4A4A); // Soft dark grey for text

  @override
  void initState() {
    super.initState();
    _calculatePregnancyProgress();
  }

  void _calculatePregnancyProgress() {
    final now = DateTime.now();
    final totalDays = _dueDate.difference(now).inDays;
    final daysPregnant = 280 - totalDays;
    
    setState(() {
      _currentWeek = (daysPregnant / 7).floor();
      _daysRemaining = totalDays;
      // Calculate progress between 0.0 and 1.0
      _progress = (daysPregnant / 280).clamp(0.0, 1.0); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'HiMommy!',
          style: TextStyle(color: _primaryPink, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: _primaryPink),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Circular Progress Header
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 12,
                      backgroundColor: _primaryPink.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(_primaryPink),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Week',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$_currentWeek',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _primaryPink,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        '$_daysRemaining days to go',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // 2. Baby Size / Weekly Tip Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _primaryPink.withOpacity(0.08), // Pinkish shadow
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _primaryPink.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite, color: _primaryPink, size: 30), // Changed to heart
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Baby is the size of a...',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Banana',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _primaryPink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Section Title
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 16),

            // 4. Action Grid
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.timer,
                    title: 'Kick Counter',
                    color: const Color(0xFFFFD1DC), // Pastel Pink
                    iconColor: const Color(0xFFF06292), // Medium Pink
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.calendar_month,
                    title: 'Appointments',
                    color: const Color(0xFFE1BEE7), // Soft Lavender
                    iconColor: const Color(0xFFBA68C8), // Medium Purple
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.monitor_weight,
                    title: 'Weight Log',
                    color: const Color(0xFFFFE0B2), // Soft Peach
                    iconColor: const Color(0xFFFFB74D), // Medium Orange
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.medical_information,
                    title: 'Health Tips',
                    color: const Color(0xFFF8BBD0), // Lighter Pink
                    iconColor: const Color(0xFFE91E63), // Deep Pink
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper widget to create the action cards
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5), // Slightly transparent pastel
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 1.5), // Adds a crisp edge
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}