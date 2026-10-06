import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Thinksy',
                    style: TextStyle(
                      color: Color(0xFF7C276F),
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFFE80083),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                'FONTYS UNIVERSITY',
                style: TextStyle(
                  color: Color(0xFFC34B9D),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE9FFF5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFC7F4DF),
            ),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 4,
                backgroundColor: Color(0xFF14B86E),
              ),
              SizedBox(width: 6),
              Text(
                'Fontys Sync',
                style: TextStyle(
                  color: Color(0xFF16895B),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE8E1EA),
            ),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            size: 20,
            color: Color(0xFF696170),
          ),
        ),
      ],
    );
  }
}