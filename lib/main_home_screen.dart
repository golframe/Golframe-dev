import 'package:flutter/material.dart';
import 'colors.dart';
import 'video_detail_screen.dart';
import 'summary_tab.dart';
import 'plan_tab.dart';
import 'recommend_tab.dart';
import 'my_tab.dart';

class MainHomeScreen extends StatefulWidget {
  final String role; // '무료회원' 또는 '프로회원'
  const MainHomeScreen({super.key, required this.role});

  @override
  State<MainHomeScreen> createState() => MainHomeScreenState();
}

class MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int && args != selectedIndex) {
      setState(() {
        selectedIndex = args;
      });
    }
  }

  // 무료회원: 홈-요약본-요금제-마이, 프로회원: 홈-요약본-추천상품-마이
  List<_TabItem> get _tabs =>
      widget.role == '프로회원'
          ? [
            _TabItem('홈', Icons.home, _HomeTab(onGoToDetail: _goToDetail)),
            _TabItem('요약본', Icons.menu, SummaryTab(role: widget.role)),
            _TabItem(
              '추천상품',
              Icons.inventory_2,
              RecommendTab(role: widget.role),
            ),
            _TabItem(
              '마이',
              Icons.person,
              MyTab(
                role: widget.role,
                nickname: 'ab333',
                joinDate: '2025.03.01',
                plan: widget.role == '프로회원' ? '프로 요금제' : '무료 요금제',
                onGoToPlanTab:
                    () => setState(() {
                      selectedIndex = 2;
                    }),
              ),
            ),
          ]
          : [
            _TabItem('홈', Icons.home, _HomeTab(onGoToDetail: _goToDetail)),
            _TabItem('요약본', Icons.menu, SummaryTab(role: widget.role)),
            _TabItem('요금제', Icons.attach_money, PlanTab()),
            _TabItem(
              '마이',
              Icons.person,
              MyTab(
                role: widget.role,
                nickname: 'ab333',
                joinDate: '2025.03.01',
                plan: widget.role == '프로회원' ? '프로 요금제' : '무료 요금제',
                onGoToPlanTab:
                    () => setState(() {
                      selectedIndex = 2;
                    }),
              ),
            ),
          ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            const SizedBox(height: 32),
            SizedBox(
              height: 48,
              child: Image.asset(
                'assets/golframe_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Divider(height: 1, color: AppColors.light01),
          ],
        ),
      ),
      body: _tabs[selectedIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.main01,
        unselectedItemColor: AppColors.grey01,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i),
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label),
        ],
      ),
    );
  }

  Future<void> _goToDetail(
    String image,
    String title,
    String desc,
    List<String> summary,
  ) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => VideoDetailScreen(
              image: image,
              title: title,
              desc: desc,
              summary: summary,
              role: widget.role,
            ),
      ),
    );
    if (result == 'go_summary') {
      setState(() {
        selectedIndex = 1;
      });
    } else if (result == 'go_plan') {
      setState(() {
        selectedIndex = 2;
      });
    }
  }
}

class _TabItem {
  final String label;
  final IconData icon;
  final Widget screen;
  _TabItem(this.label, this.icon, this.screen);
}

class _HomeTab extends StatefulWidget {
  final Future<void> Function(String, String, String, List<String>)
  onGoToDetail;
  const _HomeTab({required this.onGoToDetail});
  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearched = false;
  bool _hasResult = false;
  String? _errorText;

