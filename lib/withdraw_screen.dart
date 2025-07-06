import 'package:flutter/material.dart';
import 'withdraw_complete_screen.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  bool agreed = false;

  void _onWithdraw() {
    // TODO: 실제 탈퇴 처리 후 완료 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WithdrawCompleteScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '회원탈퇴',
          style: TextStyle(
            color: Color(0xFF176B5A),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF176B5A)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              '회원탈퇴',
              style: TextStyle(
                color: Color(0xFF176B5A),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '유의사항',
              style: TextStyle(
                color: Color(0xFF176B5A),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '회원 탈퇴 후 계정 및 모든 개인 정보가 삭제되며 복구가 불가능합니다.\n\n탈퇴 후 동일한 이메일로 재가입이 제한됩니다.',
              style: TextStyle(
                color: Color(0xFF8B95A1),
                fontSize: 18,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: agreed,
                  onChanged: (v) => setState(() => agreed = v ?? false),
                  activeColor: const Color(0xFF176B5A),
                ),
                const Expanded(
                  child: Text(
                    '탈퇴 유의사항을 확인하였으며, 이에 동의합니다.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: ElevatedButton(
                onPressed: agreed ? _onWithdraw : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06635C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '탈퇴하기',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
