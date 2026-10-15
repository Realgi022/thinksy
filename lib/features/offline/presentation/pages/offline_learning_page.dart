
import 'package:flutter/material.dart';

import 'package:thinksy/features/offline/data/offline_lessons.dart';
import 'package:thinksy/features/offline/data/models/offline_lesson.dart';

class OfflineLearningPage extends StatefulWidget {
  const OfflineLearningPage({super.key});

  @override
  State<OfflineLearningPage> createState() =>
      _OfflineLearningPageState();
}

class _OfflineLearningPageState extends State<OfflineLearningPage> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final lessons = OfflineLessons.all.where((lesson) {
      final query = _search.toLowerCase().trim();

      return lesson.title.toLowerCase().contains(query) ||
          lesson.category.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FC),
      appBar: AppBar(
        title: const Text('Offline Learning'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF7C276F),
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.offline_bolt_rounded,
                      color: Color(0xFF7C276F),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Learn without internet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore lessons, think through questions, '
                  'and reveal hints when you need them.',
                ),
                const SizedBox(height: 18),
                TextField(
                  onChanged: (value) {
                    setState(() => _search = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search lessons...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: lessons.isEmpty
                ? const Center(
                    child: Text('No lessons found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];

                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFF4EAF3),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: Color(0xFF7C276F),
                            ),
                          ),
                          title: Text(
                            lesson.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(lesson.category),
                          trailing:
                              const Icon(Icons.chevron_right_rounded),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    OfflineLessonPage(lesson: lesson),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class OfflineLessonPage extends StatefulWidget {
  final OfflineLesson lesson;

  const OfflineLessonPage({
    super.key,
    required this.lesson,
  });

  @override
  State<OfflineLessonPage> createState() =>
      _OfflineLessonPageState();
}

class _OfflineLessonPageState extends State<OfflineLessonPage> {
  bool _showHint = false;
  bool _showExplanation = false;

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FC),
      appBar: AppBar(
        title: Text(lesson.title),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF7C276F),
        surfaceTintColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            lesson.category,
            style: const TextStyle(
              color: Color(0xFF7C276F),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            lesson.introduction,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _lessonCard(
            title: 'Think about it 🤔',
            content: lesson.question,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              setState(() => _showHint = !_showHint);
            },
            icon: const Icon(Icons.lightbulb_outline_rounded),
            label: Text(
              _showHint ? 'Hide hint' : 'Reveal hint',
            ),
          ),
          if (_showHint) ...[
            const SizedBox(height: 12),
            _lessonCard(
              title: 'A little hint 💡',
              content: lesson.hint,
            ),
          ],
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() => _showExplanation = !_showExplanation);
            },
            icon: const Icon(Icons.menu_book_rounded),
            label: Text(
              _showExplanation
                  ? 'Hide explanation'
                  : 'Explain further',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C276F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(14),
            ),
          ),
          if (_showExplanation) ...[
            const SizedBox(height: 12),
            _lessonCard(
              title: 'Explanation 📖',
              content: lesson.explanation,
            ),
          ],
        ],
      ),
    );
  }

  Widget _lessonCard({
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADCE8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C276F),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
