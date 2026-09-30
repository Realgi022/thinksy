import 'package:flutter/material.dart';
import 'package:thinksy/core/constants/app_colors.dart';

class ThinksyHeader extends StatelessWidget {
  const ThinksyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceTransparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white24,
                ),
              ),
              child: const Icon(
                Icons.psychology_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              'Thinksy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'AI',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),

        Container(
          width: 52,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white38,
              ),
              SizedBox(width: 4),
              CircleAvatar(
                radius: 3,
                backgroundColor: AppColors.primary,
              ),
              SizedBox(width: 4),
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white38,
              ),
            ],
          ),
        ),
      ],
    );
  }
}