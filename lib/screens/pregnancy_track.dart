import 'package:flutter/material.dart';

class PregnancyTrackScreen extends StatefulWidget {
  const PregnancyTrackScreen({super.key});

  @override
  State<PregnancyTrackScreen> createState() => _PregnancyTrackScreenState();
}

class _PregnancyTrackScreenState extends State<PregnancyTrackScreen> {
  // Theme colors matching your main.dart & wireframe
  final Color _primaryGreen = const Color(0xFF5B7566);
  final Color _softGreenBg = const Color(0xFFE7EDE9);
  final Color _bgColor = const Color(0xFFFBFBFB);
  final Color _borderColor = const Color(0xFFE4E4E2);
  final Color _textDark = const Color(0xFF232624);
  final Color _textMuted = const Color(0xFF707572);

  // Due date & week calculation logic
  DateTime _dueDate = DateTime.now().add(const Duration(days: 112)); // ~24 weeks
  int _currentWeek = 24;
  int _selectedWeek = 24;

  String _selectedMood = 'Good';
  final String _motherName = "MAYA'S JOURNEY";

  // Local list to store check-ins temporarily while testing UI
  final List<Map<String, dynamic>> _localCheckIns = [];

  // Weekly milestones for the selector strip
  final Map<int, Map<String, dynamic>> _weeklyMilestones = {
    22: {
      'size': 'As big as a coconut',
      'stats': 'About 27.8 cm · 430 g',
      'desc': 'Your baby’s senses are developing rapidly and eyebrows are visible.',
      'icon': Icons.spa_outlined,
    },
    23: {
      'size': 'As big as a large mango',
      'stats': 'About 28.9 cm · 500 g',
      'desc': 'Your baby can hear your voice and heartbeat more clearly now.',
      'icon': Icons.eco_outlined,
    },
    24: {
      'size': 'As big as an ear of corn',
      'stats': 'About 30 cm · 600 g',
      'desc': 'Your baby is practising breathing movements and responding to familiar sounds.',
      'icon': Icons.grass_rounded,
    },
    25: {
      'size': 'As big as a cauliflower',
      'stats': 'About 34.6 cm · 660 g',
      'desc': 'Your baby is gaining baby fat and developing smoother skin.',
      'icon': Icons.local_florist_outlined,
    },
    26: {
      'size': 'As big as a head of lettuce',
      'stats': 'About 35.6 cm · 760 g',
      'desc': 'Your baby’s eyes are beginning to open and blink.',
      'icon': Icons.nature_outlined,
    },
  };

  @override
  void initState() {
    super.initState();
    _calculatePregnancyProgress();
  }

  void _calculatePregnancyProgress() {
    final now = DateTime.now();
    final totalDays = _dueDate.difference(now).inDays;
    final daysPregnant = (280 - totalDays).clamp(1, 280);

    setState(() {
      _currentWeek = (daysPregnant / 7).floor().clamp(1, 40);
      _selectedWeek = _currentWeek;
    });
  }

  String _getTrimesterLabel(int week) {
    if (week <= 13) return 'first trimester';
    if (week <= 27) return 'second trimester';
    return 'third trimester';
  }

