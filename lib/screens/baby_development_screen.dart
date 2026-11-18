import 'package:flutter/material.dart';
import 'profile_screen.dart';

class _MilestoneItem {
  final String title;
  final String age;
  bool done;

  _MilestoneItem({
    required this.title,
    required this.age,
    required this.done,
  });
}

class BabyDevelopmentScreen extends StatefulWidget {
  const BabyDevelopmentScreen({super.key});

  @override
  State<BabyDevelopmentScreen> createState() => _BabyDevelopmentScreenState();
}

class _BabyDevelopmentScreenState extends State<BabyDevelopmentScreen> {
  final List<_MilestoneItem> _milestones = [
    _MilestoneItem(title: 'Lifts head during tummy time', age: '1-2 Months', done: true),
    _MilestoneItem(title: 'Smiles responsively at parents', age: '2 Months', done: true),
    _MilestoneItem(title: 'Rolls over from tummy to back', age: '4 Months', done: false),
    _MilestoneItem(title: 'Sits without support', age: '6 Months', done: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B7566),
        title: const Text(
          'Baby Development Monitoring',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baby Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE3ECE6),
                    child: Icon(Icons.child_care, size: 32, color: Color(0xFF5B7566)),
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baby Profile (3 Months Old)',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Growth Status: Healthy & On Track',
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Growth Metrics Row
            const Text(
              'Latest Growth Measurements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildMetricCard('Weight', '6.2 kg', Icons.monitor_weight, Colors.blue),
                const SizedBox(width: 10),
                _buildMetricCard('Height', '61.5 cm', Icons.height, Colors.purple),
                const SizedBox(width: 10),
                _buildMetricCard('Head', '40.5 cm', Icons.face, Colors.orange),
              ],
            ),
            const SizedBox(height: 20),

            // Developmental Milestones Checklist
            const Text(
              'Developmental Milestones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ..._milestones.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: CheckboxListTile(
                  activeColor: const Color(0xFF5B7566),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Target Age: ${item.age}'),
                  value: item.done,
                  onChanged: (val) {
                    setState(() {
                      item.done = val ?? false;
                    });
                  },
                ),
              );
            }),
            const SizedBox(height: 20),

            // Cross-Feature Link to Caregiver Profile
            const Text(
              'Need Postpartum & Infant Support?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE3ECE6),
                  child: Icon(Icons.medical_services, color: Color(0xFF5B7566)),
                ),
                title: const Text(
                  'Consult Caregiver',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Certified Confinement & Infant Care Specialist'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}