import 'package:flutter/material.dart';

void main() {
  runApp(const BabyNestApp());
}

class BabyNestApp extends StatelessWidget {
  const BabyNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabyNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF08A8A),
          primary: const Color(0xFFE26D5C),
          surface: const Color(0xFFFFF9F9),
        ),
        useMaterial3: true,
      ),
      home: const BabyNestHomePage(),
    );
  }
}

class BabyNestHomePage extends StatefulWidget {
  const BabyNestHomePage({super.key});

  @override
  State<BabyNestHomePage> createState() => _BabyNestHomePageState();
}

class _BabyNestHomePageState extends State<BabyNestHomePage> {
  int _kickCount = 0;

  void _recordKick() {
    setState(() {
      _kickCount++;
    });
  }

  void _resetKicks() {
    setState(() {
      _kickCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BabyNest 👶',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Mommy! 🌸',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Week 24 of pregnancy • Baby is the size of an ear of corn 🌽',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 18),

            // Fetal Kick Counter Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.redAccent),
                        SizedBox(width: 8),
                        Text(
                          'Fetal Kick Counter (Today)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_kickCount',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _recordKick,
                          icon: const Icon(Icons.add),
                          label: const Text('Record Kick'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _resetKicks,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'BabyNest Modules',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Grid Modules
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildMenuCard(
                  title: 'Newborn Tutorials',
                  subtitle: 'Swaddling, bathing & latching',
                  icon: Icons.play_circle_fill,
                  color: Colors.orange[100]!,
                  iconColor: Colors.deepOrange,
                  onTap: () => _showDialog('Newborn Care Tutorials', 'Video library: Step-by-step swaddling and breastfeeding techniques coming soon!'),
                ),
                _buildMenuCard(
                  title: 'Verified CLs',
                  subtitle: 'Browse confinement ladies',
                  icon: Icons.verified_user,
                  color: Colors.green[100]!,
                  iconColor: Colors.teal,
                  onTap: () => _showDialog('Confinement Marketplace', 'Browse 100% background-checked postnatal caregivers with ratings and packages.'),
                ),
                _buildMenuCard(
                  title: 'Baby Milestones',
                  subtitle: 'WHO growth & charts',
                  icon: Icons.show_chart,
                  color: Colors.blue[100]!,
                  iconColor: Colors.indigo,
                  onTap: () => _showDialog('Development Monitor', 'Log height, weight, head circumference and view WHO growth percentiles.'),
                ),
                _buildMenuCard(
                  title: 'Mommy Forum',
                  subtitle: 'Safe peer discussions',
                  icon: Icons.forum,
                  color: Colors.purple[100]!,
                  iconColor: Colors.deepPurple,
                  onTap: () => _showDialog('Community Hub', 'Connect with other Malaysian mothers in moderated, topic-based chat rooms.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 36, color: iconColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}