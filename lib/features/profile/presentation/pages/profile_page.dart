import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinksy/features/authentication/data/services/auth_service.dart';
import 'package:thinksy/features/home/presentation/pages/home_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signOut();

      if (!context.mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to sign out. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'No email available';

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),

                    const SizedBox(height: 28),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Student Profile',
                          style: TextStyle(
                            color: Color(0xFF191522),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        _SemesterBadge(),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _buildProfileCard(email),

                    const SizedBox(height: 20),

                    _buildPreferencesCard(),

                    const SizedBox(height: 18),

                    _buildSignOutCard(context),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        'Thinksy · Fontys Edition',
                        style: TextStyle(
                          color: Color(0xFFAAA3AE),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const _ProfileBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
      ],
    );
  }

  Widget _buildProfileCard(String email) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF74316F),
            Color(0xFF4A214B),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF211D23),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: -2,
                    bottom: -2,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Color(0xFF18C879),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STUDENT',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 9,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Thinksy Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  value: '2/5',
                  label: 'OOP Lessons',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ProfileStat(
                  value: '2/5',
                  label: 'SOLID Topics',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ProfileStat(
                  value: '94%',
                  label: 'Sync Score',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFF0E8F1),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'APPLICATION PREFERENCES',
            style: TextStyle(
              color: Color(0xFFAAA3AE),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),

          SizedBox(height: 20),

          _PreferenceRow(
            icon: Icons.cloud_download_outlined,
            title: 'Offline content',
            subtitle: 'Available offline: OOP & SOLID',
            trailing: Text(
              '3 ready',
              style: TextStyle(
                color: Color(0xFF16A866),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Divider(
            height: 28,
            color: Color(0xFFF2EDF3),
          ),

          _PreferenceRow(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'System appearance mode',
            trailing: _FakeSwitch(),
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutCard(BuildContext context) {
    return InkWell(
      onTap: () => _signOut(context),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFF0E8F1),
          ),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFFFEEF2),
              child: Icon(
                Icons.logout_rounded,
                color: Color(0xFFFF315C),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color(0xFFFF315C),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'End session on this mobile device',
                    style: TextStyle(
                      color: Color(0xFFFF7992),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFFF5271),
            ),
          ],
        ),
      ),
    );
  }
}

class _SemesterBadge extends StatelessWidget {
  const _SemesterBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EAF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Semester 1',
        style: TextStyle(
          color: Color(0xFF8A5B84),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _PreferenceRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFF8EFFA),
          child: Icon(
            icon,
            color: Color(0xFF8C3285),
            size: 20,
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF332B36),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFAAA3AE),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        trailing,
        const SizedBox(width: 5),
        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFB7B0BA),
          size: 20,
        ),
      ],
    );
  }
}

class _FakeSwitch extends StatelessWidget {
  const _FakeSwitch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E1E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: CircleAvatar(
          radius: 8,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class _ProfileBottomNavigation extends StatelessWidget {
  const _ProfileBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF0E8F1),
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ProfileNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          const _ProfileNavItem(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Chat',
          ),
          const _ProfileNavItem(
            icon: Icons.menu_book_outlined,
            label: 'Learn',
          ),
          const _ProfileNavItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            selected: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _ProfileNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFF7C276F)
        : const Color(0xFFAAA3AE);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 30,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFF7EAF5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}