import 'package:flutter/material.dart';

class SummaryDetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final String desc;
  final List<String> summary;
  const SummaryDetailScreen({
    required this.image,
    required this.title,
    required this.desc,
    required this.summary,
    super.key,
  });

  @override
  State<SummaryDetailScreen> createState() => _SummaryDetailScreenState();
}

class _SummaryDetailScreenState extends State<SummaryDetailScreen> {
  int currentTabIndex = 0;

  void _showDownloadPopup() async {
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
              '다운로드가 완료되었습니다.',
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
                  '요약본의 핵심 내용을 정리합니다. 실제 데이터 연동 시 이 부분을 교체하세요.',
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
                  '요약본의 상세 내용을 여기에 표시합니다.',
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
                '1. 요약본 소개',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text('- 요약본의 배경 및 목적 설명', style: TextStyle(fontSize: 15)),
              const SizedBox(height: 16),
              const Text(
                '2. 주요 내용',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text(
                '- 요약본의 주요 항목 및 요점 정리',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 16),
              const Text(
                '3. 결론 및 요약',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text('- 요약본의 결론 및 활용 방안', style: TextStyle(fontSize: 15)),
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
          '요약본 상세',
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
              // 제목/설명/요약(영상 상세와 동일하게 중앙 정렬)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
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
          // 하단 다운로드 버튼
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _showDownloadPopup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176B5A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '다운로드',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
