import 'package:flutter/material.dart';
import 'colors.dart';
import 'find_id_screen.dart';
import 'terms_agreement_screen.dart';
import 'main_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isRememberId = false;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  '로그인',
                  style: TextStyle(
                    color: AppColors.main01,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: AppColors.light01, thickness: 1, height: 1),
                const SizedBox(height: 32),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    hintText: '아이디(이메일) 입력',
                    filled: true,
                    fillColor: AppColors.main04,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.main01,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
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
                    hintText: '비밀번호 입력',
                    filled: true,
                    fillColor: AppColors.main04,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.main01,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.main01,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _isRememberId,
                      onChanged: (value) {
                        setState(() {
                          _isRememberId = value ?? false;
                        });
                      },
                      activeColor: AppColors.main01,
                    ),
                    const Text(
                      '아이디 저장',
                      style: TextStyle(color: AppColors.dark03),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FindIdScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(color: AppColors.main01),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(color: AppColors.main01),
                      ),
                    ),
                  ],
                ),
                if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _errorText!,
                      style: const TextStyle(
                        color: AppColors.mainRed06,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      final id = _idController.text.trim();
                      final pw = _pwController.text.trim();
                      String? role;
                      if (id == 'abc@golf.kr' && pw == '12345!') {
                        role = '무료회원';
                      } else if (id == 'def@golf.kr' && pw == '12345!') {
                        role = '프로회원';
                      }
                      if (role != null) {
                        setState(() {
                          _errorText = null;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MainHomeScreen(role: role!),
                          ),
                        );
                      } else {
                        setState(() {
                          _errorText = '아이디 또는 비밀번호가 올바르지 않습니다.';
                        });
                      }
                    },
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
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TermsAgreementScreen(),
                      ),
                    );
                  },
                  child: Text(
                    '회원가입',
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
      ),
    );
  }
}
