import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String category;
  final String format;
  final String duration;
  bool isSaved;
  bool isCompleted;
  final IconData icon;
  final String description;
  final List<String> steps;

  Lesson({
    required this.title,
    required this.category,
    required this.format,
    required this.duration,
    this.isSaved = false,
    this.isCompleted = false,
    required this.icon,
    required this.description,
    required this.steps,
  });
}

// Sample content
final List<Lesson> sampleLessons = [
  Lesson(
    title: "Your baby's first bath",
    category: 'Hygiene',
    format: 'Step-by-step video',
    duration: '6 min',
    isSaved: true,
    icon: Icons.bathtub_outlined,
    description:
        'A calm, gentle routine for bath time, with practical tips for holding your baby securely.',
    steps: [
      'Get everything ready\nTowel, clean nappy and a warm room.',
      'Check the water & support baby\nUse warm, not hot water; support the head.',
      'Wash gently, then dry & dress\nClean creases carefully and keep baby warm.',
    ],
  ),
  Lesson(
    title: 'Breastfeeding: a comfortable latch',
    category: 'Feeding',
    format: 'Illustrated guide',
    duration: '8 min',
    isSaved: false,
    icon: Icons.face_outlined,
    description:
        'Understand positioning and signs of a deep, painless latch during early feeds.',
    steps: [
      'Find a comfortable posture for yourself.',
      'Bring baby to breast, nose level with nipple.',
      'Wait for a wide open mouth before latching.',
    ],
  ),
  Lesson(
    title: 'A safer space for sleep',
    category: 'Sleep',
    format: 'Essential checklist',
    duration: '4 min',
    isSaved: false,
    icon: Icons.bedtime_outlined,
    description:
        'Create a sleep environment that supports safe, peaceful rest for your newborn.',
    steps: [
      'Back to sleep on a firm, flat mattress.',
      'Keep cot clear of loose blankets, pillows, and toys.',
      'Maintain a comfortable room temperature.',
    ],
  ),
  Lesson(
    title: 'Nappy changes & cord care',
    category: 'Hygiene',
    format: 'Step-by-step video',
    duration: '5 min',
    isSaved: false,
    icon: Icons.clean_hands_outlined,
    description:
        'Keep the umbilical stump clean and dry while mastering quick, mess-free diaper changes.',
    steps: [
      'Clean from front to back with warm water or wipes.',
      'Fold nappy waistband below the umbilical clamp.',
      'Keep the cord area clean, dry, and exposed to air.',
    ],
  ),
];