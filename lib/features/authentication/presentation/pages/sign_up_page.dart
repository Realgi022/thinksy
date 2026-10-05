import 'package:flutter/material.dart';
import 'package:thinksy/core/constants/app_colors.dart';
import 'package:thinksy/features/authentication/presentation/widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                const SizedBox(height: 12),

                Text(
                  'Join Thinksy and start learning smarter.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 32),

                const SignUpForm(),

                const SizedBox(height: 24),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // Sign in navigation later.
                    },
                    child: const Text(
                      'Already have an account? Sign in',
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