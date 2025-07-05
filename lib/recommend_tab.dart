import 'package:flutter/material.dart';

class RecommendTab extends StatelessWidget {
  final String role;
  const RecommendTab({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    if (role != '프로회원') {
      return const Center(
        child: Text('프로 요금제 사용자만 이용할 수 있습니다.', style: TextStyle(fontSize: 18)),
      );
    }
    // 더미 상품 데이터
    final products = [
      {
        'image': 'assets/video1.png',
        'name': '볼빅 맥스 스피드 X 플래그 라인 골프공',
        'price': '19,800원',
        'videoThumb': 'assets/video1.png',
      },
      {
        'image': 'assets/video2.png',
        'name': '스릭슨 신형 소프트필 골프공 2피스',
        'price': '15,800원',
        'videoThumb': 'assets/video2.png',
      },
      {
        'image': 'assets/video1.png',
        'name': '볼빅 맥스 스피드 X 플래그 라인 골프공',
        'price': '19,800원',
        'videoThumb': 'assets/video1.png',
      },
      {
        'image': 'assets/video2.png',
        'name': '스릭슨 신형 소프트필 골프공 2피스',
        'price': '15,800원',
        'videoThumb': 'assets/video2.png',
      },
    ];
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      children: [
        const SizedBox(height: 0),
        const Center(
          child: Text(
            '추천상품',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            '추천 상품',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            '저장한 영상(요약본)에 등장한 골프 용품 정보를 알려드립니다.',
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) {
              final p = products[i];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        p['image']!,
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: Text(
                        p['name']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                      child: Text(
                        p['price']!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                      child: const Text(
                        '해당 영상',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          p['videoThumb']!,
                          height: 40,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
