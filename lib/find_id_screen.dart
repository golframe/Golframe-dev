import 'package:flutter/material.dart';
import 'colors.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;

  void _submit() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\u0000*');
    if (email.isEmpty || !emailRegex.hasMatch(email) || email.length < 6) {
      setState(() {
        _errorText = '이메일 형식 혹은 입력값이 아닙니다. 다시 입력해 주세요.';
      });
      return;
    }
    setState(() {
      _errorText = null;
    });
    // TODO: 실제 아이디 찾기 로직 추가
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const EmailSentScreen()));
  }

  void _goToRegister() {
    // TODO: 회원가입 화면으로 이동
    Navigator.of(context).pop(); // 예시: 이전 화면으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.main01),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '아이디 찾기',
          style: TextStyle(
            color: AppColors.main01,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                '아이디 찾기',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'abc@gmail.com',
                  filled: true,
                  fillColor: AppColors.main04,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.main01,
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.main01,
                      width: 1.5,
                    ),
                  ),
                  errorText: _errorText,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '제출하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _goToRegister,
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    color: AppColors.main01,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              // 하단 탭바 예시
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _TabBarIcon(icon: Icons.home, label: '홈'),
                  _TabBarIcon(icon: Icons.menu, label: '요약본'),
                  _TabBarIcon(icon: Icons.attach_money, label: '요금제'),
                  _TabBarIcon(icon: Icons.person, label: '마이'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({Key? key}) : super(key: key);

  void _goToLogin(BuildContext context) {
    // TODO: 로그인 화면으로 이동 (예시: 첫 화면으로 이동)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          '전송 완료',
          style: TextStyle(
            color: AppColors.main01,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                '인증메일 전송이 완료되었습니다!',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              const Text(
                '이메일 전송이 완료되었습니다.\n메일함을 확인해주시기 바랍니다.',
                style: TextStyle(color: AppColors.grey02, fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text(
                '다만, 이메일이 일치하지 않을 경우,\n메일 전송이 불가능할 수 있습니다.',
                style: TextStyle(color: AppColors.grey02, fontSize: 20),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _goToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '로그인하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _TabBarIcon(icon: Icons.home, label: '홈'),
                  _TabBarIcon(icon: Icons.menu, label: '요약본'),
                  _TabBarIcon(icon: Icons.attach_money, label: '요금제'),
                  _TabBarIcon(icon: Icons.person, label: '마이'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TabBarIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.grey01, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.grey01, fontSize: 14),
        ),
      ],
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  String? _errorText;

  void _resetPassword() {
    final pw = _pwController.text.trim();
    final pwConfirm = _pwConfirmController.text.trim();
    // 영문, 숫자, 특수문자 중 2가지 이상 포함, 6~20자
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(pw);
    final hasNumber = RegExp(r'\d').hasMatch(pw);
    final hasSpecial = RegExp(r'[!@#\$&*~]').hasMatch(pw);
    final types = [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    if (pw.length < 6 || pw.length > 20 || types < 2) {
      setState(() {
        _errorText = '비밀번호는 영문, 숫자, 특수문자 중 2개 이상을 포함해야 하며, 최소 6자~최대 20자여야 합니다.';
      });
      return;
    }
    if (pw != pwConfirm) {
      setState(() {
        _errorText = '새로운 비밀번호가 일치하지 않습니다.';
      });
      return;
    }
    setState(() {
      _errorText = null;
    });
    // 실제 비밀번호 재설정 로직 추가 후, 비밀번호 변경 완료 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PasswordResetCompleteScreen(),
      ),
    );
  }

  void _goToLogin() {
    // TODO: 로그인 화면으로 이동
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.main01),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            color: AppColors.main01,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                '비밀번호 재설정',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '새로운 비밀번호 입력',
                  filled: true,
                  fillColor: AppColors.main04,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.main01, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.main01, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pwConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '새로운 비밀번호 재확인',
                  filled: true,
                  fillColor: AppColors.main04,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.main01, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.main01, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(
                      color: AppColors.mainRed06,
                      fontSize: 16,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '재설정하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _goToLogin,
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: AppColors.main01,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _TabBarIcon(icon: Icons.home, label: '홈'),
                  _TabBarIcon(icon: Icons.menu, label: '요약본'),
                  _TabBarIcon(icon: Icons.attach_money, label: '요금제'),
                  _TabBarIcon(icon: Icons.person, label: '마이'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordResetCompleteScreen extends StatelessWidget {
  const PasswordResetCompleteScreen({Key? key}) : super(key: key);

  void _goToLogin(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          '재설정 완료',
          style: TextStyle(
            color: AppColors.main01,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                '비밀번호가 변경되었습니다.',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '비밀번호 재설정이 완료되었습니다.\n변경된 비밀번호로 서비스를 이용해주세요.',
                style: TextStyle(color: AppColors.grey01, fontSize: 20),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _goToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _TabBarIcon(icon: Icons.home, label: '홈'),
                  _TabBarIcon(icon: Icons.menu, label: '요약본'),
                  _TabBarIcon(icon: Icons.attach_money, label: '요금제'),
                  _TabBarIcon(icon: Icons.person, label: '마이'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