  void _onSearch() {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      setState(() {
        _isSearched = false;
        _hasResult = false;
        _errorText = '검색어를 반드시 입력해주세요';
      });
      return;
    }
    if (keyword == '김국진 골프 레슨') {
      setState(() {
        _isSearched = true;
        _hasResult = true;
        _errorText = null;
      });
    } else {
      setState(() {
        _isSearched = true;
        _hasResult = false;
        _errorText = '검색어가 존재하지 않습니다.';
      });
    }
  }

  void _onClear() {
    setState(() {
      _searchController.clear();
      _isSearched = false;
      _hasResult = false;
      _errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        // 검색창
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요.',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon:
                            _searchController.text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _onClear,
                                )
                                : null,
                        filled: true,
                        fillColor: AppColors.light02,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {}); // suffixIcon 갱신용
                      },
                      onSubmitted: (_) => _onSearch(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                      onPressed: _onSearch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.main01,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
        if (_isSearched && _hasResult) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Text(
              '검색 결과',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          _VideoCard(
            image: 'assets/video1.png',
            title: '김국진의 어프로치',
            desc: '김국진의 스윙은 어떻게 나오는 걸까? 김국진의 골프레슨!',
            summary: const [
              '스윙의 기본 원리',
              '손목의 역할',
              '점잖다 폈다의 중요성',
              '임팩트 순간의 기술',
              '아이언 샷과 자신감 있는 스윙',
              '최종 정리 및 영상 마무리',
            ],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video1.png',
                  '김국진의 어프로치',
                  '김국진의 스윙은 어떻게 나오는 걸까? 김국진의 골프레슨!',
                  const [
                    '스윙의 기본 원리',
                    '손목의 역할',
                    '점잖다 폈다의 중요성',
                    '임팩트 순간의 기술',
                    '아이언 샷과 자신감 있는 스윙',
                    '최종 정리 및 영상 마무리',
                  ],
                ),
          ),
          _VideoCard(
            image: 'assets/video2.png',
            title: '김국진 골프 특강 #1',
            desc: '드라이버 레슨과 김국진의 골프 스타일',
            summary: const [
              '드라이버 레슨과 김국진의 골프 스타일',
              '멈추지 않는 스윙의 중요성',
              '골프 드라이버 스윙 요령',
            ],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video2.png',
                  '김국진 골프 특강 #1',
                  '드라이버 레슨과 김국진의 골프 스타일',
                  const [
                    '드라이버 레슨과 김국진의 골프 스타일',
                    '멈추지 않는 스윙의 중요성',
                    '골프 드라이버 스윙 요령',
                  ],
                ),
          ),
          _VideoCard(
            image: 'assets/video3.png',
            title: '백스윙의 3포인트',
            desc: '백스윙 딱 이 3가지만 알고계세요!! 김국진 백스윙의 모든것!',
            summary: const ['백스윙의 중요 요소', '백스윙 연습의 중요 포인트', '백스윙의 기본 원리'],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video3.png',
                  '백스윙의 3포인트',
                  '백스윙 딱 이 3가지만 알고계세요!! 김국진 백스윙의 모든것!',
                  const ['백스윙의 중요 요소', '백스윙 연습의 중요 포인트', '백스윙의 기본 원리'],
                ),
          ),
          _VideoCard(
            image: 'assets/video4.png',
            title: '양용은프로의 원포인트 레슨',
            desc: '양용은 프로가 알려주는 스윙 연습 비법! 연습할 때 이것 하나만 있으면 충분!?',
            summary: const [
              '안정된 스윙을 위한 원리',
              '골프채를 이용한 양용은의 스윙 연습 방법',
              '방향 설정의 중요성',
            ],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video4.png',
                  '양용은프로의 원포인트 레슨',
                  '양용은 프로가 알려주는 스윙 연습 비법! 연습할 때 이것 하나만 있으면 충분!?',
                  const [
                    '안정된 스윙을 위한 원리',
                    '골프채를 이용한 양용은의 스윙 연습 방법',
                    '방향 설정의 중요성',
                  ],
                ),
          ),
        ] else ...[
          // 기존 홈 탭 기본 영상 카드들
          _VideoCard(
            image: 'assets/video1.png',
            title: '김국진의 어프로치',
            desc: '김국진의 스윙은 어떻게 나오는 걸까? 김국진의 골프레슨!',
            summary: const [
              '스윙의 역할',
              '점잖다 폈다의 중요성',
              '아이언 샷과 자신감 있는 스윙',
              '정리 및 영상 마무리',
            ],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video1.png',
                  '김국진의 어프로치',
                  '김국진의 스윙은 어떻게 나오는 걸까? 김국진의 골프레슨!',
                  const [
                    '스윙의 역할',
                    '점잖다 폈다의 중요성',
                    '아이언 샷과 자신감 있는 스윙',
                    '정리 및 영상 마무리',
                  ],
                ),
          ),
          _VideoCard(
            image: 'assets/video2.png',
            title: '김국진 골프 특강 #1',
            desc: '드라이버 레슨과 김국진의 골프 스타일',
            summary: const ['드라이버 대충 쳐도 잘 나가는 법', '골프 드라이버 스윙 요령'],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video2.png',
                  '김국진 골프 특강 #1',
                  '드라이버 레슨과 김국진의 골프 스타일',
                  const ['드라이버 대충 쳐도 잘 나가는 법', '골프 드라이버 스윙 요령'],
                ),
          ),
          _VideoCard(
            image: 'assets/video3.png',
            title: '백스윙의 3포인트',
            desc: '백스윙 딱 이 3가지만 알고계세요!! 김국진 백스윙의 모든것!',
            summary: const ['백스윙의 중요 요소', '백스윙 연습의 중요 포인트', '백스윙의 기본 원리'],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video3.png',
                  '백스윙의 3포인트',
                  '백스윙 딱 이 3가지만 알고계세요!! 김국진 백스윙의 모든것!',
                  const ['백스윙의 중요 요소', '백스윙 연습의 중요 포인트', '백스윙의 기본 원리'],
                ),
          ),
          _VideoCard(
            image: 'assets/video4.png',
            title: '양용은프로의 원포인트 레슨',
            desc: '양용은 프로가 알려주는 스윙 연습 비법! 연습할 때 이것 하나만 있으면 충분!?',
            summary: const [
              '안정된 스윙을 위한 원리',
              '골프채를 이용한 양용은의 스윙 연습 방법',
              '방향 설정의 중요성',
            ],
            onTap:
                () => widget.onGoToDetail(
                  'assets/video4.png',
                  '양용은프로의 원포인트 레슨',
                  '양용은 프로가 알려주는 스윙 연습 비법! 연습할 때 이것 하나만 있으면 충분!?',
                  const [
                    '안정된 스윙을 위한 원리',
                    '골프채를 이용한 양용은의 스윙 연습 방법',
                    '방향 설정의 중요성',
                  ],
                ),
          ),
        ],
      ],
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final List<String> summary;
  final VoidCallback? onTap;
  const _VideoCard({
    required this.image,
    required this.title,
    required this.desc,
    required this.summary,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(desc, style: const TextStyle(color: AppColors.grey01)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < summary.length; i++)
                Text(
                  '${i + 1}. ${summary[i]}',
                  style: const TextStyle(fontSize: 15),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
