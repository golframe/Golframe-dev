import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String email;
  final String nickname;
  final String career;
  const EditProfileScreen({
    super.key,
    required this.email,
    required this.nickname,
    required this.career,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isEditingPassword = false;
  bool isEditingNickname = false;
  bool isEditingCareer = false;
  String nickname = '';
  String password = '';
  String career = '';
  String careerUnit = '년';
  String? errorText;
  bool showNicknameDone = false;
  bool showCareerDone = false;

  @override
  void initState() {
    super.initState();
    nickname = widget.nickname;
    career = widget.career;
  }

  void _showDonePopup(String type) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            content: Text(
              type == 'nickname' ? '닉네임 수정이 완료되었습니다.' : '구력 수정이 완료되었습니다.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          ),
    );
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
          '정보수정',
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
              '정보수정',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF176B5A),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildLabel('아이디'),
          _buildReadOnlyField(widget.email),
          const SizedBox(height: 24),
          _buildLabel('비밀번호'),
          Row(
            children: [
              Expanded(child: _buildReadOnlyField('**********')),
              const SizedBox(width: 12),
              _buildActionButton(
                isEditingPassword ? '변경완료' : '변경하기',
                enabled: !isEditingNickname && !isEditingCareer,
                onPressed:
                    !isEditingNickname && !isEditingCareer
                        ? () {
                          setState(() {
                            isEditingPassword = !isEditingPassword;
                          });
                        }
                        : null,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLabel('닉네임'),
          Row(
            children: [
              Expanded(
                child:
                    isEditingNickname
                        ? TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: nickname),
                          onChanged: (v) => nickname = v,
                        )
                        : _buildReadOnlyField(nickname),
              ),
              const SizedBox(width: 12),
              _buildActionButton(
                isEditingNickname ? '수정완료' : '수정하기',
                enabled: !isEditingPassword && !isEditingCareer,
                onPressed:
                    !isEditingPassword && !isEditingCareer
                        ? () {
                          if (isEditingNickname) {
                            if (nickname.trim().isEmpty) {
                              setState(() {
                                errorText = '닉네임을 입력해주세요.';
                              });
                              return;
                            }
                            setState(() {
                              isEditingNickname = false;
                              errorText = null;
                            });
                            _showDonePopup('nickname');
                          } else {
                            setState(() {
                              isEditingNickname = true;
                              errorText = null;
                            });
                          }
                        }
                        : null,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLabel('구력'),
          Row(
            children: [
              Expanded(
                child:
                    isEditingCareer
                        ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '구력',
                                ),
                                onChanged: (v) => career = v,
                              ),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: careerUnit,
                              items: const [
                                DropdownMenuItem(value: '년', child: Text('년')),
                                DropdownMenuItem(
                                  value: '개월',
                                  child: Text('개월'),
                                ),
                              ],
                              onChanged: (v) {
                                setState(() {
                                  careerUnit = v!;
                                });
                              },
                            ),
                          ],
                        )
                        : _buildReadOnlyField('$career $careerUnit'),
              ),
              const SizedBox(width: 12),
              _buildActionButton(
                isEditingCareer ? '수정완료' : '수정하기',
                enabled: !isEditingPassword && !isEditingNickname,
                onPressed:
                    !isEditingPassword && !isEditingNickname
                        ? () {
                          if (isEditingCareer) {
                            if (career.trim().isEmpty) {
                              setState(() {
                                errorText = '구력을 입력해주세요.';
                              });
                              return;
                            }
                            setState(() {
                              isEditingCareer = false;
                              errorText = null;
                            });
                            _showDonePopup('career');
                          } else {
                            setState(() {
                              isEditingCareer = true;
                              errorText = null;
                            });
                          }
                        }
                        : null,
              ),
            ],
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                '회원 탈퇴하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF176B5A),
                ),
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

  Widget _buildReadOnlyField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildActionButton(
    String text, {
    required bool enabled,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 110,
      height: 48,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? const Color(0xFF176B5A) : Colors.grey[400],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
