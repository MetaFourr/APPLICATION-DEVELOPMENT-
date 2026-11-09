import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables
  bool _obscurePassword = true;
  int _selectedRoleIndex = 0; // 0: Parent, 1: Confinement caregiver
  int _selectedStatusIndex = 0; // 0: Expecting, 1: A new parent
  bool _agreedToTerms = false;

  // Custom theme colors extracted from design
  static const Color primaryGreen = Color(0xFF5B7566);
  static const Color lightGreyBg = Color(0xFFF2F3EE);
  static const Color borderGrey = Color(0xFFD1D5DB);
  static const Color textDark = Color(0xFF1F2937);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              
              // Top Logo & Branding Header
              Center(
                child: Column(
                  children: [
                    // Heart Icon Logo
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 48,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'HiMommy!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Support for every new chapter.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Title section
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Choose your role and create your free HiMommy!\naccount.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Your name input
              _buildInputLabel('Your name'),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: _inputDecoration(hintText: 'Maya Tan'),
              ),

              const SizedBox(height: 16),

              // Email address input
              _buildInputLabel('Email address'),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  hintText: 'maya@example.com',
                  suffixIcon: const Icon(Icons.mail_outline, color: Colors.grey, size: 20),
                ),
              ),

              const SizedBox(height: 16),

              // Password input
              _buildInputLabel('Create password'),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  hintText: 'At least 8 characters',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Account role toggle
              _buildInputLabel('Account role'),
              const SizedBox(height: 8),
              _buildSegmentedToggle(
                options: ['Parent', 'Confinement caregiver'],
                selectedIndex: _selectedRoleIndex,
                onSelect: (index) {
                  setState(() {
                    _selectedRoleIndex = index;
                  });
                },
              ),

              const SizedBox(height: 18),

              // Dynamic Status toggle (Shows only if role is Parent)
              if (_selectedRoleIndex == 0) ...[
                _buildInputLabel('I am currently...'),
                const SizedBox(height: 8),
                _buildSegmentedToggle(
                  options: ['Expecting', 'A new parent'],
                  selectedIndex: _selectedStatusIndex,
                  onSelect: (index) {
                    setState(() {
                      _selectedStatusIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Terms and Privacy Checkbox
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      activeColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _agreedToTerms = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms of Use and Privacy Policy.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Create Account Button
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _agreedToTerms
                      ? () {
                          // Handle sign up action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Account Created!')),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    disabledBackgroundColor: primaryGreen.withOpacity(0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have an account? Log in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Login screen
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Wireframe concept · sample information',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // Label Builder Helper
  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
    );
  }

  // Input Field Border & Styling Helper
  InputDecoration _inputDecoration({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryGreen, width: 1.5),
      ),
    );
  }

  // Segmented Pill Toggle Switch Helper
  Widget _buildSegmentedToggle({
    required List<String> options,
    required int selectedIndex,
    required Function(int) onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: lightGreyBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    options[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? textDark : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}