import 'package:flutter/material.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your personal\nAI learning tutor',
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        const SizedBox(height: 16),

        Text(
          'Learn smarter with an AI companion that guides you '
          'with hints, questions, and explanations instead of '
          'simply giving you the answer.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}