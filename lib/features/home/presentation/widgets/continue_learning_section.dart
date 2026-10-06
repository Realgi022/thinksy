import 'package:flutter/material.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF0E5F1),
        ),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 4,
                backgroundColor: Color(0xFFE90083),
              ),
              SizedBox(width: 8),
              Text(
                'CONTINUE LEARNING',
                style: TextStyle(
                  color: Color(0xFF332A37),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'Semester 1',
                style: TextStyle(
                  color: Color(0xFFA81778),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: const [
              Expanded(
                child: _LearningCard(
                  title: 'OOP',
                  icon: Icons.code_rounded,
                  progress: 0.4,
                  lessons: '2/5',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _LearningCard(
                  title: 'Solid Principles',
                  icon: Icons.tag_rounded,
                  progress: 0.4,
                  lessons: '2/5',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double progress;
  final String lessons;

  const _LearningCard({
    required this.title,
    required this.icon,
    required this.progress,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF0E4F3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF7B317E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF2A222E),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lessons',
                style: TextStyle(
                  color: Color(0xFF817985),
                  fontSize: 9,
                ),
              ),
              Text(
                lessons,
                style: const TextStyle(
                  color: Color(0xFF6D2769),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFEADCEA),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF7C276F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}