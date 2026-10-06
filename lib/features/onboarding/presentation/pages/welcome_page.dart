import 'package:flutter/material.dart';
import 'package:thinksy/core/constants/app_colors.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/mascot_section.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/thinksy_header.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/welcome_actions.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/welcome_content.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundTop,
              AppColors.backgroundMiddle,
              AppColors.backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ThinksyHeader(),

                const SizedBox(height: 40),

                const Center(
                  child: MascotSection(),
                ),

                const SizedBox(height: 32),

                const WelcomeContent(),

                const Spacer(),

                const WelcomeActions(),

                const SizedBox(height: 12),

                const Center(
                  child: Text(
                    'Powered by Fontys AI · Student Learning Companion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}