import 'package:flutter/material.dart';
import 'main_home_screen.dart';

class VideoDetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final String desc;
  final List<String> summary;
  final String role;
  const VideoDetailScreen({
    required this.image,
    required this.title,
    required this.desc,
    required this.summary,
    required this.role,
    super.key,
  });

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  bool isProMember = true; // 유료회원으로 기본값 변경
  int currentTabIndex = 0;

  void _showSavePopup() async {
    if (widget.role == '무료회원') {
      await showDialog<String>(
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
                '현재 무료 요금제를 사용하고 계십니다.\n요약본 저장을 위해서는 프로 요금제로 업그레이드가 필요합니다.\n요금제를 변경하시겠습니까?',
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
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop('go_plan');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176B5A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('변경하기'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      );
    } else {
      await showDialog<String>(
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
                '요약본 저장이 완료되었습니다.',
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
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop('go_summary');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176B5A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('확인하기'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      );
    }
  }

  Widget _buildTabContent() {
    switch (currentTabIndex) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '핵심 정리',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '김국진의 골프 레슨을 통해 스윙의 원리와 효과적인 기법을 배울 수 있습니다. 접었다 폈다 펼치는 스윙동작을 강조하며, 손목과 몸의 움직임을 이해하면 더 나은 결과를 얻을 수 있습니다. 이 레슨은 초보자부터 프로까지 모든 골퍼에게 유용한 기술과 정보를 제공합니다.\n특히 몸의 각 부분이 어떻게 작용하는지를 알면 스윙의 정확성과 거리를 향상시킬 수 있습니다. 강의 중 솔직한 접근과 실용적인 팁이 돋보이며, 골프의 매력을 한층 더 느끼게 합니다.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '내용',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '1. 김국진의 골프 스윙 이해하기\n\n골프의 다양한 상황에서 스윙을 어떻게 해야 할까에 대한 인식이 중요합니다. 여러 과정을 경험하며 티샷, 그린, 벙커 샷 등을 연습해야 합니다.\n손목과 팔목의 움직임, 그리고 몸의 꺾임이 스윙에 미치는 영향을 고려해야 한다. 팔과 어깨의 움직임도 연결되어 스윙을 완성할 수 있습니다.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1. 골프 레슨 소개',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 인사 및 배경 설명:'),
              const Text('  상사는 골프에 대한 관심을 표하며, 앞으로의 레슨에 대한 기대감을 나타낸다.'),
              const Text('  프로/스타트의 성취와 경험을 바탕으로 레슨을 진행할 것임을 강조한다.'),
              const Text('- 레슨의 목표:'),
              const Text('  스윙의 기초를 이해하고, 이를 통해 성적 향상을 목표로 하는 것이 포인트이다.'),
              const Text('  다양한 상황에 맞는 스윙의 요령이 다름.'),
              const SizedBox(height: 12),
              const Text(
                '2. 스윙의 기본 원리',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 스윙의 구성: 사방의 동세에서 꺾어지는 부분에 대한 이해가 필요하다.'),
              const Text('- 팔목과 어깨의 움직임, 꺾임이 스윙에 미치는 영향 설명.'),
              const SizedBox(height: 12),
              const Text(
                '3. 손목의 역할',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 손목은 스윙의 핵심 요소로, 꺾임의 방향과 유연성이 중요하다.'),
              const Text('- 손목의 꺾임과 함께 팔과 어깨의 움직임도 중요.'),
              const SizedBox(height: 12),
              const Text(
                '4. 접었다 폈다의 중요성',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 스윙은 접었다가 펴는 동작으로 이루어진다.'),
              const Text('- 골프 선수는 스윙 시 몸을 접었다가 펴는 과정을 반복한다.'),
              const SizedBox(height: 12),
              const Text(
                '5. 임팩트 순간의 기술',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 임팩트의 정의: 클럽과 공이 접촉하는 순간의 의미.'),
              const Text('- 임팩트 순간의 스윙 성공 여부를 결정짓는 요소 설명.'),
              const SizedBox(height: 12),
              const Text(
                '6. 자신감 있는 스윙',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 아이언 샷의 중요성, 거리와 방향성의 핵심.'),
              const Text('- 자신감 있는 스윙이 결과적으로 더 나은 성적을 가져온다.'),
              const SizedBox(height: 12),
              const Text(
                '7. 결론 및 요약',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text('- 스윙의 원리 요약: 접었다 폈다의 동작, 손목의 역할, 정확성 강조.'),
              const Text('- 스윙의 기술적 요소: 협력, 자신감, 방향성 등.'),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/mindmap_example.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF176B5A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '영상 상세',
          style: TextStyle(
            color: Color(0xFF176B5A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 썸네일
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.black12,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              // 제목
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 요약(타임라인)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  widget.desc,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: [
                    for (int i = 0; i < widget.summary.length; i++)
                      Text(
                        '${i + 1}. ${widget.summary[i]}',
                        style: const TextStyle(fontSize: 14),
                      ),
                  ],
                ),
              ),
              // 탭바(버튼 그룹)
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    _SegmentButton(
                      label: '흐름잡기',
                      selected: currentTabIndex == 0,
                      onTap: () => setState(() => currentTabIndex = 0),
                    ),
                    const SizedBox(width: 8),
                    _SegmentButton(
                      label: '핵심요약',
                      selected: currentTabIndex == 1,
                      onTap: () => setState(() => currentTabIndex = 1),
                    ),
                    const SizedBox(width: 8),
                    _SegmentButton(
                      label: '마인드맵',
                      selected: currentTabIndex == 2,
                      onTap: () => setState(() => currentTabIndex = 2),
                    ),
                  ],
                ),
              ),
              // 탭 컨텐츠
              Expanded(child: _buildTabContent()),
            ],
          ),
          // 하단 저장하기 버튼 + 탭바
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _showSavePopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176B5A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '저장하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Color(0xFF176B5A),
                  unselectedItemColor: Color(0xFFB0B0B0),
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  currentIndex: 0,
                  onTap: (i) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MainHomeScreen(role: widget.role),
                        settings: RouteSettings(arguments: i),
                      ),
                    );
                  },
                  items:
                      widget.role == '프로회원'
                          ? const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: '홈',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.menu),
                              label: '요약본',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.inventory_2),
                              label: '추천상품',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: '마이',
                            ),
                          ]
                          : const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: '홈',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.menu),
                              label: '요약본',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.attach_money),
                              label: '요금제',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: '마이',
                            ),
                          ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const _SegmentButton({
    required this.label,
    required this.selected,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF176B5A) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF176B5A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
