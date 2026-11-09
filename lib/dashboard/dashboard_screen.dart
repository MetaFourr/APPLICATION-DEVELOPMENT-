import 'package:flutter/material.dart';
import 'dashboard_widgets.dart'; // Imports your separate widget components

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'HiMommy! Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Welcome Banner Widget
            const DashboardWelcomeBanner(
              userName: 'Mommy',
              pregnancyWeek: 24,
            ),
            const SizedBox(height: 20),

            // 2. Daily Tracking Section
            const Text(
              'Daily Tracking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: DashboardStatCard(
                    title: 'Kick Count',
                    value: '8 kicks',
                    icon: Icons.favorite,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DashboardStatCard(
                    title: 'Weight',
                    value: '58.5 kg',
                    icon: Icons.monitor_weight,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Quick Action Buttons
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DashboardActionButton(
              title: 'Infant Growth Monitor',
              subtitle: 'Track height, weight & milestones',
              icon: Icons.child_care,
              color: Colors.purple,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            DashboardActionButton(
              title: 'Book Confinement Care',
              subtitle: 'Find verified confinement ladies',
              icon: Icons.medical_services,
              color: Colors.teal,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            DashboardActionButton(
              title: 'Motherhood Forum',
              subtitle: 'Connect with other parents',
              icon: Icons.forum,
              color: Colors.orange,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}