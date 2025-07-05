import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  String? errorText;

  void _onChangePassword() {
    final current = _currentPwController.text.trim();
    final newPw = _newPwController.text.trim();
    final confirm = _confirmPwController.text.trim();
    if (current.isEmpty || newPw.isEmpty || confirm.isEmpty) {
      setState(() {
        errorText = '모든 항목을 입력해주세요.';
      });
      return;
    }
    if (newPw != confirm) {
      setState(() {
        errorText = '새 비밀번호가 일치하지 않습니다.';
      });
      return;
    }
    // 실제 비밀번호 변경 로직은 서버 연동 필요
    setState(() {
      errorText = null;
    });
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            content: const Text('비밀번호가 성공적으로 변경되었습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          ),
    );
    _currentPwController.clear();
    _newPwController.clear();
    _confirmPwController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF176B5A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              '비밀번호 변경',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF176B5A),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildLabel('현재 비밀번호'),
          _buildPasswordField(_currentPwController, '현재 사용중인 비밀번호를 입력하세요.'),
          const SizedBox(height: 24),
          _buildLabel('새 비밀번호'),
          _buildPasswordField(_newPwController, '새롭게 사용할 비밀번호를 입력하세요.'),
          const SizedBox(height: 24),
          _buildLabel('새 비밀번호 확인'),
          _buildPasswordField(_confirmPwController, '새로운 비밀번호를 다시 한 번 입력하세요.'),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _onChangePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176B5A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '변경하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
      ),
    );
  }
}
