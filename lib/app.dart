import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/pages/welcome_page.dart';

class ThinksyApp extends StatelessWidget {
  const ThinksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thinksy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const WelcomePage(),
    );
  }
}