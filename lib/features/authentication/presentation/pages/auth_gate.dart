import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:thinksy/features/home/presentation/pages/home_page.dart';
import 'package:thinksy/features/onboarding/presentation/pages/welcome_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Firebase is checking the stored authentication session.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Firebase has a signed-in user.
        if (snapshot.hasData) {
          return const HomePage();
        }

        // No user is signed in.
        return const WelcomePage();
      },
    );
  }
}