  String _formatDueDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _saveCheckIn({
    required String mood,
    List<String> symptoms = const [],
    String? notes,
  }) {
    setState(() {
      _selectedMood = mood;
      _localCheckIns.insert(0, {
        'mood': mood,
        'symptoms': symptoms,
        'notes': notes,
        'date': DateTime.now(),
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved check-in ($mood)'),
        backgroundColor: _primaryGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogSheet() {
    final noteController = TextEditingController();
    final options = ['Fatigue', 'Back pain', 'Nausea', 'Heartburn', 'Swelling', 'Baby kicks'];
    final chosen = <String>{};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log symptoms or a note',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _textDark),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((item) {
                  final active = chosen.contains(item);
                  return FilterChip(
                    label: Text(item),
                    selected: active,
                    selectedColor: _softGreenBg,
                    checkmarkColor: _primaryGreen,
                    labelStyle: TextStyle(
                      color: active ? _primaryGreen : _textDark,
                      fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                    ),
                    onSelected: (val) => setModalState(() {
                      val ? chosen.add(item) : chosen.remove(item);
                    }),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add a quick note about today...',
                  hintStyle: TextStyle(color: _textMuted, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: _primaryGreen),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _saveCheckIn(
                      mood: _selectedMood,
                      symptoms: chosen.toList(),
                      notes: noteController.text.trim(),
                    );
                  },
                  child: const Text('Save Check-in', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final startWeek = (_currentWeek - 2).clamp(1, 36);
    final visibleWeeks = List.generate(5, (i) => startWeek + i);

    final milestone = _weeklyMilestones[_selectedWeek] ??
        {
          'size': 'Growing strong in week $_selectedWeek',
          'stats': 'Week $_selectedWeek of 40',
          'desc': 'Your baby continues to grow and develop new milestones each day.',
          'icon': Icons.grass_rounded,
        };

    final displayProgress = (_selectedWeek / 40).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TOP HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (Navigator.canPop(context))
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back, color: _textDark, size: 22),
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _motherName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              color: _textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Your pregnancy',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: _textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.calendar_today_outlined, size: 19, color: _textMuted),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _dueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 300)),
                        );
                        if (picked != null) {
                          _dueDate = picked;
                          _calculatePregnancyProgress();
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // 2. WEEK SELECTOR CARDS
              Row(
                children: visibleWeeks.map((week) {
                  final isSelected = week == _selectedWeek;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedWeek = week),
                      child: Container(
                        margin: EdgeInsets.only(right: week == visibleWeeks.last ? 0 : 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? _softGreenBg : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? _primaryGreen : _borderColor,
                            width: isSelected ? 1.4 : 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'WEEK',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: isSelected ? _primaryGreen : _textMuted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$week',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? _primaryGreen : _textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // 3. BABY SIZE & PROGRESS CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEAE6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            milestone['icon'],
                            size: 38,
                            color: _primaryGreen,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_selectedWeek weeks · ${_getTrimesterLabel(_selectedWeek)}',
                                style: TextStyle(fontSize: 12, color: _textMuted),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                milestone['size'],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: _textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                milestone['stats'],
                                style: TextStyle(fontSize: 13, color: _textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: displayProgress,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFE3E4E2),
                        valueColor: AlwaysStoppedAnimation<Color>(_primaryGreen),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      milestone['desc'],
                      style: TextStyle(fontSize: 13.5, height: 1.4, color: _textDark),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Size estimates vary. Due date: ${_formatDueDate(_dueDate)}.',
                      style: TextStyle(fontSize: 12, color: _textMuted),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 4. YOUR DAILY CHECK-IN SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your daily check-in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  _buildMoodButton('Good', Icons.sentiment_satisfied_alt_outlined),
                  const SizedBox(width: 10),
                  _buildMoodButton('Okay', Icons.sentiment_neutral_outlined),
                  const SizedBox(width: 10),
                  _buildMoodButton('Low', Icons.sentiment_dissatisfied_outlined),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _showLogSheet,
                  icon: Icon(Icons.add, size: 19, color: _textDark),
                  label: Text(
                    'Log symptoms or a note',
                    style: TextStyle(color: _textDark, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: _borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // 5. THIS WEEK, FOR YOU SECTION
              Text(
                'This week, for you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.assignment_outlined, color: _textMuted, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan your next antenatal check',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ask your clinician about routine screening.',
                            style: TextStyle(fontSize: 12.5, color: _textMuted),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: _textMuted),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 6. MEDICAL DISCLAIMER BANNER
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0EE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: _textMuted),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'General guidance, not a diagnosis. If a symptom worries you, contact your maternity care team.',
                        style: TextStyle(fontSize: 12, height: 1.35, color: _textMuted),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(String label, IconData icon) {
    final isSelected = _selectedMood == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => _saveCheckIn(mood: label),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? _softGreenBg : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? _primaryGreen : _borderColor,
              width: isSelected ? 1.4 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? _primaryGreen : _textMuted),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? _primaryGreen : _textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class List {
  required String mood;
  List<String> symptoms;
}