import 'package:flutter/material.dart';
import 'package:thinksy/core/theme/app_theme.dart';
import 'package:thinksy/features/authentication/presentation/pages/auth_gate.dart';

class ThinksyApp extends StatelessWidget {
  const ThinksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thinksy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthGate(),
    );
  }
}