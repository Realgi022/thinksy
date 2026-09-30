import 'package:flutter/material.dart';
import 'package:thinksy/core/constants/app_colors.dart';

class MascotSection extends StatelessWidget {
  const MascotSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.35),
            Colors.transparent,
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.smart_toy_rounded,
          size: 120,
          color: Colors.white,
        ),
      ),
    );
  }
}