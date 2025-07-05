import 'package:flutter/material.dart';
import 'login_screen.dart';

class MyTab extends StatelessWidget {
  final String role;
  final String nickname;
  final String joinDate;
  final String plan;
  final VoidCallback onGoToPlanTab;
  const MyTab({
    super.key,
    required this.role,
    required this.nickname,
    required this.joinDate,
    required this.plan,
    required this.onGoToPlanTab,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      children: [
        const SizedBox(height: 0),
        const Center(
          child: Text(
            '마이페이지',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            '$nickname 님',
            style: const TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '가입일 : $joinDate / $plan',
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(height: 32),
        _SectionTitle('계정관리'),
        _MyDivider(),
        _MenuItem(title: '정보수정', onTap: () {}),
        _MenuItem(title: '비밀번호 변경', onTap: () {}),
        const SizedBox(height: 32),
        _SectionTitle('결제관리'),
        _MyDivider(),
        _MenuItem(title: '구독 내역', onTap: () {}),
        _MenuItem(
          title: '요금제 변경',
          onTap: role == '무료회원' ? onGoToPlanTab : null,
          enabled: role == '무료회원',
        ),
        const SizedBox(height: 32),
        _SectionTitle('서비스'),
        _MyDivider(),
        _MenuItem(title: '이용약관', onTap: () {}),
        _MenuItem(title: '개인정보처리방침', onTap: () {}),
        const SizedBox(height: 40),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: const Text(
              '로그아웃',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF176B5A),
        ),
      ),
    );
  }
}

class _MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0));
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool enabled;
  const _MenuItem({required this.title, this.onTap, this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right),
      enabled: enabled,
      onTap: enabled ? onTap : null,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
