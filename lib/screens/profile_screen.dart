import 'package:flutter/material.dart';
import 'baby_development_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B7566),
        title: const Text(
          'Caregiver Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caregiver Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Color(0xFFE3ECE6),
                    child: Icon(Icons.person, size: 48, color: Color(0xFF5B7566)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Confinement Caregiver',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Certified Postpartum & Confinement Specialist',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      const Text('4.9 (48 Reviews)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Available',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About & Experience
            const Text(
              'About Caregiver',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Over 8 years of experience specializing in traditional and modern confinement care, newborn hygiene, breastfeeding support, and nutritious postpartum meal preparation.',
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Key Details
            const Text(
              'Specialties & Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoTile(Icons.verified_user, 'Verified First Aid & Infant CPR Certified'),
            _buildInfoTile(Icons.restaurant_menu, 'Postpartum Herbal & Recovery Meals'),
            _buildInfoTile(Icons.language, 'Languages: English, Bahasa Melayu, Tamil'),
            _buildInfoTile(Icons.payments, 'Rate: RM 180 / day (28-day package available)'),
            const SizedBox(height: 24),

            // Book Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B7566),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking request sent!'),
                      backgroundColor: Color(0xFF5B7566),
                    ),
                  );
                },
                child: const Text(
                  'Book Caregiver',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Cross-Feature Link back to Baby Development Monitoring
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF5B7566),
                  side: const BorderSide(color: Color(0xFF5B7566)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.child_care),
                label: const Text('View Baby Development Monitoring'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BabyDevelopmentScreen(),
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

  Widget _buildInfoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF5B7566), size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}