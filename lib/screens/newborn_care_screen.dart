import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
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

  // Function: Filter lessons based on category & search text
  List<Lesson> get _filteredLessons {
    return sampleLessons.where((lesson) {
      final matchesCategory = _selectedCategoryIndex == 0 ||
          lesson.category == _categories[_selectedCategoryIndex];
      final matchesSearch =
          lesson.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _filteredLessons;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LEARN · ONE STEP AT A TIME', style: AppTextStyles.overline),
                    SizedBox(height: 6),
                    Text('Newborn care', style: AppTextStyles.heading1),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border, size: 20, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: AppColors.textTertiary),
                  hintText: 'Search newborn care topics',
                  hintStyle: AppTextStyles.caption,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_categories.length, (index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? AppColors.textPrimary : AppColors.textTertiary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.surface,
                      backgroundColor: AppColors.cardSubtle,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.borderMedium : Colors.transparent,
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

            // Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cardSubtle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_book_outlined, size: 18, color: AppColors.textSecondary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Preparing for later? Save a lesson now and come back when your baby arrives.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Start with the essentials', style: AppTextStyles.sectionHeader),
                Text('${lessons.length} lessons', style: AppTextStyles.caption),
              ],
            ),
            const SizedBox(height: 12),

            // Lesson Cards
            if (lessons.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text('No lessons found matching your filter.', style: AppTextStyles.caption),
                ),
              )
            else
              ...lessons.map((lesson) => _buildLessonCard(context, lesson)),

            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Educational sample content. Follow the advice of your own\nmaternity or newborn care team.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textTertiary, fontSize: 11, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildLessonCard(BuildContext context, Lesson lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.cardSubtle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(lesson.icon, color: AppColors.textSecondary, size: 24),
        ),
        title: Text(lesson.title, style: AppTextStyles.cardTitle),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${lesson.category} · ${lesson.format}\n⏱ ${lesson.duration}${lesson.isSaved ? ' · Saved' : ''}',
            style: const TextStyle(color: AppColors.textTertiary, fontSize: 12, height: 1.3),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFFC7C7CC)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorialDetailScreen(lesson: lesson),
            ),
          ).then((_) => setState(() {}));
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1, // 'Learn' is selected
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.textPrimary,
      unselectedItemColor: AppColors.textTertiary,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Learn'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Care'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Community'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
      ],
    );
  }
}