import 'package:flutter/material.dart';
import 'login_page.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Interactive User State
  String _userName = 'Maya Tan';
  String _userEmail = 'maya@example.com';
  String _dueDate = '21 Feb 2027';
  String _selectedLanguage = 'English';
  bool _notificationsEnabled = true;
  bool _hasBabyProfile = false;
  String _babyName = 'Baby Noah';

  // Aesthetic Soft Rose & Blush Palette
  static const Color _bgColor = Color(0xFFFFF7F8);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _borderColor = Color(0xFFF6DFE4);
  static const Color _primaryPink = Color(0xFFD95D78);
  static const Color _softPink = Color(0xFFFDECEF);
  static const Color _accentPeach = Color(0xFFFFF0EB);
  static const Color _textPrimary = Color(0xFF2A1B20);
  static const Color _textSecondary = Color(0xFF856B72);

  String get _initials {
    final parts = _userName.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return _userName.isNotEmpty ? _userName[0].toUpperCase() : 'M';
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _primaryPink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Interactive Modal: Edit Profile
  void _openEditProfileSheet() {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);
    final dueController = TextEditingController(text: _dueDate);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  filled: true,
                  fillColor: _bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _borderColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  filled: true,
                  fillColor: _bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _borderColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dueController,
                decoration: InputDecoration(
                  labelText: 'Estimated Due Date',
                  filled: true,
                  fillColor: _bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _borderColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (nameController.text.trim().isNotEmpty) {
                        _userName = nameController.text.trim();
                      }
                      if (emailController.text.trim().isNotEmpty) {
                        _userEmail = emailController.text.trim();
                      }
                      if (dueController.text.trim().isNotEmpty) {
                        _dueDate = dueController.text.trim();
                      }
                    });
                    Navigator.pop(ctx);
                    _showSnack('Profile updated!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryPink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Interactive Modal: Language Picker
  void _openLanguageSheet() {
    final languages = ['English', 'Bahasa Melayu', '中文 (Mandarin)'];
    showModalBottomSheet(
      context: context,
      backgroundColor: _cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Language',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...languages.map((lang) {
                final isSelected = _selectedLanguage == lang;
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  tileColor: isSelected ? _softPink : Colors.transparent,
                  title: Text(
                    lang,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? _primaryPink : _textPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: _primaryPink)
                      : null,
                  onTap: () {
                    setState(() => _selectedLanguage = lang);
                    Navigator.pop(ctx);
                    _showSnack('Language changed to $lang');
                  },
                );
              }),
            ],
          ),
        );
      },
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
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROFILE & SETTINGS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                          color: _primaryPink,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryPink.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.tune_rounded,
                          color: _primaryPink, size: 20),
                      onPressed: () =>
                          _showSnack('Appearance & theme preferences'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Aesthetic Gradient Profile Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFFFFF), Color(0xFFFFF0F3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: _borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPink.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Gradient Avatar
                        Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFF39EB1), Color(0xFFD95D78)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _initials,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _userEmail,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Pill Edit Button
                        InkWell(
                          onTap: _openEditProfileSheet,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: _softPink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: _primaryPink,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Divider(color: _borderColor, height: 1),
                    ),

                    // Interactive Journey / Baby Toggle Card
                    InkWell(
                      onTap: () {
                        setState(() {
                          _hasBabyProfile = !_hasBabyProfile;
                        });
                        _showSnack(_hasBabyProfile
                            ? 'Switched to Newborn Profile ($_babyName)'
                            : 'Switched to Expecting Journey');
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _borderColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: _softPink,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _hasBabyProfile
                                    ? Icons.child_friendly_rounded
                                    : Icons.favorite_rounded,
                                color: _primaryPink,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _hasBabyProfile
                                        ? 'Postnatal · $_babyName (2 mos)'
                                        : 'Your journey · Expecting',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _hasBabyProfile
                                        ? 'Growth & WHO charts active'
                                        : 'Due $_dueDate · Tap to switch mode',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: _textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.swap_horiz_rounded,
                                color: _primaryPink, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            size: 13, color: _primaryPink),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _hasBabyProfile
                                ? 'Tracking milestones & confinement schedule.'
                                : 'No baby profile added yet · Tap card above to preview baby mode.',
                            style: const TextStyle(
                              fontSize: 11,
                              color: _textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Settings Header
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Settings Card
              Container(
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPink.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Notifications Toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          _buildIconBadge(Icons.notifications_active_outlined,
                              _softPink, _primaryPink),
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
                                  activeTrackColor: _primaryPink,
                                  onChanged: (val) {
                                    setState(() {
                                      _notificationsEnabled = val;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                _notificationsEnabled ? 'On' : 'Off',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _notificationsEnabled
                                      ? _primaryPink
                                      : _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 64),
                    _buildSettingsTile(
                      icon: Icons.verified_user_outlined,
                      iconBg: _accentPeach,
                      iconColor: const Color(0xFFE07A5F),
                      title: 'Privacy & data',
                      subtitle: 'Sharing, export or delete account',
                      onTap: () => _showSnack('Privacy & data controls'),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 64),
                    _buildSettingsTile(
                      icon: Icons.lock_outline_rounded,
                      iconBg: const Color(0xFFF3ECFF),
                      iconColor: const Color(0xFF8B68C7),
                      title: 'Password & security',
                      subtitle: 'Change password or manage devices',
                      onTap: () => _showSnack('Password & security settings'),
                    ),
                    const Divider(color: _borderColor, height: 1, indent: 64),
                    _buildSettingsTile(
                      icon: Icons.language_rounded,
                      iconBg: const Color(0xFFE8F4F8),
                      iconColor: const Color(0xFF4A90A4),
                      title: 'Language',
                      subtitle: _selectedLanguage,
                      onTap: _openLanguageSheet,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Help & Support Card
              Container(
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPink.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _buildSettingsTile(
                  icon: Icons.support_agent_rounded,
                  iconBg: _softPink,
                  iconColor: _primaryPink,
                  title: 'Help & support',
                  subtitle: 'FAQs, contact us & community rules',
                  onTap: () => _showSnack('Opening Mommy Care Support'),
                ),
              ),
              const SizedBox(height: 22),

              // Log Out Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded,
                      color: _primaryPink, size: 20),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      color: _primaryPink,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _cardColor,
                    side: const BorderSide(color: _borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Footer
              const Center(
                child: Column(
                  children: [
                    Text(
                      'HiMommy! · Maternal & Newborn Care',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _textSecondary,
                      ),
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

  Widget _buildIconBadge(IconData icon, Color bg, Color iconColor) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _buildIconBadge(icon, iconBg, iconColor),
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
            const Icon(Icons.chevron_right_rounded,
                color: _textSecondary, size: 22),
          ],
        ),
      ),
    );
  }
}