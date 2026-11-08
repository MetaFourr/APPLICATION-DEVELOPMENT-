import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/lesson_model.dart';

class TutorialDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const TutorialDetailScreen({super.key, required this.lesson});

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  // Function: Toggle Saved state
  void _toggleBookmark() {
    setState(() {
      widget.lesson.isSaved = !widget.lesson.isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.lesson.isSaved ? 'Lesson saved to bookmarks' : 'Lesson removed from bookmarks',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Function: Toggle Lesson Completion
  void _toggleComplete() {
    setState(() {
      widget.lesson.isCompleted = !widget.lesson.isCompleted;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.lesson.isCompleted ? 'Marked as completed!' : 'Marked as incomplete',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                widget.lesson.isSaved ? Icons.bookmark : Icons.bookmark_border,
                size: 20,
                color: AppColors.textPrimary,
              ),
              onPressed: _toggleBookmark,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Text(
            'NEWBORN CARE · ${widget.lesson.category.toUpperCase()}',
            style: AppTextStyles.overline,
          ),
          const SizedBox(height: 6),
          Text(
            widget.lesson.title,
            style: AppTextStyles.heading1,
          ),
          const SizedBox(height: 14),

          // Badges
          Row(
            children: [
              _buildBadge(Icons.play_circle_outline, '${widget.lesson.duration} video'),
              const SizedBox(width: 8),
              _buildBadge(null, 'Beginner'),
              if (widget.lesson.isSaved) ...[
                const SizedBox(width: 8),
                _buildBadge(Icons.bookmark, 'Saved'),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Video placeholder box
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.cardSubtle,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(widget.lesson.icon, size: 36, color: AppColors.textTertiary),
                        const SizedBox(width: 18),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.textTertiary, width: 1.5),
                          ),
                          child: const Icon(Icons.play_arrow, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 18),
                        const Icon(Icons.thermostat_outlined, size: 28, color: AppColors.textTertiary),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Illustrated lesson - preview', style: AppTextStyles.caption),
                  ],
                ),
                const Positioned(
                  bottom: 12,
                  left: 14,
                  right: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0:00 / 6:12', style: TextStyle(color: AppColors.textTertiary, fontSize: 10)),
                      Icon(Icons.fullscreen, color: AppColors.textTertiary, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'HiMommy! education team · Sample lesson',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 6),
          Text(widget.lesson.description, style: AppTextStyles.body),
          const SizedBox(height: 24),

          // What you'll learn header
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("What you'll learn", style: AppTextStyles.sectionHeader),
              Text('Transcript', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 14),

          // Steps list
          ...widget.lesson.steps.asMap().entries.map((entry) {
            final idx = entry.key + 1;
            final textParts = entry.value.split('\n');
            return Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderMedium),
                    ),
                    child: Text(
                      '$idx',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textParts[0],
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary),
                        ),
                        if (textParts.length > 1) ...[
                          const SizedBox(height: 2),
                          Text(textParts[1], style: AppTextStyles.caption),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),

          // Notice Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cardSubtle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, size: 18, color: AppColors.textSecondary),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Never leave your baby alone in water, even for a moment. Keep supplies within arm’s reach.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Button
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(
                color: widget.lesson.isCompleted ? Colors.green : AppColors.borderMedium,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: Icon(
              widget.lesson.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: widget.lesson.isCompleted ? Colors.green : AppColors.textPrimary,
            ),
            label: Text(
              widget.lesson.isCompleted ? 'Lesson Completed' : 'Mark lesson as complete',
              style: TextStyle(
                color: widget.lesson.isCompleted ? Colors.green : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: _toggleComplete,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData? icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.cardSubtle,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: AppColors.textSecondary),
            const SizedBox(width: 4),
          ],
          Text(text, style: AppTextStyles.badge),
        ],
      ),
    );
  }
}