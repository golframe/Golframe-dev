import 'package:flutter/material.dart';
import 'summary_detail_screen.dart';
import 'main_home_screen.dart';

class SummaryTab extends StatefulWidget {
  final String role;
  const SummaryTab({super.key, required this.role});

  @override
  State<SummaryTab> createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  // 더미 요약본 데이터
  List<Map<String, String>> summaries = [
    {
      'title': '요약본 제목 4',
      'category': '[카테고리]-하위 카테고리',
      'date': '2025.3.1',
      'type': '무료',
    },
    {
      'title': '요약본 제목 3',
      'category': '[카테고리]-하위 카테고리',
      'date': '2025.3.1',
      'type': '무료',
    },
    {
      'title': '요약본 제목 2',
      'category': '[카테고리]-하위 카테고리',
      'date': '2025.3.1',
      'type': '무료',
    },
    {
      'title': '요약본 제목 1',
      'category': '[카테고리]-하위 카테고리',
      'date': '2025.3.1',
      'type': '무료',
    },
  ];

  int? deleteIndex; // 삭제할 인덱스
  bool showDeleteComplete = false;

  void _goToPlanTab() {
    final mainState = context.findAncestorStateOfType<MainHomeScreenState>();
    if (mainState != null && mainState.mounted) {
      mainState.setState(() {
        mainState.selectedIndex = 2;
      });
    }
  }

  void _showDeleteDialog(int idx) async {
    setState(() {
      deleteIndex = idx;
    });
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Center(
              child: Text(
                '안내',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            content: const Text(
              '요약본을 정말 삭제하시겠어요?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop('cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD1E3D3),
                        foregroundColor: const Color(0xFF1A3C34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('취소'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop('delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176B5A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('삭제하기'),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
    if (result == 'delete') {
      setState(() {
        summaries.removeAt(idx);
        showDeleteComplete = true;
      });
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Center(
                child: Text(
                  '안내',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              content: const Text(
                '요약본 삭제가 완료되었습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF176B5A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('닫기'),
                  ),
                ),
              ],
            ),
      );
      setState(() {
        showDeleteComplete = false;
      });
    }
    setState(() {
      deleteIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == '무료회원') {
      // 무료회원: 안내 메시지 + 업그레이드 버튼
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          const Text(
            '요약본',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Color(0xFF176B5A),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '요약본 목록',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFF176B5A),
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              '해당 기능은 프로 요금제 사용자만 이용하실 수 있습니다.\n이용을 원하신다면, 요금제를 업그레이드 해주세요.\n또는, 로그인 후 이용해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton(
              onPressed: _goToPlanTab,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '업그레이드',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    } else {
      // 유료회원: 요약본 리스트
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        children: [
          const Center(
            child: Text(
              '요약본',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color(0xFF176B5A),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              '요약본 목록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF176B5A),
              ),
            ),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < summaries.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SummaryDetailScreen(
                                    image: 'assets/video1.png',
                                    title: summaries[i]['title']!,
                                    desc: summaries[i]['category']!,
                                    summary: ['요약1', '요약2', '요약3'],
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          summaries[i]['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        summaries[i]['category']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${summaries[i]['date']}  ${summaries[i]['type']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 36,
                                child: OutlinedButton(
                                  onPressed: () => _showDeleteDialog(i),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF1BC17B),
                                    ),
                                    foregroundColor: const Color(0xFF1BC17B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    '삭제',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 100,
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder:
                                          (ctx) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title: const Center(
                                              child: Text(
                                                '안내',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                            content: const Text(
                                              '요약본 다운로드가 완료되었습니다.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed:
                                                      () =>
                                                          Navigator.of(
                                                            ctx,
                                                          ).pop(),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF176B5A),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text('닫기'),
                                                ),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF176B5A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    '다운로드',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    }
  }
}
