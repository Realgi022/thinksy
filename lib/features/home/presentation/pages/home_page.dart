import 'package:flutter/material.dart';

import '../widgets/continue_learning_section.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_header.dart';
import '../widgets/semester_card.dart';
import '../widgets/thinksy_chat_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    HomeHeader(),

                    SizedBox(height: 30),

                    Text(
                      'Good morning, student 👋',
                      style: TextStyle(
                        color: Color(0xFF191522),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'What are we learning today?',
                      style: TextStyle(
                        color: Color(0xFF8B8493),
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 70),

                    ThinksyChatCard(),

                    SizedBox(height: 55),

                    SemesterCard(),

                    SizedBox(height: 65),

                    ContinueLearningSection(),
                  ],
                ),
              ),
            ),

            HomeBottomNav(),
          ],
        ),
      ),
    );
  }
}