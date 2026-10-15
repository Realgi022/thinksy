
import 'package:flutter/material.dart';

import 'package:thinksy/core/constants/app_colors.dart';
import 'package:thinksy/features/offline/presentation/pages/offline_learning_page.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/mascot_section.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/thinksy_header.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/welcome_actions.dart';
import 'package:thinksy/features/onboarding/presentation/widgets/welcome_content.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _continueOffline(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OfflineLearningPage(),
      ),
    );
  }

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thinksy header
                        const ThinksyHeader(),

                        const SizedBox(height: 30),

                        // AI mascot
                        const Center(
                          child: MascotSection(),
                        ),

                        const SizedBox(height: 24),

                        // Welcome title and description
                        const WelcomeContent(),

                        // Keeps actions toward the bottom
                        // when there is enough space.
                        const Spacer(),

                        const SizedBox(height: 28),

                        // Existing Get Started and Sign In
                        const WelcomeActions(),

                        const SizedBox(height: 12),

                        // Continue Offline button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () => _continueOffline(context),
                            icon: const Icon(
                              Icons.wifi_off_rounded,
                              size: 20,
                            ),
                            label: const Text(
                              'Continue Offline',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.white70,
                                width: 1.3,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Center(
                          child: Text(
                            'No account or internet connection required',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Footer
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
              );
            },
          ),
        ),
      ),
    );
  }
}
