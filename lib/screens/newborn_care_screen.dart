import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import 'tutorial_detail_screen.dart';

class NewbornCareScreen extends StatefulWidget {
  const NewbornCareScreen({super.key});

  @override
  State<NewbornCareScreen> createState() => _NewbornCareScreenState();
}

class _NewbornCareScreenState extends State<NewbornCareScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'Feeding', 'Sleep', 'Hygiene'];
  String _searchQuery = '';
  bool _showSavedOnly = false;
  final TextEditingController _searchController = TextEditingController();

  // Soft Pink / Rose Aesthetic Palette (matches AccountScreen)
  static const Color _bgColor = Color(0xFFFFF7F8);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _borderColor = Color(0xFFF6DFE4);
  static const Color _primaryPink = Color(0xFFD95D78);
  static const Color _softPink = Color(0xFFFDECEF);
  static const Color _textPrimary = Color(0xFF2A1B20);
  static const Color _textSecondary = Color(0xFF856B72);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter lessons based on category, search text, and saved filter
  List<Lesson> get _filteredLessons {
    return sampleLessons.where((lesson) {
      final matchesCategory = _selectedCategoryIndex == 0 ||
          lesson.category == _categories[_selectedCategoryIndex];
      final matchesSearch =
          lesson.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSaved = !_showSavedOnly || lesson.isSaved;
      return matchesCategory && matchesSearch && matchesSaved;
    }).toList();
  }

  int get _savedCount => sampleLessons.where((l) => l.isSaved).length;

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

  // Category-specific soft badge styling
  Map<String, Color> _getCategoryColors(String category) {
    switch (category) {
      case 'Feeding':
        return {
          'bg': const Color(0xFFFDECEF),
          'icon': const Color(0xFFD95D78),
        };
      case 'Sleep':
        return {
          'bg': const Color(0xFFF3ECFF),
          'icon': const Color(0xFF8B68C7),
        };
      case 'Hygiene':
        return {
          'bg': const Color(0xFFFFF0EB),
          'icon': const Color(0xFFE07A5F),
        };
      default:
        return {
          'bg': _softPink,
          'icon': _primaryPink,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _filteredLessons;

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LEARN · ONE STEP AT A TIME',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        color: _primaryPink,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Newborn care',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                  ],
                ),
                // Interactive Saved Filter Button with Counter Badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: _showSavedOnly ? _primaryPink : _cardColor,
                        border: Border.all(
                          color: _showSavedOnly ? _primaryPink : _borderColor,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryPink.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        tooltip: _showSavedOnly
                            ? 'Show all lessons'
                            : 'Show saved lessons',
                        icon: Icon(
                          _showSavedOnly
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          size: 21,
                          color: _showSavedOnly ? Colors.white : _primaryPink,
                        ),
                        onPressed: () {
                          setState(() {
                            _showSavedOnly = !_showSavedOnly;
                          });
                          _showSnack(_showSavedOnly
                              ? 'Showing saved lessons only'
                              : 'Showing all lessons');
                        },
                      ),
                    ),
                    if (_savedCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: _showSavedOnly ? _textPrimary : _primaryPink,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Text(
                            '$_savedCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Search Bar with Clear Action
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _borderColor),
                boxShadow: [
                  BoxShadow(
                    color: _primaryPink.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                style: const TextStyle(color: _textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search_rounded, color: _primaryPink),
                  hintText: 'Search newborn care topics...',
                  hintStyle: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded,
                              size: 18, color: _textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_categories.length, (index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : _textSecondary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: _primaryPink,
                      backgroundColor: _cardColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? _primaryPink : _borderColor,
                        ),
                      ),
                      onSelected: (val) {
                        setState(() => _selectedCategoryIndex = index);
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // Soft Rose Gradient Tip Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFDECEF), Color(0xFFFFF0F3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _borderColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      size: 18,
                      color: _primaryPink,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Preparing for later? Tap the bookmark icon on any guide to save it for when baby arrives.',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section Header & Lesson Count Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showSavedOnly
                      ? 'Your saved guides'
                      : 'Start with the essentials',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _softPink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${lessons.length} ${lessons.length == 1 ? 'lesson' : 'lessons'}',
                    style: const TextStyle(
                      color: _primaryPink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Lesson Cards or Empty State
            if (lessons.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.search_off_rounded,
                        size: 36, color: _primaryPink),
                    const SizedBox(height: 10),
                    const Text(
                      'No lessons found',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Try clearing your search or switching categories.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: _textSecondary),
                    ),
                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _selectedCategoryIndex = 0;
                          _showSavedOnly = false;
                        });
                      },
                      child: const Text(
                        'Reset filters',
                        style: TextStyle(
                          color: _primaryPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...lessons.map((lesson) => _buildLessonCard(context, lesson)),

            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Educational sample content. Follow the advice of your own\nmaternity or newborn care team.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, Lesson lesson) {
    final badgeColors = _getCategoryColors(lesson.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: _primaryPink.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorialDetailScreen(lesson: lesson),
            ),
          ).then((_) => setState(() {}));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Category-Tinted Icon Container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: badgeColors['bg'],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  lesson.icon,
                  color: badgeColors['icon'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              // Title & Metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${lesson.category} · ${lesson.format}',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 13, color: _primaryPink),
                        const SizedBox(width: 4),
                        Text(
                          lesson.duration,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (lesson.isSaved) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: _softPink,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Saved',
                              style: TextStyle(
                                color: _primaryPink,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Quick Bookmark Toggle Button
              IconButton(
                icon: Icon(
                  lesson.isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: lesson.isSaved ? _primaryPink : _textSecondary,
                  size: 21,
                ),
                onPressed: () {
                  setState(() {
                    lesson.isSaved = !lesson.isSaved;
                  });
                  _showSnack(lesson.isSaved
                      ? 'Saved "${lesson.title}"'
                      : 'Removed from saved');
                },
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: _textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}