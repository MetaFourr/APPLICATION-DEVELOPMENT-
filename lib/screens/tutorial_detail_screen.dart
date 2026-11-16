import 'dart:async';
import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

class TutorialDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const TutorialDetailScreen({super.key, required this.lesson});

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  // Soft Pink / Rose Aesthetic Palette (matches Account & NewbornCare screens)
  static const Color _bgColor = Color(0xFFFFF7F8);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _borderColor = Color(0xFFF6DFE4);
  static const Color _primaryPink = Color(0xFFD95D78);
  static const Color _softPink = Color(0xFFFDECEF);
  static const Color _accentPeach = Color(0xFFFFF0EB);
  static const Color _textPrimary = Color(0xFF2A1B20);
  static const Color _textSecondary = Color(0xFF856B72);

  // Interactive UI States
  final Set<int> _checkedSteps = {};
  bool _isPlaying = false;
  double _videoProgress = 0.0;
  bool _showTranscript = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Pre-check all steps if lesson was already marked completed
    if (widget.lesson.isCompleted) {
      for (int i = 0; i < widget.lesson.steps.length; i++) {
        _checkedSteps.add(i);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showRoseSnack(String message) {
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

  void _toggleBookmark() {
    setState(() {
      widget.lesson.isSaved = !widget.lesson.isSaved;
    });
    _showRoseSnack(
      widget.lesson.isSaved
          ? 'Lesson saved to bookmarks'
          : 'Lesson removed from bookmarks',
    );
  }

  void _toggleComplete() {
    setState(() {
      widget.lesson.isCompleted = !widget.lesson.isCompleted;
      if (widget.lesson.isCompleted) {
        for (int i = 0; i < widget.lesson.steps.length; i++) {
          _checkedSteps.add(i);
        }
      } else {
        _checkedSteps.clear();
      }
    });
    _showRoseSnack(
      widget.lesson.isCompleted
          ? 'Marked as completed!'
          : 'Marked as incomplete',
    );
  }

  void _togglePlayVideo() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
        if (!mounted) return;
        setState(() {
          if (_videoProgress >= 1.0) {
            _videoProgress = 0.0;
            _isPlaying = false;
            timer.cancel();
          } else {
            _videoProgress += 0.015;
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  String get _formattedElapsedTime {
    final totalSeconds = (_videoProgress * 372).round(); // 6:12 = 372 sec
    final mins = totalSeconds ~/ 60;
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  double get _stepsCompletionRatio {
    if (widget.lesson.steps.isEmpty) return 0.0;
    return _checkedSteps.length / widget.lesson.steps.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: _textPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: widget.lesson.isSaved ? _primaryPink : _cardColor,
              border: Border.all(
                color: widget.lesson.isSaved ? _primaryPink : _borderColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                widget.lesson.isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                size: 20,
                color: widget.lesson.isSaved ? Colors.white : _primaryPink,
              ),
              onPressed: _toggleBookmark,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        children: [
          Text(
            'NEWBORN CARE · ${widget.lesson.category.toUpperCase()}',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: _primaryPink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.lesson.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),

          // Aesthetic Pill Badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge(
                Icons.play_circle_outline_rounded,
                '${widget.lesson.duration} ${widget.lesson.format.toLowerCase()}',
              ),
              _buildBadge(Icons.auto_awesome_rounded, 'Beginner'),
              if (widget.lesson.isSaved)
                _buildBadge(Icons.bookmark_rounded, 'Saved', isHighlighted: true),
              if (widget.lesson.isCompleted)
                _buildBadge(Icons.check_circle_rounded, 'Completed', isHighlighted: true),
            ],
          ),
          const SizedBox(height: 18),

          // Interactive Illustrated Video Preview Box
          GestureDetector(
            onTap: _togglePlayVideo,
            child: Container(
              height: 195,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFFDECEF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _borderColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: _primaryPink.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              widget.lesson.icon,
                              size: 28,
                              color: _primaryPink,
                            ),
                          ),
                          const SizedBox(width: 18),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
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
                            child: Icon(
                              _isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite_border_rounded,
                              size: 24,
                              color: _primaryPink,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isPlaying
                            ? 'Playing illustrated walkthrough...'
                            : 'Tap to preview illustrated lesson',
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _videoProgress,
                            minHeight: 4,
                            backgroundColor: Colors.white,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              _primaryPink,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$_formattedElapsedTime / 6:12',
                              style: const TextStyle(
                                color: _textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.fullscreen_rounded,
                              color: _primaryPink,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Author & Description Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: _softPink,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: _primaryPink,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'HiMommy! education team · Sample lesson',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryPink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.lesson.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // What you'll learn header + Interactive Progress & Transcript toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "What you'll learn",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _showTranscript = !_showTranscript;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _showTranscript ? _primaryPink : _softPink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 14,
                        color: _showTranscript ? Colors.white : _primaryPink,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Transcript',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _showTranscript ? Colors.white : _primaryPink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Live Step Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: _stepsCompletionRatio,
                    minHeight: 6,
                    backgroundColor: _softPink,
                    valueColor: const AlwaysStoppedAnimation<Color>(_primaryPink),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${_checkedSteps.length}/${widget.lesson.steps.length} steps',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _primaryPink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Optional Expandable Transcript Card
          if (_showTranscript) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _softPink,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _borderColor),
              ),
              child: Text(
                'Quick Summary: ${widget.lesson.description} Follow each step below at your own pace and tap any step card to check it off as you practice.',
                style: const TextStyle(
                  fontSize: 13,
                  color: _textPrimary,
                  height: 1.45,
                ),
              ),
            ),
          ],

          // Interactive Tappable Steps List (Uses widget.lesson.steps)
          ...widget.lesson.steps.asMap().entries.map((entry) {
            final index = entry.key;
            final idx = index + 1;
            final textParts = entry.value.split('\n');
            final isChecked = _checkedSteps.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isChecked) {
                    _checkedSteps.remove(index);
                  } else {
                    _checkedSteps.add(index);
                  }
                  widget.lesson.isCompleted =
                      _checkedSteps.length == widget.lesson.steps.length;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12.0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isChecked ? const Color(0xFFFFF0F3) : _cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isChecked ? _primaryPink : _borderColor,
                    width: isChecked ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryPink.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isChecked ? _primaryPink : _softPink,
                        shape: BoxShape.circle,
                      ),
                      child: isChecked
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: Colors.white,
                            )
                          : Text(
                              '$idx',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _primaryPink,
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textParts[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: isChecked ? _primaryPink : _textPrimary,
                            ),
                          ),
                          if (textParts.length > 1) ...[
                            const SizedBox(height: 4),
                            Text(
                              textParts[1],
                              style: const TextStyle(
                                fontSize: 13,
                                color: _textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 10),

          // Safety Notice Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _accentPeach,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF5D5C8)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 20,
                  color: Color(0xFFD96B43),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Never leave your baby alone in water, even for a moment. Keep supplies within arm’s reach.',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Primary Action Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.lesson.isCompleted
                    ? const Color(0xFF4CAF7D)
                    : _primaryPink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: Icon(
                widget.lesson.isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: Colors.white,
              ),
              label: Text(
                widget.lesson.isCompleted
                    ? 'Lesson Completed'
                    : 'Mark lesson as complete',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _toggleComplete,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData? icon, String text, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlighted ? _primaryPink : _softPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: isHighlighted ? Colors.white : _primaryPink,
            ),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isHighlighted ? Colors.white : _primaryPink,
            ),
          ),
        ],
      ),
    );
  }
}