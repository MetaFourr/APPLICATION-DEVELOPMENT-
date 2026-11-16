import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginScreen so the Log out button works

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _notificationsEnabled = true;

  // Wireframe Color Palette
  static const Color _bgColor = Color(0xFFF6F7F4);
  static const Color _cardColor = Color(0xFFFAFBF9);
  static const Color _borderColor = Color(0xFFDCE0D9);
  static const Color _sageGreen = Color(0xFF5B7566);
  static const Color _textPrimary = Color(0xFF1F2421);
  static const Color _textSecondary = Color(0xFF6B726E);

  void _showActionMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROFILE & SETTINGS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: _textSecondary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your account',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.tune, color: _textPrimary, size: 20),
                      onPressed: () => _showActionMessage('Quick preferences'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EAE6),
                            shape: BoxShape.circle,
                            border: Border.all(color: _borderColor),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'MT',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Maya Tan',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: _textPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'maya@example.com',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => _showActionMessage('Edit profile tapped'),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: _sageGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: _borderColor, height: 1),
                    ),
                    InkWell(
                      onTap: () => _showActionMessage('Manage pregnancy journey'),
                      child: const Row(
                        children: [
                          Icon(Icons.favorite_border, color: _textSecondary, size: 22),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your journey · Expecting',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Due 21 Feb 2027 · Manage profile',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: _textSecondary, size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No baby profile added yet · Growth tools show a demo.',
                      style: TextStyle(
                        fontSize: 11,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Settings Section Title
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Settings Group Card
              Container(
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.notifications_none, color: _textSecondary, size: 22),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Appointments & community updates',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 28,
                                child: Switch(
                                  value: _notificationsEnabled,
                                  activeThumbColor: Colors.white,
                                  activeTrackColor: _sageGreen,
                                  onChanged: (val) {
                                    setState(() {
                                      _notificationsEnabled = val;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                _notificationsEnabled ? 'On' : 'Off',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 52),
                    _buildSettingsTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Privacy & data',
                      subtitle: 'Sharing, export or delete account',
                      onTap: () => _showActionMessage('Privacy & data settings'),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 52),
                    _buildSettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Password & security',
                      subtitle: 'Change password or manage devices',
                      onTap: () => _showActionMessage('Password & security settings'),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 52),
                    _buildSettingsTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () => _showActionMessage('Language selection'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Help & Support Card
              Container(
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: _buildSettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help & support',
                  subtitle: 'FAQs, contact us & community rules',
                  onTap: () => _showActionMessage('Help & support center'),
                ),
              ),
              const SizedBox(height: 20),

              // Log Out Button (Navigates back to LoginScreen)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout, color: _textPrimary, size: 20),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _cardColor,
                    side: const BorderSide(color: _borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Footer Text
              const Center(
                child: Column(
                  children: [
                    Text(
                      'HiMommy! · Wireframe concept v1.0',
                      style: TextStyle(fontSize: 11, color: _textSecondary),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Terms of Use · Privacy Policy',
                      style: TextStyle(fontSize: 11, color: _textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: _textSecondary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}