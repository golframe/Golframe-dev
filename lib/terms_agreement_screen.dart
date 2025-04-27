import 'package:flutter/material.dart';
import 'colors.dart';
import 'register_screen.dart';

class TermsAgreementScreen extends StatefulWidget {
  const TermsAgreementScreen({Key? key}) : super(key: key);

  @override
  State<TermsAgreementScreen> createState() => _TermsAgreementScreenState();
}

class _TermsAgreementScreenState extends State<TermsAgreementScreen> {
  bool allChecked = false;
  bool ageChecked = false;
  bool serviceChecked = false;
  bool privacyChecked = false;
  bool marketingChecked = false;

  void _onAllChecked(bool? value) {
    setState(() {
      allChecked = value ?? false;
      ageChecked = allChecked;
      serviceChecked = allChecked;
      privacyChecked = allChecked;
      marketingChecked = allChecked;
    });
  }

  void _onIndividualChecked() {
    setState(() {
      allChecked =
          ageChecked && serviceChecked && privacyChecked && marketingChecked;
    });
  }

  bool get isNextEnabled => ageChecked && serviceChecked && privacyChecked;

  void _showDetail(BuildContext context, String title, String content) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TermsDetailScreen(title: title, content: content),
      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                '서비스 이용약관에\n동의해 주세요',
                style: TextStyle(
                  color: AppColors.main01,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                value: allChecked,
                onChanged: _onAllChecked,
                title: const Text('아래 약관에 모두 동의합니다.'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.main01,
              ),
              const Divider(height: 32),
              CheckboxListTile(
                value: ageChecked,
                onChanged: (v) {
                  setState(() {
                    ageChecked = v ?? false;
                  });
                  _onIndividualChecked();
                },
                title: const Text('(필수) 만 14세 이상입니다.'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.main01,
              ),
              CheckboxListTile(
                value: serviceChecked,
                onChanged: (v) {
                  setState(() {
                    serviceChecked = v ?? false;
                  });
                  _onIndividualChecked();
                },
                title: Row(
                  children: [
                    const Expanded(child: Text('(필수) 서비스 이용약관에 동의합니다.')),
                    GestureDetector(
                      onTap:
                          () => _showDetail(context, '서비스이용약관', _serviceTerms),
                      child: const Text(
                        '보기',
                        style: TextStyle(
                          color: AppColors.main01,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.main01,
              ),
              CheckboxListTile(
                value: privacyChecked,
                onChanged: (v) {
                  setState(() {
                    privacyChecked = v ?? false;
                  });
                  _onIndividualChecked();
                },
                title: Row(
                  children: [
                    const Expanded(child: Text('(필수) 개인정보 수집 및 이용에 동의합니다.')),
                    GestureDetector(
                      onTap:
                          () => _showDetail(
                            context,
                            '개인정보 수집 및 이용 동의',
                            _privacyTerms,
                          ),
                      child: const Text(
                        '보기',
                        style: TextStyle(
                          color: AppColors.main01,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.main01,
              ),
              CheckboxListTile(
                value: marketingChecked,
                onChanged: (v) {
                  setState(() {
                    marketingChecked = v ?? false;
                  });
                  _onIndividualChecked();
                },
                title: Row(
                  children: [
                    const Expanded(child: Text('(선택) 제3자 정보 이용에 동의합니다.')),
                    GestureDetector(
                      onTap:
                          () => _showDetail(
                            context,
                            '마케팅정보 수신동의',
                            _marketingTerms,
                          ),
                      child: const Text(
                        '보기',
                        style: TextStyle(
                          color: AppColors.main01,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.main01,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      isNextEnabled
                          ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '다음으로',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: AppColors.main01,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  const TermsDetailScreen({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.main01,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: const TextStyle(fontSize: 18, color: AppColors.dark01),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main01,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

// 약관 전문 예시(실제 내용으로 교체 필요)
const String _serviceTerms = '''서비스이용약관 전문 내용입니다.\n...''';
const String _privacyTerms = '''개인정보 수집 및 이용 동의 전문 내용입니다.\n...''';
const String _marketingTerms = '''마케팅정보 수신동의 전문 내용입니다.\n...''';
