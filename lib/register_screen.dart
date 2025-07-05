import 'package:flutter/material.dart';
import 'colors.dart';
import 'register_complete_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  String? _unit = '년'; // '년' 디폴트, '월' 추가
  String? _errorText;

  void _register() {
    final email = _emailController.text.trim();
    final pw = _pwController.text.trim();
    String career = _careerController.text.trim();
    final unit = _unit;
    // 이메일 유효성
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email) || email.length < 6) {
      setState(() {
        _errorText = '유효한 입력값이 아닙니다. 다시 입력해 주세요.';
      });
      return;
    }
    // 비밀번호 유효성
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(pw);
    final hasNumber = RegExp(r'\d').hasMatch(pw);
    final hasSpecial = RegExp(r'[!@#\$&*~]').hasMatch(pw);
    final types = [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    if (pw.length < 8 || types < 2) {
      setState(() {
        _errorText = '비밀번호는 8자 이상, 영문/숫자/특수문자 중 2가지 이상 포함해야 합니다.';
      });
      return;
    }
    // 구력 유효성
    career = career.replaceAll(RegExp(r'[^0-9]'), ''); // 숫자만 허용
    if (career.isNotEmpty && career.length > 1 && career.startsWith('0')) {
      career = career.replaceFirst(RegExp(r'^0+'), '');
      if (career.isEmpty) career = '0';
    }
    int? careerNum = int.tryParse(career);
    if (career.isEmpty || careerNum == null) {
      setState(() {
        _errorText = '구력을 입력해 주세요.';
      });
      return;
    }
    if (unit == '년') {
      if (careerNum < 1 || careerNum > 99) {
        setState(() {
          _errorText = '구력(년)은 1~99 사이로 입력해 주세요.';
        });
        return;
      }
    } else if (unit == '월') {
      if (careerNum < 1 || careerNum > 12) {
        setState(() {
          _errorText = '구력(월)은 1~12 사이로 입력해 주세요.';
        });
        return;
      }
    }
    setState(() {
      _errorText = null;
    });
    // 회원가입 완료 화면으로 이동
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegisterCompleteScreen()),
    );
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
          '회원가입',
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
                '가입정보 입력',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: '사용하실 아이디(이메일)를 입력하세요.',
                  filled: true,
                  fillColor: Colors.white,
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
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력하세요.',
                  filled: true,
                  fillColor: Colors.white,
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
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _careerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '구력',
                        filled: true,
                        fillColor: Colors.white,
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
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _unit,
                      items: const [
                        DropdownMenuItem(value: '년', child: Text('년')),
                        DropdownMenuItem(value: '월', child: Text('월')),
                      ],
                      onChanged: (v) => setState(() => _unit = v),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '가입하기',
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
                onTap: () => Navigator.of(context).pop(),
                child: const Text(
                  '이전으로',
                  style: TextStyle(
                    color: AppColors.main01,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
